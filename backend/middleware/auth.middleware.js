const jwt = require('jsonwebtoken');
const blacklistModel = require('../models/blacklist.model');

// Middleware to verify token
exports.verifyToken = async (req, res, next) => {
    const token = req.headers['authorization'];

    if (!token) {
        return res.status(401).send('A token is required for authentication');
    }

    try {
        const isRevoked = await blacklistModel.isRevoked(token.split(" ")[1]);
        if (isRevoked) {
            return res.status(403).send('Invalid or expired token.')
        }
        
        const decoded = jwt.verify(token.split(" ")[1], 'secret_key'); // แยก 'Bearer' ออกจากโทเค็น
        req.user = decoded; // บันทึกข้อมูลผู้ใช้ลงใน request
        next();
    } catch (err) {
        return res.status(401).send('Invalid Token');
    }
};
