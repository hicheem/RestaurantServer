const jwt = require('jsonwebtoken');
const db = require('../config/db');

const loginUser = (req, res) => {
    const email = req.query.email
    const password = req.query.password
    db.execute("SELECT * from users where email = ?", [email],
    (err, result)=>{
        if(result[0]){
            if(result[0].password === password){
                // result[0].photo = `http://localhost:${process.env.PORT}/images/${result[0].photo}`
                let user = {'id':result[0].id,'firstName':result[0].firstName, 
                            'lastName':result[0].lastName, 'email':result[0].email, 
                            'mobile':result[0].mobile, 'password':result[0].password, 
                            'photo':result[0].photo, 'city':result[0].city}
                
                const token = jwt.sign(
                    {id:result[0].id, role: result[0].role},
                    "restaurant",
                    {expiresIn:"24h"}
                )
                res.status(200).send({'email': true, 'password':true, 
                                        role: result[0].role, token, user})
            }
            else {
                res.status(200).send({'email': true, 'password':false})   
            }        
        }   
        else{
            res.status(200).send({'email': false, 'password':false})   
        }
    }
    );
}

const getUsers = (req, res, next) => {

    db.execute('select id, firstName, lastName, mobile, email, role from users',
        (err, result) => {
            if(err)
                res.status(500).send({message:"une erreur a ete survenu"})
            else
                res.status(200).send({users: result})
        }
    )
}

const addUser = (req, res, next) => {
    
    const role = req.payload.role;
    const user = req.body
    console.log(role, user);
    if(role === 'admin'){
        db.execute(`insert into users (firstName,lastName, mobile, email, password, role)
                    values (?, ?, ?, ?, ?, ?)`,
            [user.firstName, user.lastName, user.mobile, user.email, user.password, user.role],
            (err, result) => {
                if(err)
                {
                    res.status(500).send({message:err})
                }
                else{
                    res.status(201).send({message:'User added successfully'})
                }
            }
        )
    }
    else{
        res.status(401).send({message:"Vous etes pas autorise a ajouter des utilisateur"})
    }
}

const updateUser = (req, res) => {
    const id = req.query.id
    const role = req.body.role;
    console.log(id, role)
    db.execute('update users set role=? where id = ?', [role, id],
        (err, result) => {
            if(err){
                console.log(err)
            }
            else{
                res.status(201).send({message:'User updated successfully'})
            }
        }
    )
}

const deleteUser = (req, res) => {
    
    const id = req.query.id
    const role = req.payload.role
    if(role === 'admin'){
        db.execute('delete from users where id = ?', [id],
        (err, result) => {
            if(err){
                console.log(err);
            }
            else{
                res.status(204).send({message:`User with id=${id} deleted successfully`})
            }
        }
    )
    }
    else{
        res.status(401).send({message:"Unauthorized"})
    }
}


module.exports = {
    loginUser,
    getUsers,
    addUser,
    updateUser,
    deleteUser
}

