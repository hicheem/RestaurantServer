
const db = require('../config/db');

const addBook = (req, res, next) => {

    const {userId, firstName, lastName, mobile, email, tableId} = req.body
    console.log({userId, firstName, lastName, mobile, email, tableId});
    db.execute(`insert into booking_table 
            (tableID, userId, status, firstName, lastName, mobile, email) 
            values (? ,?, ?, ?, ?, ?, ?)`, [tableId, userId, 1, firstName, lastName, mobile, email],
        (err, result)=>{
            if(err){
                console.log(err)
            }
            else{
                console.log(result.insertId)
                res.status(201).send({"message":"Book added successfully", bookingId:result.insertId})
            }
        }
    )
}

const addBookItem = (req, res, next) => {

    const {bookingId, item} = req.body
    db.execute(`insert into booking_item (bookingId, itemId, price, quantity) values(?, ?, ?, ?)`,
        [bookingId, item.id, item.price * item.quantity, item.quantity ], 
        (err, result) => {
            if(err)
                console.log(err)
            else {
                res.status(201).send({"message":`Item Book added successfully , id=${item.id}`})
            }
        }
    )

}

module.exports = {
    addBook,
    addBookItem
}