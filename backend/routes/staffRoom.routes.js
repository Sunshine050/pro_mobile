const express = require('express');
const router = express.Router();
const staffController = require('../controllers/staffRoom.controller'); // ปรับให้ถูกต้องตามโครงสร้างไฟล์ของคุณ
const { verifyToken } = require('../middleware/auth.middleware.js'); // ปรับให้ถูกต้องตามโครงสร้างไฟล์ของคุณ

// ใช้ middleware ใน routes ที่ต้องการการตรวจสอบ token
router.get('/rooms', verifyToken, staffController.getAllRooms); // เพิ่ม route สำหรับดึงข้อมูลห้องทั้งหมด
router.get('/room/:roomId', verifyToken, staffController.getOneRoom); // เพิ่ม route สำหรับดึงข้อมูลห้องตาม ID
router.post('/room/create', verifyToken, staffController.createRoom);
router.put('/room/update/:roomId', verifyToken, staffController.updateRoom);
router.delete('/room/delete/:roomId', verifyToken, staffController.deleteRoom);
router.post('/room/requestBooking', verifyToken, staffController.requestBooking);

module.exports = router;
