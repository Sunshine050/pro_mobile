const express = require('express');
const router = express.Router();
const staffController = require('../controllers/staffRoom.controller');
const { verifyToken } = require('../middleware/auth.middleware.js');

// เส้นทางสำหรับจัดการห้อง
router.post('/room/create', verifyToken, staffController.upload.single('image'), staffController.createRoom); // อัปโหลดรูปภาพและสร้างห้อง
router.put('/room/update/:roomId', verifyToken, staffController.upload.single('image'), staffController.updateRoom); // อัปเดตข้อมูลห้อง

module.exports = router; // ส่งออก router
