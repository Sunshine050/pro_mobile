const Booking = require('../models/booking.model');
const Room = require('../models/room.model');
const User = require('../models/user.model');

const userData = async (req, res) => {
    const { user_id } = req.params;

    try {
        const userData = await User.profileData(user_id);
        return res.json(userData);
    } catch (error) {
        res.status(500).send('Internal server error');
    }
}

const history = async (req, res) => {
    const { user_id } = req.params;
    const { role } = req.user;

    try {
        Booking.getAllBooking(user_id, role, (err, result) => {
            if (err) return res.status(500).send('Internal server error');
            res.json(result);
        });
    } catch (error) {
        res.status(500).send('Internal server error');
    }
}

// data for dashboard
const summary = async (req, res) => {
    const { role } = req.user;

    try {
        if (role === "staff" || role === "approver") {
            Room.getSlotSummary((err, result) => {
                if (err) { res.status(500).send("Internal Server Error") }
                return res.json(result);
            });
        } else {
            return res.status(403).send('Forbidden to access the data');
        }
    } catch (err) {
        console.error(err);
        res.status(500).send("Internal Server Error");
    }
};

module.exports = {
    userData,
    history,
    summary // data for dashboard
}