// auth.routes.js
const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth.controller');

router.post('/register', authController.register);
router.post('/login', authController.login);
router.put('/users/', authController.updateUser); // เส้นทางสำหรับอัปเดตผู้ใช้
router.delete('/users/:id', authController.deleteUser); // เส้นทางสำหรับลบผู้ใช้
router.get('/users', authController.getAllUsers); // เส้นทางสำหรับดึงผู้ใช้ทั้งหมด

module.exports = router;
