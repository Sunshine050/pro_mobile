const Booking = require('../models/booking.model');

// ดึงคำขอการจองทั้งหมดที่สถานะเป็น "pending"
const getAllBookingRequests = (req, res) => {
  Booking.getAllRequests((err, bookings) => {
    if (err) {
      return res.status(500).json({ error: 'Error retrieving booking requests' });
    }
    res.json(bookings);
  });
};

// ดึงคำขอการจองตาม ID
const getBookingRequestById = (req, res) => {
  const bookingId = parseInt(req.params.id);
  Booking.getRequestById(bookingId, (err, booking) => {
    if (err) {
      return res.status(404).json({ error: 'Booking not found' });
    }
    res.json(booking);
  });
};

// อนุมัติการจอง
const approveBooking = (req, res) => {
  const { bookingId, approverId } = req.body;
  Booking.updateStatus(bookingId, 'approved', approverId, (err) => {
    if (err) {
      return res.status(500).json({ error: 'Error approving booking' });
    }
    res.json({ message: 'Booking approved' });
  });
};

// ปฏิเสธการจอง
const rejectBooking = (req, res) => {
  const { bookingId, approverId } = req.body;
  Booking.updateStatus(bookingId, 'rejected', approverId, (err) => {
    if (err) {
      return res.status(500).json({ error: 'Error rejecting booking' });
    }
    res.json({ message: 'Booking rejected' });
  });
};

// ส่งออกฟังก์ชันทั้งหมด
module.exports = {
  getAllBookingRequests,
  getBookingRequestById,
  approveBooking,
  rejectBooking,
};
