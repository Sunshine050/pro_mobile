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

// ส่งออกฟังก์ชันทั้งหมด
module.exports = {
  createRoom,
  updateRoom,
  upload,
};
