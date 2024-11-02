const Booking = require('../models/booking.model');
const Room = require('../models/room.model');

const history = (req, res) => {
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
const summary = (req, res) => {
    const { role } = req.user;

    try {
        if (role === "staff" || role === "approver") {
            Room.getSlotSummary((err, result) => {
                if (err) { res.status(500).send("Internal Server Error") }
                res.json(result);
            });
        }
    } catch (err) {
        console.error(err);
        res.status(500).send("Internal Server Error");
    }
};

module.exports = {
    history,
    summary // data for dashboard
}