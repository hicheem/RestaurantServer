
const db = require('../config/db');


const getMenus = (req, res, next) => {
    console.log("me");
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
                    (err, result2) => {
                        if(!err) {
                            res.status(200).send({'menus': result2, 'items': result})
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


module.exports = {
    getMenus
}