const express = require('express');
const app = express();
const cors = require('cors');
const userRoutes = require('./routes/userRoute');
const studentRoutes = require('./routes/studentBooking.routes');
const staffRoutes = require('./routes/staffRoom.routes');
const approverRoutes = require('./routes/approverBooking.routes');
const authRoutes = require('./routes/auth.routes');
const roomRoutes = require('./routes/rooms.routes');
require('dotenv').config()

app.use(cors()); 
app.use(express.json());

const port = process.env.PORT || 3000;

// เส้นทางแสดงรูปภาพที่อัปโหลด
app.use('/public', express.static('public'));

// ตั้งค่า Routes
app.use('/room', roomRoutes);
// app.use('/user', userRoutes);
app.use('/student', studentRoutes);
app.use('/staff', staffRoutes);
app.use('/approver', approverRoutes);
app.use('/api/auth', authRoutes);

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
