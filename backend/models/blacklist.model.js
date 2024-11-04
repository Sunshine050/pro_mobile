const db = require('../config/db.config');

const Blacklist = {
    addToken: (token, expiresAt) => {
        return new Promise((resolve, reject) => {
            db.query('INSERT INTO blacklist (token, expires_at) VALUES (?, ?)', [token, expiresAt], (error, results) => {
                if (error) return reject(error);
                resolve(results);
            });
        });
    },
};

module.exports = Blacklist;