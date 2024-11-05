const db = require('../config/db.config');

const Blacklist = {
    addToken: (token, expiresAt) => {
        return new Promise((resolve, reject) => {
            db.query('INSERT INTO blacklist (token, expires_at) VALUES (?, FROM_UNIXTIME(?))', [token, expiresAt], (error, results) => {
                if (error) return reject(error);
                resolve(results);
            });
        });
    },
    isRevoked: (token) => {
        return new Promise((resolve, reject) => {
            db.query('select token from blacklist where token = ?', [token], (error, results) => {
                if (error) {
                    reject(error);
                } else {
                    resolve(results.length > 0);
                }
            });
        });
    }
};

module.exports = Blacklist;