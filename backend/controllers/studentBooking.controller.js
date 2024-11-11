const db = require('../config/db.config');
const Booking = require('../models/booking.model');
const Room = require('../models/room.model');
//-------------------------------------------------------------------//
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
          bookingId: result.insertId,
        });
      });
    });
  });
};

//-------------------------------------------------------------------//

const getBookings = (req, res) => {
  const { userId } = req.user;
  if (!userId) {
    return res.status(400).send('User ID is required');
  }

  // ใช้ SQL JOIN เพื่อดึงข้อมูลทั้งจาก bookings และ rooms
  const query = `
    SELECT bookings.id, bookings.user_id, bookings.room_id, bookings.slot, bookings.status, 
           bookings.booking_date, bookings.reason, rooms.room_name
    FROM bookings
    JOIN rooms ON bookings.room_id = rooms.id
    WHERE bookings.user_id = ? AND bookings.status = "pending"
  `;

  // ใช้ db.query เพื่อดึงข้อมูลจากฐานข้อมูล
  db.query(query, [userId], (err, results) => {
    if (err) {
      console.error('Error fetching bookings:', err);
      return res.status(500).send('Error fetching bookings');
    }

    // ถ้าไม่พบการจอง
    if (results.length === 0) {
      return res.status(200).json([]);
    }

    // ส่งข้อมูลการจอง
    res.status(200).json(results);
  });
};

//-------------------------------------------------------------------//
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
//-------------------------------------------------------------------//

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

//-------------------------------------------------------------------//

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

//-------------------------------------------------------------------//

const cancel = (req, res) => {
  const { booking_id } = req.params; // ใช้ params แทน body

  Booking.cancelRequest(booking_id, (err, result) => {
    if (err) {
      console.error("Error canceling booking:", err);
      return res.status(500).send('Internal server error');
    }
    res.send("canceled"); // ส่งการยืนยันว่าได้ยกเลิกการจอง
  });
};


//-------------------------------------------------------------------//

// Export functions
module.exports = {
  bookRoom,
  cancel,  
  getBookings,
  getBookmarked,
  bookmarked,
  unbookmarked
};
//-------------------------------------------------------------------//