const express = require('express');
const router = express.Router();
const userController = require('../controllers/user.controller');
const { verifyToken } = require('../middleware/auth.middleware');

router.get('/userData/:user_id', verifyToken, userController.userData);
router.get('/history/:user_id', verifyToken, userController.history);
router.get('/dashboard', verifyToken, userController.summary);

module.exports = router;