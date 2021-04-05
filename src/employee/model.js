const getEmployees = "select * from employee";
const getEmployeeById = "select * from employee where id = $1";
const getEmployeeByFunc = "select getemployee($1)";
const checkEmail = "select * from employee where email = $1";
const addEmployee = "insert into employee (name,email) values($1, $2) RETURNING *";
const addEmployeeDepartment = "insert into employee_department (employee_id,department_id,doj) values($1, $2, $3)";

module.exports = {
    getEmployees,
    getEmployeeById,
    getEmployeeByFunc,
    checkEmail,
    addEmployee,
    addEmployeeDepartment,
}