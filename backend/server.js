const express = require('express');
const cors = require('cors');
const path = require('path');
const app = express();

// นำเข้า routes ที่คุณกำหนดไว้
const userRoutes = require('./routes/user.routes'); 
const studentRoutes = require('./routes/studentBooking.routes');
const staffRoutes = require('./routes/staffRoom.routes');
const approverRoutes = require('./routes/approverBooking.routes');
const authRoutes = require('./routes/auth.routes');
const roomRoutes = require('./routes/rooms.routes');

// โหลด environment variables จากไฟล์ .env
require('dotenv').config();

// ใช้งาน CORS และ JSON parsing
app.use(cors()); 
app.use(express.json());

// กำหนด port ที่จะใช้
const port = process.env.PORT || 3000;

// เส้นทางแสดงรูปภาพที่อัปโหลด
app.use('/public', express.static('public')); 


// ตั้งค่า Routes
app.use('/room', roomRoutes);
app.use('/user', userRoutes);
app.use('/student', studentRoutes);
app.use('/staff', staffRoutes);
app.use('/approver', approverRoutes);
app.use('/api/auth', authRoutes);

// การจัดการข้อผิดพลาดสำหรับ route ที่ไม่พบ
app.use((req, res, next) => {
  res.status(404).send('Route not found');
});

// การจัดการข้อผิดพลาดอื่น ๆ ที่อาจเกิดขึ้น
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something went wrong!');
});

// เริ่มต้น server
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
