const express = require('express');
const router = express.Router();
const studentController = require('../controllers/studentBooking.controller');
const { verifyToken } = require('../middleware/auth.middleware');

// Route สำหรับจองห้อง
router.post('/book', verifyToken, studentController.bookRoom);
// cancel request
router.put('/cancel', verifyToken, studentController.cancel);
// Route สำหรับดึงการจองของผู้ใช้
router.get('/bookings/:user_id', verifyToken, studentController.getBookings);

// bookmarks
router.post('/bookmarked', verifyToken, studentController.bookmarked);
router.delete('/unBookmarked', verifyToken, studentController.unbookmarked);
// get bookmarked
router.get('/getBookmarked/:id', verifyToken, studentController.getBookmarked);



module.exports = router;
