const Booking = require('../models/booking.model');
const Room = require('../models/room.model');

const bookRoom = (req, res) => {
  const { user_id, room_id, slot, reason } = req.body;

  // ตรวจสอบค่าที่จำเป็น
  if (!user_id || !room_id || !slot || !reason) {
    return res.status(400).send('Missing required fields');
  }

  Room.isSlotFree(room_id, slot, (err, isFree) => {
    if (err) {
      console.error("Error checking slot availability:", err);
      return res.status(500).send('Error checking slot availability');
    }

    if (!isFree) {
      return res.status(400).send('This slot is unavailable');
    }

    Room.updateSlotStatus(room_id, slot, 'pending', (err) => {
      if (err) {
        console.error("Error updating room slot status:", err);
        return res.status(500).send('Error updating room slot status');
      }

      Booking.create({ user_id, room_id, slot, status: 'pending', reason }, (err, result) => {
        if (err) {
          console.error("Error creating booking:", err);
          return res.status(500).send('Error creating booking');
        }
        res.status(201).send('Booking created successfully');
      });
    });
  })
};

const getBookings = (req, res) => {
  const { user_id } = req.params;

  // ตรวจสอบว่า user_id ถูกส่งมาหรือไม่
  if (!user_id) {
    return res.status(400).send('User ID is required');
  }

  Booking.getPending(user_id, (err, bookings) => {
    if (err) {
      console.error("Error fetching bookings:", err);
      return res.status(500).send('Error fetching bookings');
    }
    res.status(200).json(bookings);
  });
};

const getBookmarked = (req, res) => {
  const { user_id } = req.params;
  try {
    Room.getBookmarked(user_id, (err, result) => {
      if (err) {
        console.error("Error fetching bookmarked rooms:", err);
        return res.status(409).send('Already bookmarked');
      }
      res.status(200).json(result);
    });
  } catch (error) {
    return res.status(500).send('Internal server error');
  }

}

const bookmarked = (req, res) => {
  const { user_id, room_id } = req.body;

  Room.bookmarked(user_id, room_id, (err) => {
    if (err) {
      console.error("Error updating bookmark:", err);
      return res.status(500).send('Internal server error');
    }
    res.send("Bookmark updated successfully");
  });
}

const unbookmarked = (req, res) => {
  const { user_id, room_id } = req.body;

  Room.unbookmarked(user_id, room_id, (err) => {
    if (err) {
      console.error("Error updating bookmark:", err);
      return res.status(500).send('Internal server error');
    }
    res.send("Bookmark updated successfully");
  });
}

const cancel = (req, res) => {
  const { booking_id } = req.body;

  Booking.cancelRequest(booking_id, (err, result) => {
    if (err) {
      console.error("Error canceling booking:", err);
      return res.status(500).send('Internal server error');
    }
    res.send("canceled");
  });
}

// Export functions
module.exports = {
  bookRoom,
  cancel,
  getBookings,
  getBookmarked,
  bookmarked,
  unbookmarked
};
