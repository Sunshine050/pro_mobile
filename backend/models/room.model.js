const db = require('../config/db.config');

const Room = {
    findAll: (callback) => {
        db.query('SELECT * FROM rooms', callback);
    },
    findById: (roomId, callback) => {
        db.query('SELECT * FROM rooms WHERE id = ?', [roomId], callback);
    },
    create: (roomData, callback) => {
        const query = 'INSERT INTO rooms (room_name, description, slot_1, slot_2, slot_3, slot_4) VALUES (?, ?, ?, ?, ?, ?)';
        db.query(query, [roomData.room_name, roomData.description, roomData.slot_1, roomData.slot_2, roomData.slot_3, roomData.slot_4], (err, result) => {
            callback(err, result); // คืนค่าผลลัพธ์ไปยัง callback
        });
    },
    update: (roomId, roomData, callback) => {
        const query = 'UPDATE rooms SET room_name = ?, description = ?, slot_1 = ?, slot_2 = ?, slot_3 = ?, slot_4 = ? WHERE id = ?';
        db.query(query, [roomData.room_name, roomData.description, roomData.slot_1, roomData.slot_2, roomData.slot_3, roomData.slot_4, roomId], callback);
    },
    delete: (roomId, callback) => {
        const query = 'DELETE FROM rooms WHERE id = ?';
        db.query(query, [roomId], callback);
    },
    updateSlotStatus: (roomId, slot, status, callback) => {
        const query = `UPDATE rooms SET ${slot} = ? WHERE id = ?`;
        db.query(query, [status, roomId], callback);
    }
};

module.exports = Room;

