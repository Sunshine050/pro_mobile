const jwt = require('jsonwebtoken');
const blacklistModel = require('../models/blacklist.model');
require('dotenv').config();

const API_KEY = process.env.API_KEY || "my-secret-key"; // อ่านจาก environment variable หรือใช้ค่า default

// Middleware to verify token
exports.verifyToken = async (req, res, next) => {
    // ดึง token จาก headers
    const token = req.headers['authorization'];

    // ตรวจสอบว่า token มีหรือไม่
    if (!token) {
        return res.status(401).send('A token is required for authentication');
    }

    try {
        const tokenValue = token.split(" ")[1]; // แยก 'Bearer' ออกจาก token

        // ตรวจสอบว่า token ถูกระงับหรือไม่
        const isRevoked = await blacklistModel.isRevoked(tokenValue);
        if (isRevoked) {
            return res.status(403).send('Invalid or expired token.');
        }

        // ตรวจสอบ token ด้วย secret key
        const decoded = jwt.verify(tokenValue, API_KEY); // ใช้ API_KEY หรือ secret key ของคุณ
        req.user = decoded; // บันทึกข้อมูลผู้ใช้ลงใน request

        next(); // ดำเนินการต่อไป
    } catch (err) {
        // หากเกิดข้อผิดพลาดในการตรวจสอบ token
        console.error('Token verification error:', err); // บันทึกข้อผิดพลาด
        return res.status(401).send('Invalid Token');
    }
};
