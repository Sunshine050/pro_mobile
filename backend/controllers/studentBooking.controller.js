const Booking = require('../models/booking.model');
const Room = require('../models/room.model');

const bookRoom = (req, res) => {
  const { room_id, slot, reason } = req.body;
  const { userId } = req.user;

  // ตรวจสอบค่าที่จำเป็น
  if (!userId || !room_id || !slot || !reason) {
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

      const user_id = userId;
      Booking.create({ user_id, room_id, slot, status: 'pending', reason }, (err, result) => {
        if (err) {
          console.error("Error creating booking:", err);
          return res.status(500).send('Error creating booking');
        }

        // ส่งข้อความสำเร็จกลับ
        res.status(201).json({
          message: 'Booking created successfully',
          bookingId: result.insertId, // สามารถส่งข้อมูลที่สร้างขึ้นกลับมาได้
        });
      });
    });
  });
};


const getBookings = (req, res) => {
  const { userId } = req.user;

  // ตรวจสอบว่า user_id ถูกส่งมาหรือไม่
  if (!userId) {
    return res.status(400).send('User ID is required');
  }

  Booking.getPending(userId, (err, bookings) => {
    if (err) {
      console.error("Error fetching bookings:", err);
      return res.status(500).send('Error fetching bookings');
    }
    res.status(200).json(bookings);
  });
};

const getBookmarked = (req, res) => {
  const { userId } = req.user;
  try {
    Room.getBookmarked(userId, (err, result) => {
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
  const { room_id } = req.body;
  const { userId } = req.user;

  Room.bookmarked(userId, room_id, (err) => {
    if (err) {
      console.error("Error updating bookmark:", err);
      return res.status(500).send('Internal server error');
    }
    res.send("Bookmark updated successfully");
  });
}

const unbookmarked = (req, res) => {
  const { room_id } = req.body;
  const { userId } = req.user;

  Room.unbookmarked(userId, room_id, (err) => {
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
