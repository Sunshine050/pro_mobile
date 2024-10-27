const express = require('express');
const router = express.Router();
const staffController = require('../controllers/staffRoom.controller'); // ตรวจสอบว่า import ครบ
const { verifyToken } = require('../middleware/auth.middleware.js');

// เส้นทางสำหรับจัดการห้อง
router.get('/rooms', verifyToken, staffController.getAllRooms); // ดึงข้อมูลห้องทั้งหมด
router.get('/room/:roomId', verifyToken, staffController.getOneRoom); // ดึงข้อมูลห้องตาม ID
router.post('/room/create', verifyToken, staffController.upload.single('image'), staffController.createRoom); // อัปโหลดรูปภาพและสร้างห้อง
router.put('/room/update/:roomId', verifyToken, staffController.updateRoom); // อัปเดตข้อมูลห้อง
router.delete('/room/delete/:roomId', verifyToken, staffController.deleteRoom); // ลบห้อง
router.post('/room/requestBooking', verifyToken, staffController.requestBooking); // จองห้อง

module.exports = router; // ส่งออก router
