const jwt = require('jsonwebtoken');
const blacklistModel = require('../models/blacklist.model');
require('dotenv').config();

const API_KEY = process.env.API_KEY || "my-secret-key"; 

//-------------------------------------------------------------------//

// Middleware to verify token
exports.verifyToken = async (req, res, next) => {
    const token = req.headers['authorization'];

    // ตรวจสอบว่า token มีหรือไม่
    if (!token) {
        return res.status(401).send('A token is required for authentication');
    }

    try {
        const tokenValue = token.split(" ")[1]; 

        // ตรวจสอบว่า token ถูกระงับหรือไม่
        const isRevoked = await blacklistModel.isRevoked(tokenValue);
        if (isRevoked) {
            return res.status(403).send('Invalid or expired token.');
        }

        // ตรวจสอบ token ด้วย secret key
        const decoded = jwt.verify(tokenValue, API_KEY); 
        req.user = decoded; // บันทึกข้อมูลผู้ใช้ลงใน request

        next(); 
    } catch (err) {
        // หากเกิดข้อผิดพลาดในการตรวจสอบ token
        console.error('Token verification error:', err); 
        return res.status(401).send('Invalid Token');
    }
};

//-------------------------------------------------------------------//