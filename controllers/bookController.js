
const db = require('../config/db');

const addBook = (req, res, next) => {

    const {userId, firstName, lastName, mobile, email, tableId} = req.body
    console.log({userId, firstName, lastName, mobile, email, tableId});
    db.execute(`insert into booking 
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
const getBooking = (req, res, next) => {

    const userId = req.query.userId

    db.execute(`select booking.id as bookingID, users.firstName, table_top.code as tableCode, table_top.capacity, 
                count(booking_item.id) as totalItems, sum(booking_item.price) as total, booking.status
                from (
                    ((booking inner join users on booking.userId=users.id)
                    inner join table_top on booking.tableId=table_top.id) 
                    inner join booking_item on booking.id=booking_item.bookingId ) 
                    where booking.userId=(?) group by booking_item.bookingId`, [userId], 
        (err, result) => {
            if(err)
                res.status(500).send({message:"server error"})
            else {
                result.map((item, index) => (
                    item.status === 1 ? result[index].status = 'Reserved' : result[index].status = 'Accepted'
                ))
                res.status(200).send({booking: result})
            }
        }
    )
}

module.exports = {
    addBook,
    addBookItem,
    getBooking
}