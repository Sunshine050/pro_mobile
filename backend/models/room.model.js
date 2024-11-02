const db = require = require('../config/db.config');
const Room = {
  // สร้างห้องใหม่
  create: (room, callback) => {
    db.query('INSERT INTO rooms SET ?', room, (err, results) => {
      if (err) {
        console.error('Error creating room:', err);
        return callback(err);
      }
      callback(null, results.insertId);
    });
  },

  // ค้นหาห้องตาม ID
  findById: (roomId, callback) => {
    db.query('SELECT * FROM rooms WHERE id = ?', [roomId], (err, results) => {
      if (err) {
        console.error('Error finding room by ID:', err);
        return callback(err);
      }
      if (results.length === 0) {
        return callback(new Error('Room not found'));
      }
      callback(null, results[0]);
    });
  },

  // อัปเดตสถานะของห้อง
  updateSlotStatus: (roomId, slot, status, callback) => {
    console.log('Updating room status for roomId:', roomId, 'to status:', status);
    
    // ตรวจสอบประเภทข้อมูลก่อน
    if (typeof roomId !== 'number' || typeof slot !== 'string' || typeof status !== 'string') {
      console.error('Invalid data types:', { roomId, slot, status });
      return callback(new Error('Invalid data types'));
    }

    // อัปเดตสถานะของห้อง
    db.query('UPDATE rooms SET status = ? WHERE id = ? AND slot = ?', [status, roomId, slot], (err, results) => {
      if (err) {
        console.error('Error updating room status:', err);
        return callback(err);
      }

      if (results.affectedRows > 0) {
        console.log('Room status updated successfully for roomId:', roomId);
        return callback(null);
      } else {
        console.error('No room found for roomId:', roomId);
        return callback(new Error('Room not found or status already updated'));
      }
    });
  },

  // ค้นหาห้องทั้งหมด
  getAllRooms: (callback) => {
    db.query('SELECT * FROM rooms', (err, results) => {
      if (err) {
        console.error('Error retrieving all rooms:', err);
        return callback(err);
      }
      callback(null, results);
    });
  },

  // ค้นหาห้องที่ว่างในช่วงเวลาที่กำหนด
  findAvailableRooms: (startTime, endTime, callback) => {
    db.query(
      'SELECT * FROM rooms WHERE id NOT IN (SELECT room_id FROM bookings WHERE (slot BETWEEN ? AND ?))',
      [startTime, endTime],
      (err, results) => {
        if (err) {
          console.error('Error finding available rooms:', err);
          return callback(err);
        }
        callback(null, results);
      }
    );
  }
};

module.exports = Room;