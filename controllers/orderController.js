
const db = require('../config/db');

const addOrder = (req, res, next) => {

    const data = req.body
    db.execute(`insert into orders 
            (userId, status, total, firstName, lastName, mobile, email, payment, method, tableId ) 
            values (? ,?, ?, ?, ?, ?, ?, ?, ?, ? )`, [data.userId, 0, data.totalPrice, data.firstName, data.lastName, data.mobile, data.email, data.payment, data.method, data.tableId ],
        (err, result)=>{
            if(err){
                console.log(err)
            }
            else{
                res.status(201).send({"message":"Order added successfully", orderId:result.insertId})
            }
        }
    )
}

const addOrderItem = (req, res, next) => {

    const item = req.body.item
    const orderId = req.query.id
    db.execute(`insert into order_item (orderId, itemId, price, quantity) values(?, ?, ?, ?)`,
        [orderId, item.id, item.price, item.quantity], 
        (err, result) => {
            if(err)
                console.log(err)
            else {
                res.status(201).send({"message":"Item Order added successfully"})
            }
        }
    )

}


const getOrders = (req, res, next) => {

    const userId = req.query.userId

    db.execute(`select orders.id as orderID, users.firstName, table_top.code as tableCode, table_top.capacity, 
                count(order_item.id) as totalItems, orders.method, orders.total as total, orders.status
                from (
                    ((orders inner join users on orders.userId=users.id)
                    inner join table_top on orders.tableId=table_top.id) 
                    inner join order_item on orders.id=order_item.orderId ) 
                    where orders.userId=(?) group by order_item.orderId`, [userId], 
        (err, result) => {
            if(err)
                res.status(500).send({message:"server error"})
            else {
                result.map((item, index) => (
                    item.status === 0 ? result[index].status = 'Pending' : result[index].status = 'Accepted',
                    item.method === 0 ? result[index].method = 'Deliver' : result[index].method = 'Booking'
                ))
                res.status(200).send({orders: result})
            }
        }
    )
}

const updateOrderOBStatus = (req, res) => {

    const tableId = req.query.tableId
    const status = req.body.status
    const role = req.payload.role
    if(role === 'admin'){
        db.execute(`update orders set status=? where tableId=?`,[status, tableId],
            (err, result) => {
                if(err){
                    console.log(err);
                }
                else{
                    res.status(201).send({message:"Order Updated successfully"})
                }
            }
        )
    }
    else{
        res.status(401).send({message:"Unauthorized"})
    }
}

module.exports = {
    addOrder,
    addOrderItem,
    getOrders,
    updateOrderOBStatus
}