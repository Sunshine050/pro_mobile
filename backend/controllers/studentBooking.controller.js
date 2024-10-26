const Booking = require('../models/booking.model');
const Room = require('../models/room.model');

exports.bookRoom = (req, res) => {
  const { user_id, room_id, slot, booking_date } = req.body;

  Room.updateSlotStatus(room_id, slot, 'pending', (err) => {
    if (err) return res.status(500).send('Error updating room slot status');

    Booking.create({ user_id, room_id, slot, status: 'pending', booking_date }, (err, result) => {
      if (err) return res.status(500).send('Error creating booking');
      res.send('Booking created successfully');
    });
  });
};

exports.getBookings = (req, res) => {
  const { user_id } = req.params;

  Booking.findByUserId(user_id, (err, bookings) => {
    if (err) return res.status(500).send('Error fetching bookings');
    res.json(bookings);
  });
};
