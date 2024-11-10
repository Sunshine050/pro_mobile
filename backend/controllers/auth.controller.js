const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const blacklistModel = require('../models/blacklist.model');
const User = require('../models/user.model');
require('dotenv').config();

API_KEY = process.env.API_KEY || "my-secret-key";

// Register
exports.register = async (req, res) => {
    const { username, password, email } = req.body;

    // แฮชรหัสผ่านก่อนบันทึก
    const hashedPassword = await bcrypt.hash(password, 10);

    // บันทึกข้อมูลผู้ใช้ลงฐานข้อมูล
    const newUser = {
        username,
        password: hashedPassword,
        email,
    };

    try {
        // บันทึกผู้ใช้ใหม่ลงฐานข้อมูล
        const isDuplicate = await User.findByUsername(username);
        if (isDuplicate) {
            return res.status(409).json({ message: 'Username already exists' });
        }
        await User.create(newUser);
        return res.status(201).json({ message: 'Register successfully'});
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: 'Register failed' });
    }
};

// Login
exports.login = async (req, res) => {
    const { username, password } = req.body;

    // ตรวจสอบผู้ใช้ในฐานข้อมูล
    const user = await User.findByUsername(username); // สมมติว่ามีฟังก์ชันนี้

    if (!user) {
        return res.status(404).json({ message: 'User not found' });
    }

    // ตรวจสอบรหัสผ่าน
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
        return res.status(401).json({ message: 'Invalid password' });
    }

    // สร้าง token พร้อมข้อมูลบทบาทและ Object ID
    const token = jwt.sign({ userId: user.id, username: user.username, role: user.role }, API_KEY, { expiresIn: '14d' });

    // ส่ง token และ userId กลับไปใน response
    return res.status(200).json({ token });
    // ส่ง message, token, และ userId กลับไปใน response
    // return res.status(200).json({ message: 'Login successfully', token, userId: user._id });
};

// Logout
exports.logout = async (req, res) => {
    const token = req.headers['authorization'].split(" ")[1]; // ดึงโทเค็นจาก header
    const expiresAt = req.user.exp;

    if (!token) {
        return res.status(400).json({ message: 'Token is required' });
    }

    try {
        // เพิ่มโทเค็นไปยัง blacklist
        await blacklistModel.addToken(token, expiresAt); // แยก 'Bearer' ออกจากโทเค็น
        return res.status(200).json({ message: 'Logout successful' });
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: 'Logout failed' });
    }
};

// Get all users
exports.getAllUsers = async (req, res) => {
    try {
        const users = await User.getAllUsers();
        res.status(200).json(users);
    } catch (error) {
        res.status(500).json({ error: 'Failed to fetch users' });
    }
};

// อัปเดตผู้ใช้
exports.updateUser = async (req, res) => {
    const userId = req.params.id;
    const userUpdates = req.body;

    try {
        // ค้นหาผู้ใช้จาก ID
        const user = await User.findById(userId);
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        // ทำการอัปเดตผู้ใช้
        const result = await User.update(userUpdates, userId);
        res.status(200).json({ message: 'User updated successfully', result });
    } catch (error) {
        console.error('Error updating user:', error);
        res.status(500).json({ error: 'Failed to update user' });
    }
};

// ลบผู้ใช้
exports.deleteUser = async (req, res) => {
    const userId = req.params.id;

    try {
        // ค้นหาผู้ใช้จาก ID
        const user = await User.findById(userId);
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        // ทำการลบผู้ใช้
        const result = await User.delete(userId);
        res.status(200).json({ message: 'User deleted successfully', result });
    } catch (error) {
        console.error('Error deleting user:', error);
        res.status(500).json({ error: 'Failed to delete user' });
    }
};
