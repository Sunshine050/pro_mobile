// user.model.js
const db = require('../config/db.config');

const User = {
  // ฟังก์ชันที่ค้นหาผู้ใช้ด้วย username
  findByUsername: (username) => {
    return new Promise((resolve, reject) => {
      db.query('SELECT * FROM users WHERE username = ?', [username], (error, results) => {
        if (error) return reject(error);
        resolve(results[0]); // คืนค่าผู้ใช้แรก (ถ้ามี)
      });
    });
  },
  
  // ฟังก์ชันที่ค้นหาผู้ใช้ด้วย ID
  findById: (id) => {
    return new Promise((resolve, reject) => {
      db.query('SELECT * FROM users WHERE id = ?', [id], (error, results) => {
        if (error) return reject(error);
        resolve(results[0]); // คืนค่าผู้ใช้แรก (ถ้ามี)
      });
    });
  },
  
  // ฟังก์ชันอื่น ๆ
  getAllUsers: () => {
    return new Promise((resolve, reject) => {
      db.query('SELECT * FROM users', (error, results) => {
        if (error) return reject(error);
        resolve(results); // คืนค่ารายการผู้ใช้ทั้งหมด
      });
    });
  },
  
  create: (user) => {
    return new Promise((resolve, reject) => {
      db.query('INSERT INTO users SET ?', user, (error, results) => {
        if (error) return reject(error);
        resolve(results);
      });
    });
  },
  
  update: (user, id) => {
    return new Promise((resolve, reject) => {
      db.query('UPDATE users SET ? WHERE id = ?', [user, id], (error, results) => {
        if (error) return reject(error);
        resolve(results);
      });
    });
  },
  
  delete: (id) => {
    return new Promise((resolve, reject) => {
      db.query('DELETE FROM users WHERE id = ?', [id], (error, results) => {
        if (error) return reject(error);
        resolve(results);
      });
    });
  }
};

module.exports = User;
