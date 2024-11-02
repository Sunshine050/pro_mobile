const Booking = require('../models/booking.model');
const Room = require('../models/room.model');

const bookRoom = (req, res) => {
  const { user_id, room_id, slot } = req.body;

  // is slot free
  Room.isSlotFree(room_id, slot, (err, result) => {
    // if free => continue
    if (result) {
      Room.updateSlotStatus(room_id, slot, 'pending', (err) => {
        if (err) return res.status(500).send('Error updating room slot status');

        Booking.create({ user_id, room_id, slot, status: 'pending' }, (err, result) => {
          if (err) return res.status(500).send('Error creating booking');
          res.send('Booking created successfully');
        });
      });
    } else {
      res.status(500).send('This slot is Unavailable');
    }
  });
};

// get pending booking
const getBookings = (req, res) => {
  const { user_id } = req.body;

  Booking.getPending(user_id, (err, bookings) => {
    if (err) return res.status(500).send('Error fetching bookings');
    res.json(bookings);
  });
};

const getBookmarked = (req, res) => {
  const { user_id } = req.body;

  Room.getBookmarked(user_id, (err, result) => {
    if (err) return res.status(500).send('Internal server error');
    res.json(result);
  });
}

const bookmark = (req, res) => {
  // isBookmarked = true => unMarked
  // isBookmarked = false => Marked
  const { user_id, room_id, isBookmarked } = req.body;

  Room.bookmark(user_id, room_id, isBookmarked, (err, result) => {
    if (err) return res.status(500).send('Internal server error');
    res.send("success");
  });
}

const history = (req, res) => {
  const { user_id, role } = req.body;
  try {
    Booking.getAllBooking(user_id, role, (err, result) => {
      if (err) return res.status(500).send('Internal server error');
      res.json(result);
    });
  } catch (error) {
    res.status(500).send('Internal server error');
  }

}

const cancel = (req, res) => {
  const { user_id, room_id, slot } = req.body;

  try {
    Booking.cancelRequest(user_id, room_id, slot, (err, result) => {
      console.log(err);
      if (err) return res.status(500).send('Internal server error');
      res.json(result);
    });
  } catch (error) {
    res.status(500).send('Internal server error');
  }

}

module.exports = {
  bookRoom,
  cancel,
  getBookings,
  getBookmarked,
  bookmark,
  history
}