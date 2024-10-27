const express = require('express');
const app = express();
const studentRoutes = require('./routes/studentBooking.routes');
const staffRoutes = require('./routes/staffRoom.routes');
const approverRoutes = require('./routes/approverBooking.routes');
const authRoutes = require('./routes/auth.routes');

app.use(express.json());

// เส้นทางแสดงรูปภาพที่อัปโหลด
app.use('/uploads', express.static('uploads'));

// ตั้งค่า Routes
app.use('/student', studentRoutes);
app.use('/staff', staffRoutes);
app.use('/approver', approverRoutes);
app.use('/api/auth', authRoutes);

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});
