const express = require('express');
const router = express.Router();
const studentController = require('../controllers/studentBooking.controller');
const { verifyToken } = require('../middleware/auth.middleware');

// Route สำหรับดึงข้อมูลห้องทั้งหมด
router.get('/rooms', studentController.getAllRooms);

// Route สำหรับจองห้อง
router.post('/book', verifyToken, studentController.bookRoom);
// cancel request
router.post('/cancel', verifyToken, studentController.cancel);
// Route สำหรับดึงการจองของผู้ใช้
router.get('/bookings/:user_id', verifyToken, studentController.getBookings);

// bookmark a room
router.post('/bookmark', verifyToken, studentController.bookmark);
// get bookmarked
router.post('/bookmarked', verifyToken, studentController.getBookmarked);

// get history
// router.post('/history', verifyToken, studentController.history) // move to user

module.exports = router;
