
const db = require('../config/db');

const addBook = (req, res, next) => {

    const {tableId, userId, firstName, lastName, mobile, email, datetime} = req.body
    db.execute(`insert into booking 
            (tableID, userId, firstName, lastName, mobile, email, datetime) 
            values (? ,?, ?, ?, ?, ?, ?)`, [tableId, userId, firstName, lastName, mobile, email, datetime.split('.')[0]],
        (err, result)=>{
            if(err){
                console.log(err)
            }
            else{
                res.status(201).send({"message":"Book added successfully", bookingId:result.insertId})
            }
        }
    )
}

const addBookItem = (req, res, next) => {

    const item = req.body.item
    const bookingId = req.query.id
    db.execute(`insert into booking_item (bookingId, itemId, price, quantity) values(?, ?, ?, ?)`,
        [bookingId, item.id, item.price, item.quantity ], 
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
                    item.status === 0 ? result[index].status = 'Pending' : result[index].status = 'Accepted'
                ))
                res.status(200).send({booking: result})
            }
        }
    )
}

getAllBooking = (req, res, next) => {

    db.execute(`select booking.id, booking.tableId, table_top.code as tableCode, booking.userId, booking.status, booking.firstName, booking.lastName, booking.mobile, booking.email, booking.datetime, users.photo
                from (
                    (booking inner join table_top on booking.tableId=table_top.id)
                    inner join users on booking.userId=users.id)`,
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

getBookingDetails = (req, res) => {

    const bookingId = req.query.bookingId
    // const role = req.payload.role
    const role ='admin'
    if(role === 'admin'){
        db.execute(`select bi.id , bi.quantity as bookingItemQuantity, bi.price ,
                bi.status, i.id as itemId, i.title as itemTitle, i.cooking, 
                i.quantity as itemQuantity, i.image 
                from booking_item bi inner join item i on bi.itemId=i.id
                where bi.bookingId = ? `, [bookingId],
            (err, result) =>{
                if(err){
                    console.log(err);
                }
                else{
                    res.status(200).send({bookingDetails:result})
                }
            }
        )
    }
    else{
        res.status(401).send({message:"Unauthorized"})
    }
    
}

const updateBookStatus = (req, res) => {

    const id = req.query.id
    const status = req.body.status
    const role = req.payload.role
    if(role === 'admin'){
        db.execute('update booking set status=? where id=?',[status, id],
            (err, result) => {
                if(err){
                    console.log(err);
                }
                else{
                    res.status(201).send({message:"Booking Updated successfully"})
                }
            }
        )
    }
    else{
        res.status(401).send({message:"Unauthorized"})
    }
}

module.exports = {
    addBook,
    addBookItem,
    getBooking,
    getAllBooking,
    getBookingDetails,
    updateBookStatus
}