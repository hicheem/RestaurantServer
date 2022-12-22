
const db = require('../config/db');


const getTable = (req, res, next) => {


    const capacity = req.query.capacity
    console.log(capacity)
    db.execute('select * from table_top where status = 0 and capacity=?',[capacity], 
    (err, result) => {
        console.log(result)
        if(result.length !== 0){
            db.execute(`update table_top set status=1 where id=${result[0].id}`)
            res.status(200).send({'table': result[0]})
        }
        else
            res.status(200).send({'message': `il ya pas des table vides de capacity=${capacity}`})
    }
    )
}

const modifyStatusTable = (req, res, next) => {
    
    const tableId = req.body.tableId;
    const status = req.body.status;
    console.log(tableId, status);
    db.execute('update table_top set status=? where id=?', [status, tableId], 
    (err, result) => {
        if(err){
            console.log(err);
            res.status(500).send({"message":"DB erroe"})
        }
        else{
            console.log("tableId = ",tableId," updated succesufully");
            res.status(201).send({"message":`tableId = ${tableId} updated suuccesfully`})
        }
    }
    )
}

module.exports = {
    getTable,
    modifyStatusTable
}