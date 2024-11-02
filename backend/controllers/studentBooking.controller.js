const Booking = require('../models/booking.model');
const Room = require('../models/room.model');

// ฟังก์ชันสำหรับดึงข้อมูลห้องทั้งหมด
const getAllRooms = (req, res) => {
  Room.getAllRooms((err, rooms) => { 
    if (err) {
      console.error("Error fetching rooms:", err);
      return res.status(500).send('Error fetching rooms');
    }
    res.status(200).json(rooms);
  });
};

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

      Booking.create({ user_id, room_id, slot, status: 'pending', reason }, (err) => {
        if (err) {
          console.error("Error creating booking:", err);
          return res.status(500).send('Error creating booking');
        }
        res.status(201).send('Booking created successfully');
      });
    });
  });
};

const getBookings = (req, res) => {
  const { user_id } = req.params;

  // ตรวจสอบว่า user_id ถูกส่งมาหรือไม่
  if (!user_id) {
    return res.status(400).send('User ID is required');
  }

  Booking.findByUserId(user_id, (err, bookings) => {
    if (err) {
      console.error("Error fetching bookings:", err);
      return res.status(500).send('Error fetching bookings');
    }
    res.status(200).json(bookings);
  });
};

const getBookmarked = (req, res) => {
  const { user_id } = req.body;

  Room.getBookmarked(user_id, (err, result) => {
    if (err) {
      console.error("Error fetching bookmarked rooms:", err);
      return res.status(500).send('Internal server error');
    }
    res.json(result);
  });
}

const bookmark = (req, res) => {
  const { user_id, room_id, isBookmarked } = req.body;

  Room.bookmark(user_id, room_id, isBookmarked, (err) => {
    if (err) {
      console.error("Error updating bookmark:", err);
      return res.status(500).send('Internal server error');
    }
    res.send("Bookmark updated successfully");
  });
}

const history = (req, res) => {
  const { user_id, role } = req.body;

  Booking.getAllBooking(user_id, role, (err, result) => {
    if (err) {
      console.error("Error fetching booking history:", err);
      return res.status(500).send('Internal server error');
    }
    res.json(result);
  });
}

const cancel = (req, res) => {
  const { user_id, room_id, slot } = req.body;

  Booking.cancelRequest(user_id, room_id, slot, (err, result) => {
    if (err) {
      console.error("Error canceling booking:", err);
      return res.status(500).send('Internal server error');
    }
    res.json(result);
  });
}

// Export functions
module.exports = {
  getAllRooms,
  bookRoom,
  cancel,
  getBookings,
  getBookmarked,
  bookmark,
  history
};
