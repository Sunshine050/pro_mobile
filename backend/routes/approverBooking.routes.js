const express = require('express');
const router = express.Router();
const approverController = require('../controllers/approverBooking.controller');
const { verifyToken } = require('../middleware/auth.middleware'); 
//-------------------------------------------------------------------//

// Route สำหรับดึงคำขอการจองทั้งหมด
router.get('/booking-requests', verifyToken, approverController.getAllBookingRequests);
//-------------------------------------------------------------------//
// Route สำหรับอนุมัติการจอง
router.post('/approve', verifyToken, approverController.approveBooking);
//-------------------------------------------------------------------//
// Route สำหรับปฏิเสธการจอง
router.post('/reject', verifyToken, approverController.rejectBooking);

//-------------------------------------------------------------------//
module.exports = router;
//-------------------------------------------------------------------//