const express = require('express');
const router = express.Router();
const roomsController = require('../controllers/rooms.controller');
const { verifyToken } = require('../middleware/auth.middleware.js');

router.get('/all', verifyToken, roomsController.getAllRooms); // ดึงข้อมูลห้องทั้งหมด
router.get('/:roomId', verifyToken, roomsController.getOneRoom); // ดึงข้อมูลห้องตาม ID
router.get('/search/:name', verifyToken, roomsController.searchRoom)
router.post('/filter', verifyToken, roomsController.filterRoom)

module.exports = router;