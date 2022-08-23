require('dotenv').config();
const db = require('../config/db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const moment = require('moment');
const multer = require('multer');
const path = require('path');
const sharp = require('sharp');

const storage = multer.diskStorage({
    destination: `./public/images/videoURLs`,
    filename: (req, file, cb) => {
        cb(null, `${file.fieldname}-${Date.now()}${path.extname(file.originalname)}`);
    }
});

const upload = multer({
    storage,
}).single('video_URL');

const addVideo = (req, res) => {
    upload(req, res, (err) => {
        if (err) return res.redirect(`/edit-course/${req.params.id}?error=${encodeURIComponent(err)}`);

        if (!req.file) return res.redirect(`/edit-course/${req.params.id}?error=${encodeURIComponent('Choose The Vide URL  ')}`);

        // extract the file extention from the uploaded file
        const fext = path.extname(req.file.originalname);

        if ( fext !== '.mp4' && fext !== '.MP4' ) return res.redirect(`/edit-course/${req.params.id}?error=${encodeURIComponent('accepted extention : .mp4 OR .MP4')}`);
        let sql = `INSERT INTO videos SET ?`;

        db.query(sql, { course_id: req.params.id, trainer_id: req.user.id_formateur, creation: moment().format('YYYY-MM-D'), video_URL: req.file.filename }, (err, row) => {
            if (err) throw err;

            let sql = `UPDATE formation SET  nb_videos = nb_videos + 1  WHERE id_form = ${req.params.id}`;

            db.query(sql, (err, rows) => {
                if (err) throw err;

                return res.redirect(`/edit-course/${req.params.id}?success=${encodeURIComponent('Vido Added To This Course successfully')}`);

            });
        });
    });
}

module.exports = {addVideo};