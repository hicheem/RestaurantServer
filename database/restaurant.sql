-- Listage de la structure de table restaurant. users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(50) DEFAULT NULL,
  `lastName` varchar(50) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `password` varchar(50) NOT NULL,
  `role` char(30) NOT NULL DEFAULT 'customer',
  `photo` varchar(1000) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_mobile` (`mobile`),
  UNIQUE KEY `uq_email` (`email`)
);

-- Listage des données de la table restaurant.users : ~5 rows (environ)
INSERT INTO `users` (`id`, `firstName`, `lastName`, `mobile`, `email`, `password`, `role`, `photo`, `city`) VALUES
	(1, 'Admin', 'Admin', '001', 'admin@email.com', 'admin', 'admin', NULL, NULL),
	(2, 'Hichem', 'FARAOUN', '558510412', 'hichem@email.com', 'hichem', 'customer', NULL, 'Oran'),
	(3, 'Chef1', 'Doe', '003', 'chef1@email.com', 'chef', 'chef', NULL, NULL),
	(5, 'Chef2', 'Doe', '004', 'chef2@email.com', 'chef', 'chef', NULL, NULL),
	(6, 'Agent', 'Doe', '005', 'agent@email.com', 'agent', 'agent', NULL, NULL);

-- Listage de la structure de table restaurant. table_top
CREATE TABLE IF NOT EXISTS `table_top` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '0' COMMENT 'free, reserved, active',
  `capacity` smallint(6) NOT NULL DEFAULT '0',
  `content` text,
  PRIMARY KEY (`id`)
);

-- Listage des données de la table restaurant.table_top : ~9 rows (environ)
INSERT INTO `table_top` (`id`, `code`, `status`, `capacity`, `content`) VALUES
	(1, '0', 0, 0, NULL),
	(2, '1', 0, 4, NULL),
	(3, '2', 1, 3, NULL),
	(4, '3', 1, 2, NULL),
	(5, '4', 0, 4, NULL),
	(6, '5', 0, 4, NULL),
	(7, '6', 0, 2, NULL),
	(8, '7', 0, 4, NULL),
	(9, '008', 1, 1, NULL),
	(10, '9', 0, 1, NULL),
	(11, '10', 0, 1, NULL);

-- Listage de la structure de table restaurant. menu
CREATE TABLE IF NOT EXISTS `menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) NOT NULL,
  `title` varchar(75) NOT NULL,
  `summary` tinytext,
  `type` smallint(6) NOT NULL DEFAULT '0',
  `content` text,
  PRIMARY KEY (`id`),
  KEY `idx_menu_user` (`userId`),
  CONSTRAINT `fk_menu_user` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE NO ACTION
);

-- Listage des données de la table restaurant.menu : ~10 rows (environ)
INSERT INTO `menu` (`id`, `userId`, `title`, `summary`, `type`, `content`) VALUES
	(1, 1, 'Burger', 'Fast food menu', 0, 'Burger Content'),
	(2, 1, 'Pizza', 'Fast Food', 0, NULL),
	(3, 1, 'Salad', 'Salad', 1, NULL),
	(4, 1, 'Drink', NULL, 2, NULL),
	(5, 1, 'Dessert', NULL, 3, NULL),
	(6, 1, 'Cofee', NULL, 3, NULL),
	(7, 1, 'Sandwich', NULL, 0, NULL),
	(8, 1, 'Starters', NULL, 4, NULL),
	(9, 1, 'Frice', NULL, 0, NULL),
	(10, 1, 'Tacos', NULL, 0, NULL);

-- Listage de la structure de table restaurant. item
CREATE TABLE IF NOT EXISTS `item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) NOT NULL,
  `title` varchar(75) NOT NULL,
  `summary` tinytext,
  `type` smallint(6) NOT NULL DEFAULT '0',
  `cooking` tinyint(1) NOT NULL DEFAULT '0',
  `price` float NOT NULL DEFAULT '0',
  `quantity` float NOT NULL DEFAULT '0',
  `recipe` text,
  `instructions` text,
  `content` text,
  `image` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_item_user` (`userId`),
  CONSTRAINT `fk_item_user` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE NO ACTION
);

-- Listage des données de la table restaurant.item : ~54 rows (environ)
INSERT INTO `item` (`id`, `userId`, `title`, `summary`, `type`, `cooking`, `price`, `quantity`, `recipe`, `instructions`, `content`, `image`) VALUES
	(1, 1, 'Classic Burger', NULL, 0, 1, 350, 10, '100 gr de steak haché, salade, tomate, Fromage', NULL, NULL, 'https://mymarios.com/pystedod/2020/04/Classic-Burger-MARIOSBurgers-MJ6280-25.7.2020-online.png'),
	(2, 1, 'Double Burger', NULL, 0, 1, 540, 10, '200 gr de steak haché, salade, tomate, Fromage\r\n', NULL, NULL, 'https://mymarios.com/pystedod/2020/04/Double-Burger-MARIOSBurgers-MJ6307-26.7.2020-online-510x340.png'),
	(3, 1, 'Algerian Burger', NULL, 0, 1, 270, 10, 'Salade, tomate, mayo snack, sauce algérienne, gruyère, 80g de viande ou 100g de poulet haché', NULL, NULL, 'https://mymarios.com/pystedod/2020/04/Classic-Burger-MARIOSBurgers-MJ6280-25.7.2020-online-510x340.png'),
	(4, 1, 'Biggy Burger', NULL, 0, 1, 270, 10, 'Salade, tomate, mayosnack, suce biggy, gruyère, 80g de viande hachée ou 100g de poulet haché', NULL, NULL, 'https://food.rapidos.sn/wp-content/uploads/2021/03/biggy-burger.jpg'),
	(5, 1, 'Pitta Burger', NULL, 0, 1, 260, 10, 'Salade, tomate, mayo snack, sauce pitta kebab, gruyère, 80g de viande hachée ou 100g de poulet haché', NULL, NULL, 'https://www.perdue.com/recipeimages/54277_pita_burgers.jpg'),
	(6, 1, 'Samorai Burger', NULL, 0, 1, 270, 10, 'Salade tomate, mayo snack, sauce samoraï, gruyère, 80g de viande hachée ou100g de poulet haché', NULL, NULL, 'https://static.mothership.sg/1/2021/09/Samurai-Chicken.png'),
	(7, 1, 'Sandwich poulet', NULL, 1, 1, 405, 10, 'Fromage blanc, salade, tomate, sauce fromagère, 200g blanc de poulet hachée', NULL, 'Poulet', 'https://images.anaca3.com/wp-content/uploads/2018/01/recette-sandwich-minceur-poulet-crudites-et-sauce-blanche-maison-702x336.jpg'),
	(8, 1, 'Sandwich viande hachée', NULL, 1, 1, 495, 10, 'Fromage blanc, salade, tomate, sauce fromagère, 160g de viande hachée', NULL, NULL, 'https://www.shutterstock.com/shutterstock/photos/2024853884/display_1500/stock-photo-beef-fajita-sandwich-with-pepper-lettuce-and-cheese-2024853884.jpg'),
	(9, 1, 'Sandwich mixte', NULL, 1, 1, 450, 10, 'Fromage blanc, salade, tomate, sauce fromagère, 100g blanc de poulet haché, 80g de viande hachée', NULL, 'Poulet/viande', 'https://www.betweenfriendscafe.com/wp-content/uploads/2020/06/sandwich-mixte.jpg'),
	(10, 1, 'Hot Dog', NULL, 2, 1, 300, 10, 'Pain moelleux, saucisse fumée Halal, oignons grillés, cornichons et sauce fromagère.', NULL, NULL, 'https://mccormick.widen.net/content/pf77axj6bx/original/classic_grilled_hot_dog_800x800.jpg'),
	(11, 1, 'Crispy Mozzarella', NULL, 2, 1, 350, 10, 'Bâtonnets de mozzarella panées avec leur sauce BBQ', NULL, NULL, 'https://www.thecookierookie.com/wp-content/uploads/2019/05/baked-mozzarella-sticks-cheese-3-of-4-500x500.jpg'),
	(12, 1, 'Empanada', NULL, 2, 1, 250, 10, 'Véritable Empanada mexicaine au poulet/viande, fromage, oignons, poivrons et épices sud-américaines.', NULL, NULL, 'https://comfortablefood.com/wp-content/uploads/2022/06/empanadas-3.jpg'),
	(13, 1, 'El Paso', NULL, 0, 1, 650, 10, '140gr de steak haché, tranche de dinde fumée, salade, tomate, gouda, oignons caramélisés, sauce orientale piquante.', NULL, NULL, 'https://media-cdn.tripadvisor.com/media/photo-s/0e/bb/85/6d/roadside-el-paso-mexican.jpg'),
	(14, 1, 'Miami', NULL, 0, 1, 500, 10, '100gr de steak haché, saucisse pure B?uf, salade, tomate, fromage, sauce BBQ', NULL, NULL, 'https://img.restaurantguru.com/r49b-Miami-Burger-burger-2021-08-1.jpg'),
	(15, 1, 'Frites simples', NULL, 4, 1, 200, 10, NULL, NULL, NULL, 'https://www.papillesetpupilles.fr/wp-content/uploads/2013/10/Frites-%C2%A9De-PosiNote-shutterstock.jpg'),
	(16, 1, 'Frites sauce fromagère', NULL, 4, 1, 300, 10, NULL, NULL, NULL, 'https://www.festihome.com/img/cms/images-recettes/frites-cheddar/frites-sauce-cheddar.jpg'),
	(17, 1, 'Tacos Normale', NULL, 5, 1, 450, 10, '1 viande au choix, salade, tomate, oignon, sauce au choix.', NULL, NULL, 'https://www.kebabdelagare78.fr/produit/1548_179.png'),
	(18, 1, 'Tacos 2 Viandes', NULL, 5, 1, 500, 10, '2 viandes au choix, salde, tomates, oignon, fromagère.', NULL, NULL, 'https://www.kebabdelagare78.fr/produit/1548_179.png'),
	(19, 1, 'Tacos Gogeta', NULL, 5, 1, 550, 10, 'Tacos maxi format, deux galettes, 2 viandes au choix, salade, tomates, oignon et sauce fromagère.', NULL, NULL, 'https://www.kebabdelagare78.fr/produit/1548_179.png'),
	(20, 1, 'Salade Chicken', NULL, 6, 1, 300, 10, NULL, NULL, NULL, 'https://img.cuisineaz.com/1024x768/2022/07/18/i184733-shutterstock-95710738.jpeg'),
	(21, 1, 'Salade Thon', NULL, 6, 1, 310, 10, NULL, NULL, NULL, 'https://www.kilometre-0.fr/wp-content/uploads/2019/06/20190629Cuisine_mart677.jpg'),
	(22, 1, 'Salade Mozzarella', NULL, 6, 1, 310, 10, NULL, NULL, NULL, 'https://cdn.goody.buzz/media/20190606205653/62209872_498955667310504_3806000340390641664_n.jpg'),
	(23, 1, 'Tiramisu', NULL, 7, 1, 200, 10, 'Délicieuses verrines de Tiramisu, Cheesecake, Mousse au chocolat', NULL, NULL, 'https://api.swissmilk.ch/wp-content/uploads/2019/06/tiramisu-scaled.jpg'),
	(24, 1, 'Cheese burger', NULL, 0, 1, 260, 10, '1 Steak, oignon, cheddar, cornichons, ketchup, moutard', NULL, NULL, 'https://mymarios.com/pystedod/2020/04/Cheese-Burger-MARIOSBurgers-MJ6337-edited-25.7.2020-online-large.png'),
	(25, 1, 'Mousse au chocolat', NULL, 7, 1, 250, 10, NULL, NULL, NULL, 'https://static.750g.com/images/1200-630/f1904fd901c5077056f719c51906be87/thinkstockphotos-623897390.jpg'),
	(26, 1, 'Fondant au chocolat', NULL, 7, 1, 300, 10, NULL, NULL, NULL, 'https://empreintesucree.fr/wp-content/uploads/2018/02/1-fondant-chocolat-recette-patisserie-empreinte-sucree-1.jpg'),
	(27, 1, 'Cappuccino', NULL, 8, 1, 200, 10, NULL, NULL, NULL, 'https://assets.afcdn.com/recipe/20160919/20976_w1024h1024c1cx2624cy1749.jpg'),
	(28, 1, 'Espresso', NULL, 8, 1, 180, 10, NULL, NULL, NULL, 'https://elfuego.uk/wp-content/uploads/2019/11/Double-Espresso.jpg'),
	(29, 1, 'Café Crème', NULL, 8, 1, 200, 10, NULL, NULL, NULL, 'https://assets.afcdn.com/recipe/20180828/82018_w1024h1024c1cx2808cy1872.webp'),
	(30, 1, 'Thé', NULL, 8, 1, 150, 10, NULL, NULL, NULL, 'https://ileauxepices.com/blog/wp-content/uploads/2018/01/th%C3%A9-%C3%A0-la-cannelle.jpg'),
	(31, 1, 'Lait au chcolat', NULL, 8, 1, 200, 10, NULL, NULL, NULL, 'https://odelices.ouest-france.fr/images/recettes/chocolat_chaud_a_la_francaise-970x1024.jpg'),
	(32, 1, 'Very Veggie', NULL, 9, 1, 740, 10, 'Sauce tomate, champignons, poivrons, tomate fraiche, oignons, olives noires et mozzarella', NULL, NULL, 'https://www.twopeasandtheirpod.com/wp-content/uploads/2021/03/Veggie-Pizza-8-500x375.jpg'),
	(33, 1, 'Chicken BBQ', NULL, 9, 1, 900, 10, 'Sauce tomate, spirale sauce barbecue, poulet et mozzarella', NULL, NULL, 'https://cdn.apartmenttherapy.info/image/upload/f_jpg,q_auto:eco,c_fill,g_auto,w_1500,ar_1:1/k%2Farchive%2Fbd84ba2c08f32a70c1c3638c511dd271d365c611'),
	(34, 1, 'Margherita', NULL, 9, 1, 900, 10, 'Sauce tomate, basilic et double mozzarella', NULL, NULL, 'https://img.passeportsante.net/1200x675/2022-09-23/shutterstock-2105210927.webp'),
	(35, 1, 'Cheeky chicken', NULL, 9, 1, 1000, 10, 'Sauce tomate, poulet, poivrons, oignons, tomates fraiches et mozzarella', NULL, NULL, 'https://cheekychicken.co.nz/wp-content/uploads/2020/04/Cheeky-Chicken-Pizza-copy.jpg'),
	(36, 1, 'Hot stuff chicken', NULL, 9, 1, 1000, 10, 'Sauce tomate piquante, poulet, oignons, tomates fraiches et mozzarella', NULL, NULL, 'https://pngimg.com/uploads/pizza/pizza_PNG44092.png'),
	(37, 1, 'Hot stuff beef', NULL, 9, 1, 1000, 10, 'Sauce tomate piquante, viande hachée, oignons, tomates fraiches et mozarella', NULL, NULL, 'http://embed.widencdn.net/img/beef/gxsxp5i3do/exact/spicy-nacho-beef-pizza-square.eps?keep=c&u=7fueml'),
	(38, 1, 'Tropical hawaian', NULL, 9, 1, 1000, 10, 'Sauce tomate, poulet, ananas et mozarella', NULL, NULL, 'https://img.kidspot.com.au/Kp4xCs5h/w1200-h630-cfill/kk/2015/03/hawaiian-pizza-recipe-605894-2.jpg'),
	(39, 1, 'Chicken tandoori', NULL, 9, 1, 1000, 10, 'Sauce tomate, poulet, oignons, épices tandoori et mozzarella', NULL, NULL, 'https://img.taste.com.au/pkbTXdWH/taste/2016/11/tandoori-chicken-pizza-60718-1.jpeg'),
	(41, 1, 'Classic pepperoni', NULL, 9, 1, 1100, 10, 'Sauce tomate, double pepperoni et double mozzarella', NULL, NULL, 'https://www.cooksifu.com/wp-content/uploads/2019/03/Pepperoni-pizza-1300x866.jpg'),
	(42, 1, 'Chicken mushroom', NULL, 9, 1, 1100, 10, 'Sauce tomate, poulet, champignons et mozzarella', NULL, NULL, 'https://www.roundaboutpizza.com.au/wp-content/uploads/2019/10/Roundabout-Chicken-Mushroom.jpg'),
	(43, 1, 'Super supreme', NULL, 9, 1, 1100, 10, 'Sauce tomate, pepproni, viande hachée, champignons, poivrons, oignons, olives noires et mozzarella', NULL, NULL, 'https://www.thepizzalads.com/wp-content/uploads/2017/08/Super-Supreme-Pizza-Hut-Pizza-Review.jpg'),
	(44, 1, 'Chicken supreme', NULL, 9, 1, 1100, 10, 'Sauce tomate, poulet, champignons, poivrons, oignons, olives noires et mozzarella', NULL, NULL, 'https://www.awesomecuisine.com/wp-content/uploads/2015/11/chicken-supreme-pizza-500x500.jpg'),
	(45, 1, 'Sauce blanche poulet', NULL, 9, 1, 1100, 10, 'Crème, poulet, champignons, oignons et mozzarella', NULL, NULL, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWGUWVVvzhvhH4paLPz6b8SyL5gMDip5STYw&usqp=CAU'),
	(46, 1, 'Sauce blanche fermière', NULL, 9, 1, 1100, 10, 'Crème, gouda, camembert et mozzarella', NULL, NULL, 'https://static.weezbe.com/saveurserable/Images/products/p_494G_211112113428.jpg'),
	(47, 1, 'Beef BBQ', NULL, 9, 1, 1100, 10, 'Sauce barbecue, boulettes de viandes, oignons, basilic et mozzarella', NULL, NULL, 'https://foodrecipeshome.com/wp-content/uploads/2021/10/10-BBQ-beef-pizza-2.jpg'),
	(48, 1, '3 Trois fromages', NULL, 9, 1, 1200, 10, 'Sauce tomate, camembert, emmental et mozzarella', NULL, NULL, 'https://img.cuisineaz.com/660x660/2019/08/29/i150038-pizza-trois-fromages.jpeg'),
	(49, 1, 'Thé infusion', NULL, 8, 1, 150, 10, NULL, NULL, NULL, 'https://restaurant-larenaissance.com/wp-content/uploads/2019/03/the.jpg'),
	(55, 1, 'Coca cola 1L', NULL, 3, 0, 200, 10, NULL, NULL, NULL, 'https://www.checkers.co.za/medias/10139271EA-checkers515Wx515H?context=bWFzdGVyfGltYWdlc3wxMTE3NDh8aW1hZ2UvcG5nfGltYWdlcy9oZjIvaDE5Lzk5MTQ1MzEzMTU3NDIucG5nfDlkZjY4OGFkNTdhZWU2MDZhNmQ1NmJjZGEyYjUzN2IwNjA3YWZjNzE5ZmM0MWQ5OGY2MDE2YmM4ZTYzZjA4OGU'),
	(56, 1, 'Sprite 1L', NULL, 3, 0, 200, 10, NULL, NULL, NULL, 'https://m.media-amazon.com/images/I/61Q5DKqI5QL.jpg'),
	(57, 1, 'Fanta 1L', NULL, 3, 0, 200, 10, NULL, NULL, NULL, 'https://championgourmet.ma/wp-content/uploads/2021/08/LIM_3013-Fanta-Orange-1L.jpg'),
	(58, 1, 'Canette Coca cola 33 CL', NULL, 3, 0, 150, 10, NULL, NULL, NULL, 'https://topribejaia.com/wp-content/uploads/2021/07/Coca-Cola-Canette-33-CL.jpg'),
	(59, 1, 'Eau minérale 1.5L', NULL, 3, 0, 100, 10, NULL, NULL, NULL, 'http://www.cevital-agro-industrie.com/application/docs/media/1/original/1-LLK-Plate-FR-Gamme-min-1585.png'),
	(60, 1, 'Eau pétillante', NULL, 3, 0, 100, 10, NULL, NULL, NULL, 'https://palma-market.com/wp-content/uploads/2022/03/Eau-Gazeuze-Vichi-1L-Ifri.jpg'),
	(61, 1, 'new_item2', NULL, 0, 1, 100, 0, 'recipe', NULL, NULL, NULL);

-- Listage de la structure de table restaurant. ingredient
CREATE TABLE IF NOT EXISTS `ingredient` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) NOT NULL,
  `title` varchar(75) NOT NULL,
  `summary` tinytext,
  `type` smallint(6) NOT NULL DEFAULT '0',
  `quantity` float NOT NULL DEFAULT '0',
  `content` text,
  PRIMARY KEY (`id`),
  KEY `idx_ingredient_user` (`userId`),
  CONSTRAINT `fk_ingredient_user` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON UPDATE NO ACTION
);

-- Listage de la structure de table restaurant. item_chef
CREATE TABLE IF NOT EXISTS `item_chef` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `itemId` bigint(20) NOT NULL,
  `chefId` bigint(20) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_item_chef` (`itemId`,`chefId`),
  KEY `idx_item_chef_item` (`itemId`),
  KEY `idx_item_chef_chef` (`chefId`),
  CONSTRAINT `fk_item_chef_chef` FOREIGN KEY (`chefId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_chef_item` FOREIGN KEY (`itemId`) REFERENCES `item` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
);

-- Listage de la structure de table restaurant. menu_item
CREATE TABLE IF NOT EXISTS `menu_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `menuId` bigint(20) NOT NULL,
  `itemId` bigint(20) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_menu_item` (`menuId`,`itemId`),
  KEY `idx_menu_item_menu` (`menuId`),
  KEY `idx_menu_item_item` (`itemId`),
  CONSTRAINT `fk_menu_item_item` FOREIGN KEY (`itemId`) REFERENCES `item` (`id`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_item_menu` FOREIGN KEY (`menuId`) REFERENCES `menu` (`id`) ON UPDATE NO ACTION
);

-- Listage des données de la table restaurant.menu_item : ~55 rows (environ)
INSERT INTO `menu_item` (`id`, `menuId`, `itemId`, `active`) VALUES
	(1, 1, 1, 1),
	(2, 1, 2, 1),
	(3, 1, 3, 1),
	(4, 1, 4, 1),
	(5, 1, 5, 1),
	(6, 1, 6, 1),
	(7, 7, 7, 1),
	(8, 7, 8, 1),
	(9, 7, 9, 1),
	(10, 1, 13, 1),
	(11, 1, 14, 1),
	(12, 8, 10, 1),
	(13, 8, 11, 1),
	(14, 8, 12, 1),
	(15, 9, 15, 1),
	(16, 9, 16, 1),
	(17, 10, 17, 1),
	(18, 10, 18, 1),
	(19, 10, 19, 1),
	(20, 3, 20, 1),
	(21, 3, 21, 1),
	(22, 3, 22, 1),
	(23, 5, 23, 1),
	(24, 5, 25, 1),
	(25, 5, 26, 1),
	(26, 1, 24, 1),
	(27, 6, 27, 1),
	(28, 6, 28, 1),
	(29, 6, 29, 1),
	(30, 6, 30, 1),
	(31, 6, 31, 1),
	(32, 6, 49, 1),
	(33, 2, 32, 1),
	(36, 2, 33, 1),
	(37, 2, 34, 1),
	(38, 2, 35, 1),
	(39, 2, 36, 1),
	(40, 2, 37, 1),
	(41, 2, 38, 1),
	(42, 2, 39, 1),
	(44, 2, 41, 1),
	(45, 2, 42, 1),
	(46, 2, 43, 1),
	(47, 2, 44, 1),
	(48, 2, 45, 1),
	(49, 2, 46, 1),
	(50, 2, 47, 1),
	(51, 2, 48, 1),
	(52, 4, 55, 1),
	(53, 4, 56, 1),
	(54, 4, 57, 1),
	(55, 4, 58, 1),
	(56, 4, 59, 1),
	(57, 4, 60, 1),
	(58, 3, 61, 1);

-- Listage de la structure de table restaurant. booking
CREATE TABLE IF NOT EXISTS `booking` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tableId` bigint(20) NOT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT '0',
  `firstName` varchar(50) DEFAULT NULL,
  `lastName` varchar(50) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `datetime` datetime NOT NULL,
  `content` text,
  PRIMARY KEY (`id`),
  KEY `idx_booking_table` (`tableId`),
  KEY `idx_booking_user` (`userId`),
  CONSTRAINT `fk_booking_table` FOREIGN KEY (`tableId`) REFERENCES `table_top` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_booking_user` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
);

-- Listage des données de la table restaurant.booking : ~1 rows (environ)
INSERT INTO `booking` (`id`, `tableId`, `userId`, `status`, `firstName`, `lastName`, `mobile`, `email`, `datetime`, `content`) VALUES
	(51, 8, 2, 1, 'Hichem', 'FARAOUN', '558510412', 'hichem@email.com', '2023-01-31 03:25:01', NULL);

-- Listage de la structure de table restaurant. booking_item
CREATE TABLE IF NOT EXISTS `booking_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bookingId` bigint(20) NOT NULL,
  `itemId` bigint(20) NOT NULL,
  `price` float NOT NULL DEFAULT '0',
  `quantity` float NOT NULL DEFAULT '0',
  `status` smallint(6) NOT NULL DEFAULT '0',
  `content` text,
  PRIMARY KEY (`id`),
  KEY `idx_booking_item_booking` (`bookingId`),
  KEY `idx_booking_item_item` (`itemId`),
  CONSTRAINT `fk_booking_item_booking` FOREIGN KEY (`bookingId`) REFERENCES `booking` (`id`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_booking_item_item` FOREIGN KEY (`itemId`) REFERENCES `item` (`id`) ON UPDATE NO ACTION
);

-- Listage des données de la table restaurant.booking_item : ~1 rows (environ)
INSERT INTO `booking_item` (`id`, `bookingId`, `itemId`, `price`, `quantity`, `status`, `content`) VALUES
	(110, 51, 2, 2160, 4, 0, NULL);

-- Listage de la structure de table restaurant. orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userId` bigint(20) DEFAULT NULL,
  `tableId` bigint(20) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT '0',
  `shipping` float NOT NULL DEFAULT '0',
  `total` float NOT NULL DEFAULT '0',
  `firstName` varchar(50) DEFAULT NULL,
  `lastName` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `content` text,
  `mobile` varchar(20) DEFAULT NULL,
  `payment` smallint(6) NOT NULL,
  `method` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_order_user` (`userId`),
  KEY `fk_table_top_tableId` (`tableId`),
  CONSTRAINT `fk_order_user` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_table_top_tableId` FOREIGN KEY (`tableId`) REFERENCES `table_top` (`id`) ON UPDATE NO ACTION
);

-- Listage des données de la table restaurant.orders : ~1 rows (environ)
INSERT INTO `orders` (`id`, `userId`, `tableId`, `status`, `shipping`, `total`, `firstName`, `lastName`, `email`, `content`, `mobile`, `payment`, `method`) VALUES
	(29, 2, 8, 1, 0, 2160, 'Hichem', 'FARAOUN', 'hichem@email.com', NULL, '558510412', 0, 1);

-- Listage de la structure de table restaurant. order_item
CREATE TABLE IF NOT EXISTS `order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `orderId` bigint(20) NOT NULL,
  `itemId` bigint(20) NOT NULL,
  `price` float NOT NULL DEFAULT '0',
  `quantity` float NOT NULL DEFAULT '0',
  `content` text,
  PRIMARY KEY (`id`),
  KEY `idx_order_item_order` (`orderId`),
  KEY `idx_order_item_item` (`itemId`),
  CONSTRAINT `fk_order_item_item` FOREIGN KEY (`itemId`) REFERENCES `item` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_item_order` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Listage des données de la table restaurant.order_item : ~1 rows (environ)
INSERT INTO `order_item` (`id`, `orderId`, `itemId`, `price`, `quantity`, `content`) VALUES
	(72, 29, 2, 2160, 4, NULL);

-- Listage de la structure de table restaurant. recipe
CREATE TABLE IF NOT EXISTS `recipe` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `itemId` bigint(20) NOT NULL,
  `ingredientId` bigint(20) NOT NULL,
  `quantity` float NOT NULL DEFAULT '0',
  `instructions` text,
  PRIMARY KEY (`id`),
  KEY `idx_recipe_item` (`itemId`),
  KEY `idx_recipe_ingredient` (`ingredientId`),
  CONSTRAINT `fk_recipe_ingredient` FOREIGN KEY (`ingredientId`) REFERENCES `ingredient` (`id`) ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipe_item` FOREIGN KEY (`itemId`) REFERENCES `item` (`id`) ON UPDATE NO ACTION
);