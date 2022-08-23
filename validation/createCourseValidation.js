const yup = require('yup');

const schema = yup.object({
    nom_form: yup.string().required(),
    courseSpecialization: yup.string().required()    
});

module.exports = schema;