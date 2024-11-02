const db = require('../config/db.config');
const Room = require('./room.model');

const Booking = {
  create: (booking, callback) => {
    db.query('INSERT INTO bookings SET ?', booking, (err, results) => {
      if (err) {
        console.error('Error creating booking:', err);
        return callback(err);
      }
      callback(null, results.insertId);
    });
  },

  findByUserId: (userId, callback) => {
    db.query('SELECT * FROM bookings WHERE user_id = ?', [userId], (err, results) => {
      if (err) {
        console.error('Error finding bookings by userId:', err);
        return callback(err);
      }
      callback(null, results);
    });
  },

  getPending: (userId, callback) => {
    db.query('select * from bookings where user_id = ? and status = "pending"', [userId], callback);
  },

  approveBooking: (bookingId, approverId, callback) => {
    this.updateStatus(bookingId, 'approved', approverId, callback);
  },

  rejectBooking: (bookingId, approverId, callback) => {
    this.updateStatus(bookingId, 'rejected', approverId, callback);
  },

  updateStatus: (bookingId, status, approverId, callback) => {
    console.log('Updating booking status for bookingId:', bookingId, 'to status:', status);

    if (typeof bookingId !== 'number' || typeof status !== 'string' || typeof approverId !== 'number') {
      console.error('Invalid data types:', { bookingId, status, approverId });
      return callback(new Error('Invalid data types'));
    }

    db.query('SELECT * FROM users WHERE id = ?', [approverId], (err, results) => {
      if (err) {
        console.error('Error checking approver ID:', err);
        return callback(err);
      }

      if (results.length === 0) {
        console.error('Approver ID not found:', approverId);
        return callback(new Error('Approver ID not found'));
      }

      db.query('UPDATE bookings SET status = ?, approved_by = ? WHERE id = ?', [status, approverId, bookingId], (err, results) => {
        if (err) {
          console.error('Error updating booking status:', err);
          return callback(err);
        }

        if (results.affectedRows > 0) {
          if (status === 'approved') {
            this.getRequestById(bookingId, (err, booking) => {
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
            return callback(null); // Rejecting the booking does not require additional action
          }
        } else {
          console.error('No booking found for bookingId:', bookingId);
          return callback(new Error('Booking not found or status already updated'));
        }
      });
    });
  },

  getAllRequests: (callback) => {
    db.query('SELECT * FROM bookings WHERE status = "pending"', (err, results) => {
      if (err) {
        console.error('Error retrieving all pending bookings:', err);
        return callback(err);
      }
      callback(null, results);
    });
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

  cancelRequest: (bookingId, callback) => {
    db.query("UPDATE `bookings` SET `status` = 'cancel' WHERE `bookings`.`id` = ? ", [bookingId], callback);
  },

  getAllBooking: (userId, role, callback) => {
    let query;
    switch (role) {
      case "student":
        query = "SELECT b.id AS booking_id, u2.username AS approved_by, r.room_name, b.slot, b.status, b.reason, b.booking_date FROM bookings b INNER JOIN users u1 ON b.user_id = u1.id LEFT JOIN users u2 ON b.approved_by = u2.id INNER JOIN rooms r ON b.room_id = r.id WHERE b.user_id = ?";
        break;
      case "staff":
        query = "SELECT b.id AS booking_id, u1.username AS booked_by, u2.username AS approved_by, r.room_name, b.slot, b.status, b.reason, b.booking_date FROM bookings b INNER JOIN users u1 ON b.user_id = u1.id LEFT JOIN users u2 ON b.approved_by = u2.id INNER JOIN rooms r ON b.room_id = r.id";
        break;
      case "approver":
        query = "SELECT b.id AS booking_id, u1.username AS booked_by, r.room_name, b.slot, b.status, b.reason, b.booking_date FROM bookings b INNER JOIN users u1 ON b.user_id = u1.id LEFT JOIN users u2 ON b.approved_by = u2.id INNER JOIN rooms r ON b.room_id = r.id WHERE b.approved_by = ?";
        break;
    }

    db.query(query, [userId], callback);
  },
};

module.exports = Booking;