const { Router } = require('express');
const router = Router();
const { getHomePage, getLoginPage, getSignupPage, getDashboardPage, getEditProfilePage, getProfilePage, getMessagesPage, getTrainerMessagesPage, getChatWithSomeOnePage, getTrainerLoginPage, getTrainerDashboardPage, getEditTrainerProfilePage, getChatWithAStudentPage, getCreateCoursePage, getTrainerCourses, getEditCoursePage, getByCoursesPage, getStudentCoursesPage, logout, login, signup, editAvatar, editProfile, editPassword, editTrainerPassword, storePrivateMessages, trainerLogin, editTrainerProfile, editTrainerAvatar, storePrivateTrainerMessages, createCourse, byACourse } = require('../controllers/auth');
const { addVideo } = require('../controllers/uploadVideo');
const { editCourseThubmnail } = require('../controllers/uploadCourseThubmnails');
const loggedin = require('../middlewares/loggedin');
const loggedout = require('../middlewares/loggedout');
const trainerLoggedin = require('../middlewares/trainerLoggedin');
const validation = require('../middlewares/userValidationMiddleware');
const loginSchema = require('../validation/loginValidation');
const signupSchema = require('../validation/signupValidations');
const editProfileSchema = require('../validation/editProfileValidation');
const editPasswordSchema = require('../validation/editPasswordValidation');
const chatSchema = require('../validation/chatValidation');
const trainereditProfileSchema = require('../validation/trainereditProfileValidation');
const createCourseSchema = require('../validation/createCourseValidation');

router.get('/', getHomePage);
router.get('/dashboard', loggedin, getDashboardPage);
// router.get('/profile', loggedin, getProfilePage);
router.get('/logout', loggedin, logout);

router.get('/trainer-dashboard', trainerLoggedin, getTrainerDashboardPage);
router.post('/profile/edit-trainer-avatar/:id', editTrainerAvatar);
router.route('/trainer-login').get(loggedout, getTrainerLoginPage).post(validation(loginSchema), trainerLogin);
router.route('/trainer-contact').get(trainerLoggedin, getTrainerMessagesPage);
router.route('/profile/edit-trainer-profile/:id').get(trainerLoggedin, getEditTrainerProfilePage).post(validation(trainereditProfileSchema), editTrainerProfile);
router.post('/profile/edit-trainer-password/:id', validation(editPasswordSchema), editTrainerPassword);

router.post('/profile/edit-avatar/:id', editAvatar);
router.post('/profile/edit-password/:id', validation(editPasswordSchema), editPassword);

router.route('/login').get(loggedout, getLoginPage).post(validation(loginSchema), login);
router.route('/signup').get(loggedout, getSignupPage).post(validation(signupSchema), signup);
router.route('/profile/edit-profile/:id').get(loggedin, getEditProfilePage).post(validation(editProfileSchema), editProfile);
router.route('/start-chating').get(loggedin, getMessagesPage);

router.route('/start-chating/with/:id').get(loggedin, getChatWithSomeOnePage).post(loggedin, validation(chatSchema), storePrivateMessages);
router.route('/start-chating/with-student/:id').get(trainerLoggedin, getChatWithAStudentPage).post(trainerLoggedin, validation(chatSchema), storePrivateTrainerMessages);

// router.post('/delete-trainer-conversation/:id', deleteTrainerConversation);

router.route('/create-course/:id').get(trainerLoggedin, getCreateCoursePage).post(validation(createCourseSchema), createCourse);
router.get('/trainer-courses', trainerLoggedin, getTrainerCourses);
router.get('/edit-course/:id', trainerLoggedin, getEditCoursePage);
router.post('/edit-course-thubmnail/:id', editCourseThubmnail);
router.post('/add-video/:id', trainerLoggedin, addVideo);

router.get('/by-courses', loggedin, getByCoursesPage);
router.post('/by-course/:id', loggedin, byACourse);

router.get('/student-courses', loggedin, getStudentCoursesPage);

module.exports = router;