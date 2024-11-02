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
    bookmark: (userId, roomId, isBookmarked, callback) => {
        // isBookmarked = true => unMarked
        // isBookmarked = false => Marked
        if (isBookmarked) {
            db.query('delete from bookmarks where user_id = ? and room_id = ?', [userId, roomId], callback);
        } else {
            db.query('insert into bookmarks (user_id, room_id) values (?, ?)', [userId, roomId], callback);
        }
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
        db.query('SELECT slot_status, COUNT(*) AS total_count FROM (SELECT slot_1 AS slot_status FROM rooms UNION ALL SELECT slot_2 AS slot_status FROM rooms UNION ALL SELECT slot_3 AS slot_status FROM rooms UNION ALL SELECT slot_4 AS slot_status FROM rooms) AS all_slots GROUP BY slot_status;', callback)
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
        
        db.query(updateQuery, updateValues, callback);
        // const query = 'UPDATE rooms SET `room_name` = ?, `desc` = ?, `slot_1` = ?, `slot_2` = ?, `slot_3` = ?, `slot_4` = ?, `image` WHERE id = ?';
        // db.query(query, [roomData.room_name, roomData.description, roomData.slot_1, roomData.slot_2, roomData.slot_3, roomData.slot_4, roomData.image, roomId], callback);
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