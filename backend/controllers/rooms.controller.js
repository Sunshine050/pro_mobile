const Room = require('../models/room.model');

// ฟังก์ชันดึงข้อมูลห้องทั้งหมด
const getAllRooms = (req, res) => {
    try {
        Room.findAll((err, result) => {
            res.json(result);
        });

    } catch (err) {
        console.error('Error fetching rooms:', err);
        res.status(500).send('Error fetching rooms');
    }
};

// get room by id
const getOneRoom = (req, res) => {
    const { roomId } = req.params;
    try {
        Room.findById(roomId, (err, result) => {
            if (!result) {
                return res.status(404).send('Room not found');
            }
            res.json(result);
        });

    } catch (err) {
        console.error('Error fetching room:', err);
        return res.status(500).send('Error fetching room');
    }
};


// get room by name
const searchRoom = (req, res) => {
    const { name } = req.params;
    try {
        Room.searchRoom(name, (err, result) => {
            if (!result) {
                return res.status(404).send(`${name} not found`);
            }
            res.json(result);
        });

    } catch (err) {
        console.error('Error fetching room:', err);
        return res.status(500).send('Error fetching room');
    }
}

// filter room
const filterRoom = (req, res) => {
    const { slots } = req.body;

    if (!slots || !Array.isArray(slots)) {
        return res.status(400).json({ error: 'Invalid slots parameter' });
    }

    try {
        Room.filterRoom(slots, (err, result) => {
            if (!result) {
                return res.status(404).send(`None Available`);
            }
            res.json(result);
        })
    } catch (error) {
        console.error(error);
        res.status(500).json({
            error: 'Internal server error'
        });
    }
}

module.exports = {
    getAllRooms,
    getOneRoom,
    searchRoom,
    filterRoom
}