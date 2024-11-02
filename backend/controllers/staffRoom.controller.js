const Room = require('../models/room.model');
const Booking = require('../models/booking.model');
const multer = require('multer');
const EventEmitter = require('events');

// ตั้งค่าจำนวนสูงสุดของ listeners ที่อนุญาต
EventEmitter.defaultMaxListeners = 20; // ปรับตามต้องการ

// ตั้งค่า multer สำหรับการจัดเก็บไฟล์
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'assets/rooms/'); // เก็บไฟล์ที่โฟลเดอร์ uploads
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + '-' + file.originalname); // ตั้งชื่อไฟล์ให้ไม่ซ้ำ
  },
});

const upload = multer({ storage: storage });

// ฟังก์ชันดึงข้อมูลห้องทั้งหมด
// const getAllRooms = async (req, res) => {
//   try {
//     await Room.findAll((err, result) => {
//       res.json(result);
//     });
//   } catch (err) {
//     console.error('Error fetching rooms:', err);
//     res.status(500).send('Error fetching rooms'); // ส่งข้อความผิดพลาดกลับไป
//   }
// };

// // ฟังก์ชันดึงข้อมูลห้องตาม ID
// const getOneRoom = async (req, res) => {
//   const { roomId } = req.params;
//   try {
//     const room = await Room.findById(roomId);
//     if (!room) {
//       return res.status(404).send('Room not found');
//     }
//     res.json(room);
//   } catch (err) {
//     console.error('Error fetching room:', err);
//     return res.status(500).send('Error fetching room');
//   }
// };

// ฟังก์ชันสำหรับการสร้างห้องพร้อมการอัปโหลดรูปภาพ
const createRoom = (req, res) => {
  // ตรวจสอบว่ามีการอัปโหลดไฟล์หรือไม่
  if (!req.file) {
    return res.status(400).send('Please upload an image');
  }

  // สร้างข้อมูลห้องพร้อมกับ image_url ที่อัปโหลด
  const roomData = {
    ...req.body,
    image: `${req.file.filename}`, // เก็บ URL ของรูปภาพ
  };

  Room.create(roomData, (err, result) => {
    if (err) {
      console.error('Error creating room:', err);
      return res.status(500).send('Error creating room');
    }

    res.status(201).json({ message: 'Room created successfully', roomId: result.insertId });
  });
};

// ฟังก์ชันสำหรับการอัปเดตข้อมูลห้อง
const updateRoom = (req, res) => {
  const { roomId } = req.params;
  let roomData;
  if (!req.file) { // if no file don't update image
    roomData = { ...req.body }
  } else {
    roomData = {
      ...req.body,
      image: `${req.file.filename}`,
    }
  }

  console.log(req.body);
  Room.update(roomId, roomData, (err) => {
    if (err) return res.status(500).send('Error updating room');
    res.send('Room updated successfully');
  });
};

// ฟังก์ชันสำหรับการลบห้อง
// const deleteRoom = (req, res) => {
//   const { roomId } = req.params;
//   Room.delete(roomId, (err) => {
//     if (err) return res.status(500).send('Error deleting room');
//     res.send('Room deleted successfully');
//   });
// };

// ฟังก์ชันสำหรับการจองห้อง
// const requestBooking = (req, res) => {
//   const { roomId, userId, slot, bookingDate } = req.body;

//   // ตรวจสอบประเภทของผู้ใช้ (ต้องเป็นนักเรียน)
//   const userType = req.user.type; // สมมติว่า req.user มีข้อมูลประเภทผู้ใช้

//   if (userType !== 'student') {
//     return res.status(403).send('Only students can book rooms'); // อนุญาตให้เฉพาะนักเรียนจองห้อง
//   }

//   Room.checkRoomAvailability(roomId, slot, (err, results) => {
//     if (err) return res.status(500).send('Error checking room availability');

//     if (results.length > 0) {
//       return res.status(400).send('Room is already booked for this slot');
//     } else {
//       Room.bookRoom(roomId, userId, slot, bookingDate, (err) => {
//         if (err) return res.status(500).send('Error booking room');
//         res.send('Room booked successfully');
//       });
//     }
//   });
// };

const history = (req, res) => {
  const { user_id, role } = req.body;

  Booking.getAllBooking(user_id, role, (err, result) => {
    if (err) return res.status(500).send('Internal server error');
    res.json(result);
  });
}

const summary = (req, res) => {
  Room.getSlotSummary((err, result) => {
    if (err) return res.status(500).send('Internal server error');
    res.json(result);
  });
}

// ส่งออกฟังก์ชันทั้งหมด
module.exports = {
  createRoom,
  updateRoom,
  history,
  summary,
  // deleteRoom, // can't delete
  // getAllRooms, // move to room
  // getOneRoom, // move to room
  // requestBooking, // unable to book
  upload,
};
