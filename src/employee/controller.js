const pool = require('../../dbcon');
const model = require('./model');

//Fetching all employees
const getEmployees = (req, res) => {
    console.log('Fetching the employees listing');
    pool.query(model.getEmployees, (error, results) => {
        if(error) throw error;
        console.log('Result fetched');
        res.status(200).json(results.rows);
    });
    //pool.end();
}

//Fetch employee by id
const getEmployeeById = (req, res) => {
    const id = parseInt(req.params.id);
    console.log(`Fetching the employee listing for id ${id}`);
    pool.query(model.getEmployeeById, [id], (error, results) => {
        if(error) throw error;
        res.status(200).json(results.rows);
    });
    //pool.end();
}

//Fetch employee by Function
const getEmployeeByFunc = (req, res) => {
    const id = parseInt(req.params.id);
    const byfunc = parseInt(req.params.byfuncc);
    console.log(`function : ${byfunc}`);
    console.log(`id : ${id}`);
    console.log(`Fetching the employee by function for id ${id}`);
    pool.query(model.getEmployeeByFunc, [id], (error, results) => {
        if(error) throw error;
        res.status(200).json(results.rows);
    });
    //pool.end();
}

//Add employee
const addEmployee = (req, res) => {
    const { name, email, department, doj } = req.body;
    //Checks if email exists
    console.log(`add user requests params ${req.body}`);
    console.log('Checking if email exists');
    pool.query(model.checkEmail, [email], (error, results) => {
        if(error) throw error;
        if(results.rows.length){
            res.send("Email already used");
            //pool.end();
        }
    });

    //Now add the employee records in db
    console.log('Adding emloyee records');
    pool.query(model.addEmployee, [name, email], (error, result) => {
        if(error) throw error;
        console.log('Adding employee record');
        console.log(`Catpure the newly created employee id ${ JSON.parse(result.rows[0].id) }`);
        const newEmployeID = result.rows[0]['id'];
        pool.query(model.addEmployeeDepartment, [newEmployeID, department, doj], (error, results) => {
            if(error) throw error;
            console.log('Adding employee record | Employee dEpartment relation added');
            res.status(201).send('Employee added successfully');
            //pool.end();
        })
        //pool.end();  
    })
}


module.exports = {
    getEmployees,
    getEmployeeById,
    getEmployeeByFunc,
    addEmployee,    
}
