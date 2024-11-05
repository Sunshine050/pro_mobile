const express = require('express');
const router = express.Router();
const roomsController = require('../controllers/rooms.controller'); 
const { verifyToken } = require('../middleware/auth.middleware.js'); 

// เส้นทางสำหรับดึงข้อมูลห้องทั้งหมด
router.get('/all', verifyToken, roomsController.getAllRooms);

// เส้นทางสำหรับดึงข้อมูลห้องตาม ID
router.get('/:roomId', verifyToken, roomsController.getOneRoom);

// เส้นทางสำหรับค้นหาห้องตามชื่อ
router.get('/search/:name', verifyToken, roomsController.searchRoom);

// เส้นทางสำหรับกรองห้อง
router.post('/filter', verifyToken, roomsController.filterRoom);

module.exports = router; 