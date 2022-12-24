
const db = require('../config/db');



const getMenus = (req, res, next) => {

    db.execute('select * from menu',
        (err, result) => {
            if(err){
                console.log(err)
            }
            else{
                res.status(200).send({menu:result})
            }
        }
    )
}


const getMenusWithItem = (req, res, next) => {
    db.execute(`select item.id as item_id, item.title as item_title, 
                item.price, item.quantity, item.recipe, item.image, 
                menu.id as menu_id, menu.title as menu_title from 
                (
                    (item inner join menu_item on item.id=menu_item.itemId) 
                    inner join menu on menu.id=menu_item.menuId
                )`,
        (err, result) => {
            if(!err){
                db.execute(`select id, title from menu`, 
                    (err, result_menu) => {
                        if(!err) {
                            res.status(200).send({'menus': result_menu, 'items': result})
                        }
                        else{
                            console.log('menu query erreur')
                            res.status(500)
                        }
                    }
                )
            }
            else {
                console.log('Item query erreur')
                res.status(500)
            }
        }
    )
}

const updateMenu = (req, res, next) => {

    const id = req.query.id
    const data = req.body
    const role = req.payload.role
    if(role === 'admin'){
        db.execute(`update menu set title=?, summary=?, content=?, type=? where id=${id}`, [data.title, data.summary, data.content, data.type],
            (err, result) => {
                if(err){
                    console.log(err)
                }
                else{
                    res.status(201).send({message : 'Menu updated'})
                }
            }
        )
        }
        else{
            res.status(401).send({message:'Unthorized'})
        }
}


module.exports = {
    getMenusWithItem,
    getMenus,
    updateMenu
}