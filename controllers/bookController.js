
const db = require('../config/db');

const addBook = (req, res, next) => {

    const {tableId, userId, firstName, lastName, mobile, email, datetime} = req.body
    console.log({userId, firstName, lastName, mobile, email, tableId, datetime});
    db.execute(`insert into booking 
            (tableID, userId, firstName, lastName, mobile, email, datetime) 
            values (? ,?, ?, ?, ?, ?, ?)`, [tableId, userId, firstName, lastName, mobile, email, datetime.split('.')[0]],
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

    const item = req.body.item
    const bookingId = req.query.id
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

getAllBooking = (req, res, next) => {

    db.execute('select id, tableId, status, lastName, email, datetime from booking',
        (err, result) => {
            if(err) {
                console.log(err);
            }
            else{
                res.status(200).send({booking:result})
            }
        }
    )
}

getBookingInfo = (req, res) => {

    const bookId = req.query.bookId

    
}

module.exports = {
    addBook,
    addBookItem,
    getBooking,
    getAllBooking
}