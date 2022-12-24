
const db = require('../config/db');

const addOrder = (req, res, next) => {

    const data = req.body
    db.execute(`insert into orders 
            (userId, status, total, firstName, lastName, mobile, email, payment, method, tableId ) 
            values (? ,?, ?, ?, ?, ?, ?, ?, ?, ? )`, [data.userId, 1, data.totalPrice, data.firstName, data.lastName, data.mobile, data.email, data.payment, data.method, data.tableId ],
        (err, result)=>{
            if(err){
                console.log(err)
            }
            else{
                console.log("orderId : ",result.insertId)
                res.status(201).send({"message":"Order added successfully", orderId:result.insertId})
            }
        }
    )
}

const addOrderItem = (req, res, next) => {

    const item = req.body.item
    const orderId = req.query.id
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