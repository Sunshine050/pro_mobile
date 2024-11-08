const express = require('express');
const router = express.Router();
const userController = require('../controllers/user.controller');
const { verifyToken } = require('../middleware/auth.middleware');

// for profile
router.get('/userData', verifyToken, userController.userData);
// for history
router.get('/history', verifyToken, userController.history);
// for dashboard
router.get('/dashboard', verifyToken, userController.summary);

module.exports = router;