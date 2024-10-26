const Room = require('../models/room.model');

// ฟังก์ชันดึงข้อมูลห้องทั้งหมด
exports.getAllRooms = (req, res) => {
    Room.findAll((err, rooms) => {
      if (err) {
        console.error('Error fetching rooms:', err);
        return res.status(500).send('Error fetching rooms');
      }
      res.json(rooms);
    });
  };
  

// ฟังก์ชันดึงข้อมูลห้องตาม ID
exports.getOneRoom = (req, res) => {
    const { roomId } = req.params;
    Room.findById(roomId, (err, room) => {
      if (err) {
        console.error('Error fetching room:', err);
        return res.status(500).send('Error fetching room');
      }
      if (!room) {
        return res.status(404).send('Room not found');
      }
      res.json(room);
    });
  };

  
  exports.createRoom = (req, res) => {
    Room.create(req.body, (err, result) => {
      if (err) {
        console.error('Error creating room:', err); // แสดงข้อผิดพลาดที่แน่นอน
        return res.status(500).send('Error creating room');
      }
      
      // สมมติว่า result.insertId คือ ID ของห้องที่สร้างเสร็จ
      res.status(201).json({ message: 'Room created successfully', roomId: result.insertId });
    });
  };
  
  
  exports.updateRoom = (req, res) => {
    const { roomId } = req.params;
    Room.update(roomId, req.body, (err) => {
      if (err) return res.status(500).send('Error updating room');
      res.send('Room updated successfully');
    });
  };
  
  exports.deleteRoom = (req, res) => {
    const { roomId } = req.params;
    Room.delete(roomId, (err) => {
      if (err) return res.status(500).send('Error deleting room');
      res.send('Room deleted successfully');
    });
  };
  
  // ฟังก์ชันสำหรับการจองห้อง
exports.requestBooking = (req, res) => {
    const { roomId, userId, slot, bookingDate } = req.body;
  
    // ตรวจสอบประเภทของผู้ใช้ (ต้องเป็นนักเรียน)
    const userType = req.user.type; // สมมติว่า req.user มีข้อมูลประเภทผู้ใช้
  
    if (userType !== 'student') {
      return res.status(403).send('Only students can book rooms'); // อนุญาตให้เฉพาะนักเรียนจองห้อง
    }
  
    Room.checkRoomAvailability(roomId, slot, (err, results) => {
      if (err) return res.status(500).send('Error checking room availability');
  
      if (results.length > 0) {
        return res.status(400).send('Room is already booked for this slot');
      } else {
        Room.bookRoom(roomId, userId, slot, bookingDate, (err) => {
          if (err) return res.status(500).send('Error booking room');
          res.send('Room booked successfully');
        });
      }
    });
  };
  