const Booking = require('../models/booking.model');
const Room = require('../models/room.model');

// ฟังก์ชันสำหรับดึงข้อมูลห้องทั้งหมด
exports.getAllRooms = (req, res) => {
  Room.getAllRooms((err, rooms) => { // แก้ไขชื่อฟังก์ชันให้ตรงกัน
    if (err) {
      console.error("Error fetching rooms:", err);
      return res.status(500).send('Error fetching rooms');
    }
    res.status(200).json(rooms);
  });
};

// ฟังก์ชันสำหรับการจองห้อง
exports.bookRoom = (req, res) => {
  const { user_id, room_id, slot, booking_date } = req.body;

  // ตรวจสอบว่ามีข้อมูลที่จำเป็นทั้งหมดหรือไม่
  if (!user_id || !room_id || !slot || !booking_date) {
    return res.status(400).send('Missing required fields');
  }

  // อัปเดตสถานะของ slot ของห้องเป็น 'pending'
  Room.updateSlotStatus(room_id, slot, 'pending', (err) => {
    if (err) {
      console.error("Error updating room slot status:", err);
      return res.status(500).send('Error updating room slot status');
    }

    // สร้างการจองใหม่
    Booking.create({ user_id, room_id, slot, status: 'pending', booking_date }, (err, result) => {
      if (err) {
        console.error("Error creating booking:", err);
        return res.status(500).send('Error creating booking');
      }
      res.status(201).send('Booking created successfully');
    });
  });
};

// ฟังก์ชันสำหรับดึงข้อมูลการจองสำหรับผู้ใช้เฉพาะ
exports.getBookings = (req, res) => {
  const { user_id } = req.params;

  // ตรวจสอบว่ามี user_id หรือไม่
  if (!user_id) {
    return res.status(400).send('User ID is required');
  }

  // ค้นหาการจองตาม user ID
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