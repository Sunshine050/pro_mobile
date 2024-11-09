// auth.routes.js
const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth.controller');
const { verifyToken } = require('../middleware/auth.middleware'); 


router.post('/register', authController.register);
router.post('/login', authController.login);
router.post('/logout', verifyToken, authController.logout); 

// for dev
router.put('/users/', authController.updateUser); 
router.delete('/users/:id', authController.deleteUser);
router.get('/users', authController.getAllUsers);  

module.exports = router;
