const jwt = require('jsonwebtoken');

// Middleware to verify token
exports.verifyToken = (req, res, next) => {
    const token = req.headers['authorization'];

    if (!token) {
        return res.status(403).send('A token is required for authentication');
    }

    try {
        const decoded = jwt.verify(token.split(" ")[1], 'secret_key'); // แยก 'Bearer' ออกจากโทเค็น
        req.user = decoded; // บันทึกข้อมูลผู้ใช้ลงใน request
        // console.log(req.query); // for test
    } catch (err) {
        return res.status(401).send('Invalid Token');
    }
    
    return next();
};
