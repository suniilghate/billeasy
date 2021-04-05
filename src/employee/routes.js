const { Router } = require('express');
const controller = require('./controller');

const router = Router();

router.get('/', controller.getEmployees);
router.get('/:id', controller.getEmployeeById);
router.get('/:id/:byfunc', controller.getEmployeeByFunc);
router.post('/', controller.addEmployee);

module.exports = router; 