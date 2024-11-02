const db = require('../config/db.config');
const Room = require('./room.model');

const Booking = {
  create: (booking, callback) => {
    db.query('INSERT INTO bookings SET ?', booking, callback);
  },

  findByUserId: (userId, callback) => {
    db.query('SELECT * FROM bookings WHERE user_id = ?', [userId], callback);
  },

  // history for each role
  getAllBooking: (userId, role, callback) => {
    let sql;
    switch (role) {
      case "student": // student => return only approver name
        sql = 'SELECT r.room_name, b.slot, b.status, b.reason, b.booking_date, u.username AS booked_by, a.username AS approved_by FROM bookings b INNER JOIN rooms r ON b.room_id = r.id INNER JOIN users u ON b.user_id = u.id LEFT JOIN users a ON b.approved_by = a.id WHERE u.id = ?'
        break;
      case "approver": // approver => return only student name
        sql = 'SELECT r.room_name, b.slot, b.status, b.reason, b.booking_date, u.username AS booked_by, a.username AS approved_by FROM bookings b INNER JOIN rooms r ON b.room_id = r.id INNER JOIN users u ON b.user_id = u.id LEFT JOIN users a ON b.approved_by = a.id WHERE a.id = ?'
        break;
      case "staff": // staff => return both name
        sql = 'SELECT r.room_name, b.slot, b.status, b.reason, b.booking_date, u.username AS booked_by, a.username AS approved_by FROM bookings b INNER JOIN rooms r ON b.room_id = r.id INNER JOIN users u ON b.user_id = u.id LEFT JOIN users a ON b.approved_by = a.id'
        break;
    }

    db.query(sql, [userId], callback);
  },

  // for student
  // get current booking request
  getPending: (userId, callback) => {
    db.query('SELECT r.room_name, r.desc, r.image, b.slot, b.status FROM rooms as r INNER JOIN bookings as b ON b.room_id = r.id WHERE b.user_id = ?', [userId], callback);
  },
  // cancel request
  cancelRequest: (userId, room_id, slot, callback) => {
    db.query('UPDATE bookings SET status = "cancel" WHERE user_id = ? and status = "pending"', userId, (err, result) => {
      if (err) {return callback(err)}
      const updateSlot = {[slot]: "free"};
      const roomID = {["id"]: room_id};
      db.query('UPDATE rooms SET ? where ?', [updateSlot, roomID], callback);
    });
  },

  // เพิ่มฟังก์ชันสำหรับ Approver
  approveBooking: (bookingId, approverId, callback) => {
    this.updateStatus(bookingId, 'approved', approverId, callback);
  },

  rejectBooking: (bookingId, approverId, callback) => {
    this.updateStatus(bookingId, 'rejected', approverId, callback);
  },

  updateStatus: (bookingId, status, approverId, callback) => {
    console.log('Updating booking status for bookingId:', bookingId, 'to status:', status);

    // ตรวจสอบประเภทข้อมูลก่อน
    if (typeof bookingId !== 'number' || typeof status !== 'string' || typeof approverId !== 'number') {
      console.error('Invalid data types:', { bookingId, status, approverId });
      return callback(new Error('Invalid data types'));
    }

    // ตรวจสอบว่า approverId มีอยู่ใน users
    db.query('SELECT * FROM users WHERE id = ?', [approverId], (err, results) => {
      if (err) {
        console.error('Error checking approver ID:', err);
        return callback(err);
      }

      if (results.length === 0) {
        console.error('Approver ID not found:', approverId);
        return callback(new Error('Approver ID not found'));
      }

      // อัปเดตสถานะการจอง
      db.query('UPDATE bookings SET status = ?, approved_by = ? WHERE id = ?', [status, approverId, bookingId], (err, results) => {
        if (err) {
          console.error('Error updating booking status:', err);
          return callback(err);
        }

        console.log('Update results:', results);
        if (results.affectedRows > 0) {
          if (status === 'approved') {
            // ดึงข้อมูลการจองและอัปเดตสถานะของห้อง
            Booking.getRequestById(bookingId, (err, booking) => {
              if (err) {
                console.error('Error retrieving booking details:', err);
                return callback(err);
              }
              if (!booking) {
                console.error('Booking not found for bookingId:', bookingId);
                return callback(new Error('Booking not found'));
              }

              const { room_id, slot } = booking;
              const roomStatus = 'reserved';

              // อัปเดตสถานะของห้อง
              Room.updateSlotStatus(room_id, slot, roomStatus, (err) => {
                if (err) {
                  console.error('Error updating room status:', err);
                  return callback(err);
                }
                console.log('Room status updated successfully for room_id:', room_id);
                return callback(null);
              });
            });
          } else {
            // ถ้าถูกปฏิเสธให้จบการทำงานเลย
            return callback(null);
          }
        } else {
          console.error('No booking found for bookingId:', bookingId);
          return callback(new Error('Booking not found or status already updated'));
        }
      });
    });
  },

  // get all pending req for approver
  getAllRequests: (callback) => {
    db.query('SELECT * FROM bookings WHERE status IN ("pending")', callback);
  },

  getRequestById: (bookingId, callback) => {
    db.query('SELECT * FROM bookings WHERE id = ?', [bookingId], (err, results) => {
      if (err) {
        console.error('Error retrieving booking request:', err);
        return callback(err);
      }
      if (results.length === 0) {
        console.error('No booking found for bookingId:', bookingId);
        return callback(new Error('Booking not found'));
      }
      return callback(null, results[0]);
    });
  },

};

module.exports = Booking;
