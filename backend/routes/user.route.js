const express = require('express');
const router = express.Router();
const userController = require('../controllers/user.controller');
const { verifyToken } = require('../middleware/auth.middleware');

router.get('/history', verifyToken, userController.history);
router.get('/dashboard', verifyToken, userController.summary);

module.exports = router;