const express = require('express');
const router = express.Router();
const studentController = require('../controllers/studentBooking.controller');

// Route สำหรับดึงข้อมูลห้องทั้งหมด
router.get('/rooms', studentController.getAllRooms);

// Route สำหรับจองห้อง
router.post('/book', studentController.bookRoom);

// Route สำหรับดึงการจองของผู้ใช้
router.get('/bookings/:user_id', studentController.getBookings);

module.exports = router;
