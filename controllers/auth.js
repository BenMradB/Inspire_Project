require('dotenv').config();
const db = require('../config/db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const moment = require('moment');
const multer = require('multer');
const path = require('path');
const sharp = require('sharp');
const nodeMailer = require('nodemailer');

const storage = multer.diskStorage({
    destination: `./public/images/upload`,
    filename: (req, file, cb) => {
        cb(null, `${file.fieldname}-${Date.now()}${path.extname(file.originalname)}`);
    }
});

const upload = multer({
    storage,
    limits: {
        fileSize: 1000000
    }
}).single('avatar');

// GET The Home Page
const getHomePage = (req, res) => {
    if (!req.cookies['auth-token']) return res.render('index');
    const decoded = jwt.verify(req.cookies['auth-token'], process.env.ACCESS_TOKEN_SECRET);
    if (decoded.role === 'student') return res.redirect('/dashboard');
    if (decoded.role === 'trainer') return res.redirect('/trainer-dashboard');

};

// // GET The Login Page
const getLoginPage = (req, res) => {
    return res.render('login');
};

// GET The Sign Up Page
const getSignupPage = (req, res) => {
    return res.render('signup');
}

// GET Dashboard Page 
const getDashboardPage = (req, res) => {
    return res.render('dashboard', { user: req.user });
}

// GET Profile Page
const getProfilePage = (req, res) => {
    return res.render('profile', { user: req.user });
}

// GET The Edit Profile Page
const getEditProfilePage = (req, res) => {
    return res.render('edit-profile', { user: req.user });
}

// Get the Messages Page
const getMessagesPage = (req, res) => {
    let sql = `SELECT id_formateur FROM formation, enroulement WHERE formation.id_form = enroulement.id_formation AND enroulement.id_etudiant = ${req.user.id}`;
    db.query(sql, (err, result1) => {
        if (err) throw err;
        if (result1.length === 0 ) return res.redirect(`/dashboard?error=${encodeURIComponent('You Must By At Least One Formation To Become Have An Access To The Messages Page ')}`);
        let arr = [];
        result1.forEach(ele => {
            let sql = `SELECT email, trainerName, avatar, nom_form FROM formateur, formation WHERE formateur.id_formateur = ${ele.id_formateur} AND formation.id_formateur = ${ele.id_formateur}`;
            db.query(sql, (err, result) => {    
                if (err) throw err;
                result[0].id_formateur = ele.id_formateur;
                arr.push(result[0]);
                if (arr.length === result1.length) {

                    const key = 'id_formateur';

                    const arrayUniqueByKey = [...new Map(arr.map(item => [item[key], item])).values()];

                    return res.render('dshb-messages', { user: req.user, contacts: arrayUniqueByKey });
                }
            });
        });
    });
}

// Get Tge trainer Dashboard Page
const getTrainerDashboardPage = (req, res) => {
    return res.render('trainer-dashboard', { user: req.user });
}

// Get the Trainer Messages Page
const getTrainerMessagesPage = (req, res) => {
    let sql = `SELECT id_form FROM formation WHERE id_formateur = ${req.user.id_formateur}`;
    db.query(sql, (err , result1) => {
        if (err) throw err;
        
        if (result1.length === 0 ) return res.redirect(`/trainer-dashboard?error=${encodeURIComponent('Yu Must Create At Least One Course To Be Have A Contact With Your Students ')}`);
        
        let sql = `SELECT id FROM user, enroulement WHERE user.id = enroulement.id_etudiant AND enroulement.id_format = ${req.user.id_formateur}`;
        
        db.query(sql, (err, result2) => {
            if (err) throw err;

            if (result2.length === 0 ) return res.redirect(`/trainer-dashboard?error=${encodeURIComponent(`You Don't Have A contact Yet , Cause No One By Your Course(s) `)}`);

            let arr = [];

            result2.forEach(ele => {
                let sql = `SELECT email, userName, avatar, role FROM user WHERE id = ${ele.id}`;

                db.query(sql, (err, result3) => {
                    if (err) throw err;
                    result3[0].id = ele.id;
                    arr.push(result3[0]);
                    if (arr.length === result2.length) {

                        const key = 'id';

                        const arrayUniqueByKey = [...new Map(arr.map(item => [item[key], item])).values()];
                        
                        return res.render('dshb-trainer-messages', { user: req.user, contacts: arrayUniqueByKey });
                    }
                });
            })
        });
    });
    
}

// Get The Trainer Login Page
const getTrainerLoginPage = (req, res) => {
    return res.render('trainer-login');
};

// Get the Edit Trainer Profile Page
const getEditTrainerProfilePage = (req, res) => {
    return res.render('edit-trainer-profile', { user: req.user });
}

const getChatWithSomeOnePage = (req, res) => {
    
    let sql = `SELECT id_formateur, trainerName, email, phone, avatar, role FROM formateur WHERE id_formateur = '${req.params.id}'`;
    db.query(sql, (err, result) => {
        if (err) throw err;
        let sql = `SELECT contenu, whosTheSender, time FROM message WHERE id_etudiant = ${req.user.id} AND id_formateur = ${result[0].id_formateur}`;
        db.query(sql, (err, result2) => {
            if (err) throw err;
            
            if (result2.length > 0 ) {
                let whoSend = '';
                let arr = [];
                result2.forEach(message => {
                    if (req.user.id === message.whosTheSender) {
                        whoSend = 'me';
                    } else {
                        whoSend = 'not me';
                    }
                    message.whoSend = whoSend;
                    arr.push(message);

                    if (arr.length === result2.length) {
                        return res.render('chat-with-someone', { user: req.user, info: result[0], messages: arr });
                    }
                });
            } else {
                return res.render('chat-with-someone', { user: req.user, info: result[0], messages: result2 });
            }
        });
    });
}

// Get Chating With A student Page 
const getChatWithAStudentPage = (req, res) => {
    let sql = `SELECT id, userName, email, phone, role, avatar FROM user WHERE id = '${req.params.id}'`;
    db.query(sql, (err, result) => {
        if (err) throw err;
        let sql = `SELECT contenu, whosTheSender, time FROM message WHERE id_formateur = ${req.user.id_formateur} AND id_etudiant = ${result[0].id}`;
        db.query(sql, (err, result2) => {
            if (err) throw err;
            
            if (result2.length > 0 ) {
                let whoSend = '';
                let arr = [];
                result2.forEach(message => {
                    if (req.user.id_formateur === message.whosTheSender) {
                        whoSend = 'me';
                    } else {
                        whoSend = 'not me';
                    }
                    message.whoSend = whoSend;
                    arr.push(message);

                    if (arr.length === result2.length) {
                        return res.render('chat-with-student', { user: req.user, info: result[0], messages: arr });
                    }
                });
            } else {
                return res.render('chat-with-student', { user: req.user, info: result[0], messages: result2 });
            }
        });
    });
}

// Get Create Course Page
const getCreateCoursePage = (req, res) => {
    return res.render('dshb-create-course', { user: req.user});
}

// Get All Trainer Courses
const getTrainerCourses = (req, res) => {
    let sql = `SELECT * FROM formation WHERE id_formateur = ${req.user.id_formateur}`;
    db.query(sql, (err, result) => {
        if (err) throw err;

        return res.render('trainer-courses', { user: req.user, myCourses: result });
    });
}

// Get Student Courses Page
const getStudentCoursesPage = (req, res) => {
    let sql = `SELECT id_formation FROM enroulement WHERE id_etudiant = ${req.user.id}`;
    db.query(sql, (err, result) => {
        if (err) throw err;

        if (result.length === 0) return res.redirect(`/by-courses?error=${encodeURIComponent(`you don't have any course yet by a course now from here `)}`);

        let arr = [];
        result.forEach(ele => {
            let sql = `SELECT * FROM formation WHERE id_form = ${ele.id_formation}`;
            db.query(sql, (err, result2) => {
                if (err) throw err;

                arr.push(result2[0]);

                if (arr.length === result.length) {
                    return res.render('student-courses', { user: req.user, myCourses: arr });
                }

            });
        });
    });
}

// Get Edit Course Page
const getEditCoursePage = (req, res) => {
    let sql = `SELECT thubmnail FROM formation WHERE id_form = ${req.params.id}`;

    db.query(sql, (err, result) => {
        if (err) throw err;

        return res.render('edit-course', { user: req.user, courseId: req.params.id, thubmnail: result[0].thubmnail });
    });
}

// Get By Courses Page
const getByCoursesPage = (req, res) => {
    let sql = `SELECT * FROM formation`;

    db.query(sql, (err, result) => {
        if(err) throw err;

        return res.render('by-courses', { user: req.user, allCourses: result });
    });
}

// Logout
const logout = (req, res) => {
    res.clearCookie('auth-token');
    return res.redirect('/');
}

// Login A User
const login = (req, res) => {
    const { email, password } = req.body;
    
    let sql = `SELECT email FROM user WHERE email = '${email}'`;
    
    db.query(sql, (err, result) => {

        if (err) throw err;
        
        if (result.length === 0) return res.redirect(`/login?error=${encodeURIComponent('no account under thart email ')}`);
            
        let sql = `SELECT * FROM user WHERE email = '${email}'`;
        
        db.query(sql, async(err, result) => {

            if (err) throw err;

            if (!await bcrypt.compare(password, result[0].password)) return res.redirect(`/login?error=${encodeURIComponent('password incorrect')}`);
            
            const token = jwt.sign({ id: result[0].id, role: result[0].role }, process.env.ACCESS_TOKEN_SECRET, {
                expiresIn: process.env.TOKEN_EXPIRES
            });

            const cookieOptions = {
                expiresIn: new Date( Date.now() + process.env.COOKIE_EXPIRES * 24 * 60 * 60 * 1000 ),
                httpOnly: true
            };

            res.cookie('auth-token', token, cookieOptions);

            return res.redirect('/dashboard');
        });
    });
}

// Sign Up A User
const signup = (req, res) => {
    const { firstName, lastName, userName, email, password, passwordConfirm, phone, cin, gender, birthday, levelOfStudy } = req.body;
    if (phone.length !== 8 || cin.length !== 8) return res.redirect(`/signup?error=${encodeURIComponent('the length of the cin and the phone equal to 8')}`);
    
    if (cin[0] !== '0' && cin[0] !== '1') return res.redirect(`/signup?error=${encodeURIComponent('cin must start with "0" or "1"')}`);

    if (password !== passwordConfirm) return res.redirect(`/signup?error=${encodeURIComponent('passwords do not mutch ')}`);

    let sql = `SELECT id, email FROM user WHERE email = '${email}'`;

    db.query(sql, async (err, result) => {
        if (err) throw err;

        if (result.length > 0) return res.redirect(`/signup?error=${encodeURIComponent('that email already in use')}`);

        let salt = await bcrypt.genSalt(10);
        let hashedPassword = await bcrypt.hash(password, salt);

        let sql = `INSERT INTO user SET ?`;

        db.query(sql, { firstName, lastName, userName, email, password: hashedPassword, phone, cin, gender, birthday, levelOfStudy, role: 'student' }, (err, row) => {
            if (err) throw err;

            let sql = `SELECT * FROM user WHERE email = '${email}'`;
            
            db.query(sql, (err, result) => {
                if (err) throw err;
                
                const token = jwt.sign({ id: result[0].id, role: result[0].role }, process.env.ACCESS_TOKEN_SECRET, {
                    expiresIn: process.env.TOKEN_EXPIRES
                });

                const cookieOptions = {
                    expiresIn: new Date( Date.now() + process.env.COOKIE_EXPIRES * 24 * 60 * 60 * 1000 ),
                    httpOnly: true
                };
    
                res.cookie('auth-token', token, cookieOptions);
    
                return res.redirect('/dashboard');
            });
        });
    });
};

// Edit The Avatar Of The User
const editAvatar = (req, res) => {
    upload(req, res, (err) => {
        if (err) return res.redirect(`/profile/edit-profile/${req.params.id}?error=${encodeURIComponent(err)}`);
        
        if (!req.file) return res.redirect(`/profile/edit-profile/${req.params.id}?error=${encodeURIComponent('Choose an avatar ')}`);

        // extract the file extention from the uploaded file
        const fext = path.extname(req.file.originalname);

        if ((fext !== '.jpg' && fext !== '.jpeg' && fext !== '.png') && (fext !== '.JPG' && fext !== '.JPEG' && fext !== '.PNG')) return res.redirect(`/profile?error=${encodeURIComponent('accepted extention : jpg, jpeg, png')}`);

        let sql = `UPDATE user SET avatar = '${req.file.filename}' WHERE id = ${req.params.id}`;

        db.query(sql, (err, row) => {
            if (err) throw err;

            return res.redirect(`/profile/edit-profile/${req.params.id}?success=${encodeURIComponent('avatar changed successfully')}`);
        })

    });
};

// Edit The Information About The User
const editProfile = (req, res) => {
    const { firstName, lastName, userName, email, phone, cin, gender, birthday, levelOfStudy } = req.body;

    if (phone.length !== 8 || cin.length !== 8) return res.redirect(`/profile/edit-profile/${req.params.id}?error=${encodeURIComponent('the length of the cin and the phone equal to 8')}`);
    
    if (cin[0] !== '0' && cin[0] !== '1') return res.redirect(`/profile/edit-profile/${req.params.id}?error=${encodeURIComponent('cin must start with "0" or "1"')}`);

    let sql = `UPDATE user SET ? WHERE id = ${req.params.id}`;

    db.query(sql, { firstName, lastName, userName, email, phone, cin, gender, birthday, levelOfStudy }, (err, row) => {
        if (err) throw err;

        return res.redirect(`/profile/edit-profile/${req.params.id}?success=${encodeURIComponent('profile information updated successfully')}`);
    });
};

// Edit Trainer Profile
const editTrainerProfile = (req, res) => {
    const { firstName, lastName, trainerName, email, phone, cin, gender, birthday } = req.body;

    if (phone.length !== 8 || cin.length !== 8) return res.redirect(`/profile/edit-trainer-profile/${req.params.id}?error=${encodeURIComponent('the length of the cin and the phone equal to 8')}`);
    
    if (cin[0] !== '0' && cin[0] !== '1') return res.redirect(`/profile/edit-trainer-profile/${req.params.id}?error=${encodeURIComponent('cin must start with "0" or "1"')}`);

    let sql = `UPDATE formateur SET ? WHERE id_formateur = ${req.params.id}`;

    db.query(sql, { firstName, lastName, email, trainerName,  phone, cin, birthday, gender }, (err, row) => {
        if (err) throw err;

        return res.redirect(`/profile/edit-trainer-profile/${req.params.id}?success=${encodeURIComponent('profile information updated successfully')}`);
    });
}

// Edit (Change) The Pasword
const editPassword = (req, res) => {
    const { currentPassword, password, retypedPassword } = req.body;

    let sql = `SELECT password FROM user WHERE id = ${req.params.id}`;

    db.query(sql, async (err, result) => {
        if (err) throw err;

        if (!await bcrypt.compare(currentPassword, result[0].password)) return res.redirect(`/profile/edit-profile/${req.params.id}?error=${encodeURIComponent('password incorrect')}`);

        if (password !== retypedPassword) return res.redirect(`/profile/edit-profile/${req.params.id}?error=${encodeURIComponent('passwords do not mutch')}`);

        let salt = await bcrypt.genSalt(10);
        let hashedPassword = await bcrypt.hash(password, salt);

        let sql = `UPDATE user SET password = '${hashedPassword}' WHERE id = ${req.params.id}`;

        db.query(sql, (err, row) => {
            if (err) throw err;

            return res.redirect(`/profile/edit-profile/${req.params.id}?success=${encodeURIComponent('password changed successfully')}`);
        });
    });
};

const storePrivateMessages = (req, res) => {
    const { message } = req.body;

    let sql = `INSERT INTO message SET ?`;
    db.query(sql, { id_etudiant: req.user.id, id_formateur: req.params.id, contenu: message, whosTheSender: req.user.id, time: moment().format('h:mm a') }, (err, rows) => {
        if (err) throw err;
        return res.redirect(`/start-chating/with/${req.params.id}`);
    });
};

const trainerLogin = (req, res) => {
    const { email, password } = req.body;
    
    let sql = `SELECT email FROM formateur WHERE email = '${email}'`;
    
    db.query(sql, (err, result) => {

        if (err) throw err;
        
        if (result.length === 0) return res.redirect(`/trainer-login?error=${encodeURIComponent('You Are Still Not A Trainer')}`);
            
        let sql = `SELECT * FROM formateur WHERE email = '${email}'`;
        
        db.query(sql, async(err, result) => {

            if (err) throw err;

            if (!await bcrypt.compare(password, result[0].password)) return res.redirect(`/trainer-login?error=${encodeURIComponent('password incorrect')}`);
            
            const token = jwt.sign({ id: result[0].id_formateur, role: result[0].role }, process.env.ACCESS_TOKEN_SECRET, {
                expiresIn: process.env.TOKEN_EXPIRES
            });

            const cookieOptions = {
                expiresIn: new Date( Date.now() + process.env.COOKIE_EXPIRES * 24 * 60 * 60 * 1000 ),
                httpOnly: true
            };

            res.cookie('auth-token', token, cookieOptions);

            return res.redirect('/trainer-dashboard');
        });
    });

};

const editTrainerAvatar = (req, res) => {
    upload(req, res, (err) => {
        if (err) return res.redirect(`/profile/edit-trainer-profile/${req.params.id}?error=${encodeURIComponent(err)}`);
        
        if (!req.file) return res.redirect(`/profile/edit-trainer-profile/${req.params.id}?error=${encodeURIComponent('Choose an avatar ')}`);
        // extract the file extention from the uploaded file
        const fext = path.extname(req.file.originalname);

        if ((fext !== '.jpg' && fext !== '.jpeg' && fext !== '.png') && (fext !== '.JPG' && fext !== '.JPEG' && fext !== '.PNG')) return res.redirect(`/profile?error=${encodeURIComponent('accepted extention : jpg, jpeg, png')}`);

        let sql = `UPDATE formateur SET avatar = '${req.file.filename}' WHERE id_formateur = ${req.params.id}`;

        db.query(sql, (err, row) => {
            if (err) throw err;

            return res.redirect(`/profile/edit-trainer-profile/${req.params.id}?success=${encodeURIComponent('avatar changed successfully')}`);
        })

    });
}

const editTrainerPassword = (req, res) => {
    const { currentPassword, password, retypedPassword } = req.body;

    let sql = `SELECT password FROM formateur WHERE id_formateur = ${req.params.id}`;

    db.query(sql, async (err, result) => {
        if (err) throw err;

        if (!await bcrypt.compare(currentPassword, result[0].password)) return res.redirect(`/profile/edit-trainer-profile/${req.params.id}?error=${encodeURIComponent('password incorrect')}`);

        if (password !== retypedPassword) return res.redirect(`/profile/edit-trainer-profile/${req.params.id}?error=${encodeURIComponent('passwords do not mutch')}`);

        let salt = await bcrypt.genSalt(10);
        let hashedPassword = await bcrypt.hash(password, salt);

        let sql = `UPDATE formateur SET password = '${hashedPassword}' WHERE id_formateur = ${req.params.id}`;

        db.query(sql, (err, row) => {
            if (err) throw err;

            return res.redirect(`/profile/edit-trainer-profile/${req.params.id}?success=${encodeURIComponent('password changed successfully')}`);
        });
    });
}

const storePrivateTrainerMessages = (req, res) => {
    const { message } = req.body;

    let sql = `INSERT INTO message SET ?`;
    db.query(sql, { id_etudiant: req.params.id, id_formateur: req.user.id_formateur, contenu: message, whosTheSender: req.user.id_formateur, time: moment().format('h:mm a') }, (err, rows) => {
        if (err) throw err;
        return res.redirect(`/start-chating/with-student/${req.params.id}`);
    });
}

// Create A Course 
const createCourse = (req, res) => {
    const { nom_form, courseSpecialization, description } = req.body;

    let sql = `INSERT INTO formation SET ?`;
    db.query(sql, { nom_form, courseSpecialization, description, nb_videos: 0, duree: '00:00', date_creation: moment().format('YYYY-MM-D'), id_formateur: req.params.id }, (err, rows) => {
        if (err) throw err;

        res.redirect(`${req.url}?success=${encodeURIComponent(`course has been registerd`)}`);
    });
}

const byACourse = (req, res) => {
    let sql = `SELECT solde FROM user WHERE id = ${req.user.id}`;
    db.query(sql, (err, result) => {
        if (err) throw err;

        if (result[0].solde === 0 ) return res.redirect(`/by-courses?error=${encodeURIComponent(`You don't have balance to buy any course, please charge your account`)}`);

        let sql = `SELECT nom_form, prix, id_formateur FROM formation WHERE id_form = ${req.params.id}`;
        db.query(sql, (err, result2) => {
            if (err) throw err;

            if (result2[0].prix > result[0].solde) return res.redirect(`/by-courses?error=${encodeURIComponent(`You don't have enough balance to buy a course`)}`);

            let sql = `INSERT INTO enroulement SET ?`;
            db.query(sql, {id_formation: req.params.id, id_etudiant: req.user.id, id_format: result2[0].id_formateur}, (err, rows) => {
                if (err) throw err;

                let sql = `UPDATE user SET solde = solde - ${result2[0].prix} WHERE id = ${req.user.id}`;
                db.query(sql, (err, rows) => {
                    if (err) throw err;

                    let sql = `SELECT email FROM formateur WHERE id_formateur = ${result2[0].id_formateur}`;
                    db.query(sql, (err, result3) => {
                        if (err) throw err;

                        const transporter = nodeMailer.createTransport({
                            service: 'gmail',
                            auth : {
                                user: 'bilelbenmrad2001@gmail.com',
                                pass: 'cghbpakvhlqkojny'
                            }
                        });

                        const mailOptions = {
                            from: 'bilelbenmrad2001@gmail.com',
                            to: `${result3[0].email}`,
                            subject: 'Email From Inspire Platform',
                            html: `<h3> Hello Sir Your ${result2[0].nom_form} Course  has been purchased</h3>`
                        };

                        transporter.sendMail(mailOptions, (err, info) => {
                            if (err) throw err;
                            
                            return res.redirect(`/by-courses?success=${encodeURIComponent('You Buy This Course')}`);
                        });
                    });
                });
            });
        });
    });
}


module.exports = { getHomePage, getLoginPage, getSignupPage, getDashboardPage, getEditProfilePage, getProfilePage, getMessagesPage, getTrainerMessagesPage, getChatWithSomeOnePage, getTrainerLoginPage, getTrainerDashboardPage, getEditTrainerProfilePage, getChatWithAStudentPage,  getCreateCoursePage, getTrainerCourses, getEditCoursePage, getByCoursesPage, getStudentCoursesPage, logout, login, signup, trainerLogin, editAvatar, editProfile, editPassword, editTrainerPassword, storePrivateMessages, editTrainerProfile, editTrainerAvatar, storePrivateTrainerMessages, createCourse, byACourse };