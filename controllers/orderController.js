
const db = require('../config/db');

const addOrder = (req, res, next) => {

    const {userId, firstName, lastName, email, totalPrice, payment, method} = req.body

    db.execute(`insert into orders 
            (userId, status, total, firstName, lastName, email, payment, method) 
            values (? ,?, ?, ?, ?, ?, ?, ?)`, [userId, 1, totalPrice, firstName, lastName, email, payment, method],
        (err, result)=>{
            if(err){
                console.log(err)
            }
            else{
                console.log(result.insertId)
                res.status(201).send({"message":"Order added successfully", orderId:result.insertId})
            }
        }
    )
}

const addOrderItem = (req, res, next) => {

    const {orderId, item} = req.body
    db.execute(`insert into order_item (orderId, itemId, price, quantity) values(?, ?, ?, ?)`,
        [orderId, item.id, item.price, item.price * item.quantity], 
        (err, result) => {
            if(err)
                console.log(err)
            else {
                res.status(201).send({"message":"Item Order added successfully"})
            }
        }
    )

}

module.exports = {
    addOrder,
    addOrderItem
}