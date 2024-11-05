const db = require = require('../config/db.config');
const Room = {
    findAll: (callback) => {
        db.query('SELECT * FROM rooms', callback);
    },
    findById: (roomId, callback) => {
        db.query('SELECT * FROM rooms WHERE id = ?', [roomId], callback);
    },
    isSlotFree: (roomId, slot, callback) => {
        db.query('select ? from rooms where id = ? and ? = "free"', [slot, roomId, slot], callback);
    },
    isSlotPending: (roomId, slot, callback) => {
        db.query('select ? from rooms where id = ? and ? = "pending"', [slot, roomId, slot], callback);
    },
    isSlotReserved: (roomId, slot, callback) => {
        db.query('select ? from rooms where id = ? and ? = "reserved"', [slot, roomId, slot], callback);
    },
    isSlotDisabled: (roomId, slot, callback) => {
        db.query('select ? from rooms where id = ? and ? = "disabled"', [slot, roomId, slot], callback);
    },
    bookmarked: (userId, roomId, callback) => {
        db.query('INSERT INTO `bookmarks` (`user_id`, `room_id`) VALUES (?, ?)', [userId, roomId], callback);
    },
    unbookmarked: (userId, roomId, callback) => {
        db.query('delete from bookmarks where user_id = ? and room_id = ?', [userId, roomId], callback);
    },
    getBookmarked: (userId, callback) => {
        db.query('select * from bookmarks where user_id = ?', [userId], callback);
    },
    searchRoom: (room_name, callback) => {
        db.query('SELECT * FROM rooms WHERE room_name IN (?)', [room_name], callback);
    },
    filterRoom: (slots, callback) => {
        let conditions;
        if (slots.includes("any")) {
            conditions = 'slot_1 = "free" or slot_2 = "free" or slot_3 = "free" or slot_4 = "free"'
        } else {
            conditions = slots.map(slot => "? = \'free\'").join(' AND ');
        }
        const sql = `SELECT * FROM rooms WHERE ${conditions}`;
        console.log(sql);
        db.query(sql, slots, callback);
    },
    // dashboard
    getSlotSummary: (callback) => {
        db.query("SELECT SUM(CASE WHEN slot_1 = 'free' THEN 1 ELSE 0 END + CASE WHEN slot_2 = 'free' THEN 1 ELSE 0 END + CASE WHEN slot_3 = 'free' THEN 1 ELSE 0 END + CASE WHEN slot_4 = 'free' THEN 1 ELSE 0 END) AS total_free, SUM(CASE WHEN slot_1 = 'pending' THEN 1 ELSE 0 END + CASE WHEN slot_2 = 'pending' THEN 1 ELSE 0 END + CASE WHEN slot_3 = 'pending' THEN 1 ELSE 0 END + CASE WHEN slot_4 = 'pending' THEN 1 ELSE 0 END) AS total_pending, SUM(CASE WHEN slot_1 = 'reserved' THEN 1 ELSE 0 END + CASE WHEN slot_2 = 'reserved' THEN 1 ELSE 0 END + CASE WHEN slot_3 = 'reserved' THEN 1 ELSE 0 END + CASE WHEN slot_4 = 'reserved' THEN 1 ELSE 0 END) AS total_reserved, SUM(CASE WHEN slot_1 = 'disabled' THEN 1 ELSE 0 END + CASE WHEN slot_2 = 'disabled' THEN 1 ELSE 0 END + CASE WHEN slot_3 = 'disabled' THEN 1 ELSE 0 END + CASE WHEN slot_4 = 'disabled' THEN 1 ELSE 0 END) AS total_disabled, COUNT(id) * 4 AS total_slot FROM rooms", callback)
    },
    create: (roomData, callback) => {
        const query = 'INSERT INTO rooms (`room_name`, `desc`, `slot_1`, `slot_2`, `slot_3`, `slot_4`, `image`) VALUES (?, ?, ?, ?, ?, ?, ?)';
        db.query(query, [roomData.room_name, roomData.description, roomData.slot_1, roomData.slot_2, roomData.slot_3, roomData.slot_4, roomData.image], callback);
    },
    update: (roomId, roomData, callback) => {
        const updateQuery = 'UPDATE rooms SET ? WHERE id = ?';
        const updateValues = [
            Object.entries(roomData).reduce((acc, [key, value]) => ({ ...acc, [key]: value }), {}), roomId
        ];
        console.log(updateValues);
        db.query(updateQuery, updateValues, callback);
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