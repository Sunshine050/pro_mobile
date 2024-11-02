const express = require('express');
const app = express();
const roomRoutes = require('./routes/rooms.routes');
const studentRoutes = require('./routes/studentBooking.routes');
const staffRoutes = require('./routes/staffRoom.routes');
const approverRoutes = require('./routes/approverBooking.routes');
const authRoutes = require('./routes/auth.routes');

port = 3000;
app.use(express.json());

// เส้นทางแสดงรูปภาพที่อัปโหลด
app.use('/assets', express.static('assets'));

// ตั้งค่า Routes
app.use('/room', roomRoutes);
app.use('/student', studentRoutes);
app.use('/staff', staffRoutes);
app.use('/approver', approverRoutes);
app.use('/api/auth', authRoutes);

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
