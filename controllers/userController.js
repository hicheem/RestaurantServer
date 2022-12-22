const jwt = require('jsonwebtoken');
const db = require('../config/db');

const loginUser = (req, res) => {
    const email = req.query.email
    const password = req.query.password
    db.execute("SELECT * from users where email = ?", [email],
    (err, result)=>{
        if(result[0]){
            if(result[0].password === password){
                result[0].photo = `http://localhost:${process.env.PORT}/images/${result[0].photo}`
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


module.exports = {
    loginUser
}

