const Room = require('../models/room.model');
const Booking = require('../models/booking.model');
const multer = require('multer');
const EventEmitter = require('events');

//-------------------------------------------------------------------//
EventEmitter.defaultMaxListeners = 20; 
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'public/rooms/'); 
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + '-' + file.originalname); 
  },
});

const upload = multer({ storage: storage });
//-------------------------------------------------------------------//
// ฟังก์ชันสำหรับการสร้างห้องพร้อมการอัปโหลดรูปภาพ
const createRoom = (req, res) => {
  if (!req.file) {
    return res.status(400).send('Please upload an image');
  }

  // สร้างข้อมูลห้องพร้อมกับ image_url ที่อัปโหลด
  const roomData = {
    ...req.body,
    image: `${req.file.filename}`, 
  };

  Room.create(roomData, (err, result) => {
    if (err) {
      console.error('Error creating room:', err);
      return res.status(500).send('Error creating room');
    }

    res.status(201).json({ 
      message: 'Room created successfully', 
    });
  });
};
//-------------------------------------------------------------------//

// ฟังก์ชันสำหรับการอัปเดตข้อมูลห้อง
const updateRoom = (req, res) => {
  const { roomId } = req.params;
  let roomData = { ...req.body };
  
  if (req.file) { roomData.image = req.file.filename } 

  console.log(req.body);
  Room.update(roomId, roomData, (err) => {
    if (err) return res.status(500).send('Error updating room');
    res.send('Room updated successfully');
  });
};

//-------------------------------------------------------------------//

// ส่งออกฟังก์ชันทั้งหมด
module.exports = {
  createRoom,
  updateRoom,
  upload,
};

//-------------------------------------------------------------------//