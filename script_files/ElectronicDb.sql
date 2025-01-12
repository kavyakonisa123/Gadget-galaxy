
-- Databse Creation

create database Electronicdb;
use Electronicdb;

-- Tables creation

-- Addresses table is created to store addresses
CREATE TABLE Addresses (
    address_id INT PRIMARY KEY,
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    zip_code VARCHAR(20),
    country VARCHAR(100)
);
-- created Users table to store basic info of user while creating an accoount
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(100) UNIQUE,
    password_hash VARBINARY(255),
    email VARCHAR(100) UNIQUE,
    contact_details VARCHAR(255),
    user_image VARCHAR(255),
    address_id INT,
    payment_info TEXT,
    FOREIGN KEY (address_id) REFERENCES Addresses(address_id) ON DELETE SET NULL
);
-- created Sellers table to store basic info of seller while creating an accoount
CREATE TABLE Sellers (
    seller_id INT PRIMARY KEY,
    company_name VARCHAR(100) UNIQUE,
	password_hash VARBINARY(255),
    contact_details VARCHAR(255),
    business_logo VARCHAR(255),
    seller_rating DECIMAL(2,1),
    transfer_details TEXT,
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES Addresses(address_id) ON DELETE SET NULL
);

-- created Categories table to store different categories of each product
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100),
    category_description TEXT
);

-- created Products table to store complete detail of each product added by a seller
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    seller_id INT,
    category_id INT,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2),
    quantity INT,
    product_image VARCHAR(255),
    product_rating DECIMAL(2,1),
    FOREIGN KEY (seller_id) REFERENCES Sellers(seller_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE SET NULL
);

-- created Product_Categories table to know which products are related to whih category
CREATE TABLE Product_Categories (
    product_id INT,
    category_id INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE,
    PRIMARY KEY (product_id, category_id)
);

-- created Carts table to store complete list of products added by a user
CREATE TABLE Carts (
    cart_id INT PRIMARY KEY,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- created Cart_Items table to store complete detail of each product added by a user
CREATE TABLE Cart_Items (
    cart_item_id INT PRIMARY KEY,
    cart_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cart_id) REFERENCES Carts(cart_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE SET NULL
);

-- created Orders table to store complete list of products ordered by a user
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50),
    total_price DECIMAL(10, 2),
    shipping_details TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- created Order_Items table to store complete detail of each product of a particular order
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE SET NULL
);

-- created Payments table to store payment details of a particular order
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10, 2),
    payment_method VARCHAR(50),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);

-- created Reviews table to store reviews gaven by user for a particular product
CREATE TABLE Reviews (
    review_id INT PRIMARY KEY,
    product_id INT,
    user_id INT,
    rating INT,
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- created Support_Tickets table to store tickets raised by user for a particular product
CREATE TABLE Support_Tickets (
    ticket_id INT PRIMARY KEY,
    user_id INT,
    product_id INT,
    issue_description TEXT,
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE SET NULL
);

-- created Warranties table to store warranty details of a product bought by user.
CREATE TABLE Warranties (
    warranty_id INT PRIMARY KEY,
    product_id INT,
    user_id INT,
    order_id INT,
    warranty_period INT,
    warranty_start_date DATE,
    warranty_end_date DATE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);


-- created Shopping_Lists table to store  list of products liked by a user
CREATE TABLE Shopping_Lists (
    shopping_list_id INT PRIMARY KEY,
    user_id INT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- created Shopping_List_Items table to store complete detail of each product liked by a user
CREATE TABLE Shopping_List_Items (
    list_item_id INT PRIMARY KEY,
    shopping_list_id INT,
    product_id INT,
    quantity INT,
    added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (shopping_list_id) REFERENCES Shopping_Lists(shopping_list_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE SET NULL
);

-- created User_Profiles table to store complete infornation of user 
CREATE TABLE User_Profiles (
    profile_id INT PRIMARY KEY,
    user_id INT,
    contact_details VARCHAR(255),
    order_history TEXT,
    basic_info TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- created Seller_Profiles table to store complete infornation of seller 
CREATE TABLE Seller_Profiles (
    profile_id INT PRIMARY KEY,
    seller_id INT,
    product_listings TEXT,
    inventory TEXT,
    contact_details VARCHAR(255),
    order_status TEXT,
    shipping_info TEXT,
    FOREIGN KEY (seller_id) REFERENCES Sellers(seller_id) ON DELETE CASCADE
);



-- Populating the data

INSERT INTO Addresses (address_id, address_line1, address_line2, city, state, zip_code, country) VALUES
(1, '123 Main St', 'Apt 101', 'New York', 'NY', '10001', 'USA'),
(2, '456 Maple Ave', 'Suite 2', 'Los Angeles', 'CA', '90001', 'USA'),
(3, '789 Oak St', 'Floor 3', 'Chicago', 'IL', '60601', 'USA'),
(4, '101 Pine Rd', '', 'Houston', 'TX', '77001', 'USA'),
(5, '202 Birch Blvd', 'Unit 5', 'Phoenix', 'AZ', '85001', 'USA'),
(6, '303 Cedar Ln', '', 'Philadelphia', 'PA', '19101', 'USA'),
(7, '404 Spruce St', 'Apt 12B', 'San Antonio', 'TX', '78201', 'USA'),
(8, '505 Willow Dr', '', 'San Diego', 'CA', '92101', 'USA'),
(9, '606 Ash Ave', 'Apt 34', 'Dallas', 'TX', '75201', 'USA'),
(10, '707 Elm St', '', 'San Jose', 'CA', '95101', 'USA'),
(11, '808 Poplar St', 'Unit 10', 'Austin', 'TX', '73301', 'USA'),
(12, '909 Fir St', '', 'Jacksonville', 'FL', '32099', 'USA'),
(13, '100 Redwood Blvd', 'Suite 20', 'Fort Worth', 'TX', '76101', 'USA'),
(14, '110 Palm St', '', 'Columbus', 'OH', '43085', 'USA'),
(15, '120 Cypress Ave', 'Apt 3A', 'Charlotte', 'NC', '28201', 'USA'),
(16, '130 Magnolia Rd', '', 'San Francisco', 'CA', '94101', 'USA'),
(17, '140 Juniper St', 'Unit 2C', 'Indianapolis', 'IN', '46201', 'USA'),
(18, '150 Sequoia Ave', '', 'Seattle', 'WA', '98101', 'USA'),
(19, '160 Dogwood Dr', '', 'Denver', 'CO', '80201', 'USA'),
(20, '170 Hemlock St', 'Suite 15', 'Washington', 'DC', '20001', 'USA'),
(21, '180 Chestnut St', 'Floor 4', 'Boston', 'MA', '02101', 'USA'),
(22, '190 Maple Dr', '', 'El Paso', 'TX', '79901', 'USA'),
(23, '200 Oak Ln', '', 'Detroit', 'MI', '48201', 'USA'),
(24, '210 Pine Ave', 'Unit 9', 'Nashville', 'TN', '37201', 'USA'),
(25, '220 Birch St', '', 'Memphis', 'TN', '37501', 'USA'),
(26, '230 Cedar Blvd', 'Apt 7', 'Portland', 'OR', '97201', 'USA'),
(27, '240 Spruce Ln', '', 'Oklahoma City', 'OK', '73101', 'USA'),
(28, '250 Willow St', 'Suite 3', 'Las Vegas', 'NV', '89101', 'USA'),
(29, '260 Ash Blvd', '', 'Louisville', 'KY', '40201', 'USA'),
(30, '270 Elm Rd', 'Unit 5', 'Baltimore', 'MD', '21201', 'USA');

select * from Addresses;


INSERT INTO Users (user_id, username, password_hash, email, contact_details, user_image, address_id, payment_info) VALUES
(1, 'john_doe', SHA2('password123', 256), 'john.doe@example.com', '555-0101', 'https://example.com/images/john_doe.jpg', 1, 'Visa ending in 1234'),
(2, 'jane_smith', SHA2('securePass!45', 256), 'jane.smith@example.com', '555-0202', 'https://example.com/images/jane_smith.jpg', 2, 'MasterCard ending in 5678'),
(3, 'mike_jones', SHA2('mySecretPwd', 256), 'mike.jones@example.com', '555-0303', 'https://example.com/images/mike_jones.jpg', 3, 'Amex ending in 9012'),
(4, 'susan_brown', SHA2('anotherPass789', 256), 'susan.brown@example.com', '555-0404', 'https://example.com/images/susan_brown.jpg', 4, 'Discover ending in 3456'),
(5, 'karen_davis', SHA2('yetAnotherPass', 256), 'karen.davis@example.com', '555-0505', 'https://example.com/images/karen_davis.jpg', 5, 'Visa ending in 7890'),
(6, 'james_wilson', SHA2('examplePass456', 256), 'james.wilson@example.com', '555-0606', 'https://example.com/images/james_wilson.jpg', 6, 'MasterCard ending in 1234'),
(7, 'patricia_taylor', SHA2('secure123!', 256), 'patricia.taylor@example.com', '555-0707', 'https://example.com/images/patricia_taylor.jpg', 7, 'Amex ending in 5678'),
(8, 'robert_martin', SHA2('pass123Secure', 256), 'robert.martin@example.com', '555-0808', 'https://example.com/images/robert_martin.jpg', 8, 'Discover ending in 9012'),
(9, 'linda_thomas', SHA2('mypassword789', 256), 'linda.thomas@example.com', '555-0909', 'https://example.com/images/linda_thomas.jpg', 9, 'Visa ending in 3456'),
(10, 'barbara_moore', SHA2('!SecurePass456', 256), 'barbara.moore@example.com', '555-1010', 'https://example.com/images/barbara_moore.jpg', 10, 'MasterCard ending in 7890'),
(11, 'richard_jackson', SHA2('AnotherPass!789', 256), 'richard.jackson@example.com', '555-1111', 'https://example.com/images/richard_jackson.jpg', 11, 'Amex ending in 1234'),
(12, 'mary_lee', SHA2('Passw0rd!123', 256), 'mary.lee@example.com', '555-1212', 'https://example.com/images/mary_lee.jpg', 12, 'Discover ending in 5678'),
(13, 'william_white', SHA2('S3cureP@ss', 256), 'william.white@example.com', '555-1313', 'https://example.com/images/william_white.jpg', 13, 'Visa ending in 9012'),
(14, 'joseph_harris', SHA2('AnotherS3cureP@ss', 256), 'joseph.harris@example.com', '555-1414', 'https://example.com/images/joseph_harris.jpg', 14, 'MasterCard ending in 3456'),
(15, 'sarah_clark', SHA2('SecureP@ssword123', 256), 'sarah.clark@example.com', '555-1515', 'https://example.com/images/sarah_clark.jpg', 15, 'Amex ending in 7890'),
(16, 'charles_lewis', SHA2('YetAn0therP@ss', 256), 'charles.lewis@example.com', '555-1616', 'https://example.com/images/charles_lewis.jpg', 16, 'Discover ending in 1234'),
(17, 'karen_walker', SHA2('P@ssw0rdSecure!', 256), 'karen.walker@example.com', '555-1717', 'https://example.com/images/karen_walker.jpg', 17, 'Visa ending in 5678'),
(18, 'daniel_hall', SHA2('MyS3cureP@ss123', 256), 'daniel.hall@example.com', '555-1818', 'https://example.com/images/daniel_hall.jpg', 18, 'MasterCard ending in 9012'),
(19, 'betty_allen', SHA2('Passw0rd!Secure', 256), 'betty.allen@example.com', '555-1919', 'https://example.com/images/betty_allen.jpg', 19, 'Amex ending in 3456'),
(20, 'david_young', SHA2('S3cur3Passw0rd!', 256), 'david.young@example.com', '555-2020', 'https://example.com/images/david_young.jpg', 20, 'Discover ending in 7890'),
(21, 'dorothy_hernandez', SHA2('YetAnotherS3curePass!', 256), 'dorothy.hernandez@example.com', '555-2121', 'https://example.com/images/dorothy_hernandez.jpg', 21, 'Visa ending in 1234'),
(22, 'matthew_king', SHA2('P@ssw0rd!Another', 256), 'matthew.king@example.com', '555-2222', 'https://example.com/images/matthew_king.jpg', 22, 'MasterCard ending in 5678'),
(23, 'lisa_wright', SHA2('S3cureP@ss!789', 256), 'lisa.wright@example.com', '555-2323', 'https://example.com/images/lisa_wright.jpg', 23, 'Amex ending in 9012'),
(24, 'mark_lopez', SHA2('YetAnotherP@ss789', 256), 'mark.lopez@example.com', '555-2424', 'https://example.com/images/mark_lopez.jpg', 24, 'Discover ending in 3456'),
(25, 'nancy_hill', SHA2('MyS3cureP@ss123!', 256), 'nancy.hill@example.com', '555-2525', 'https://example.com/images/nancy_hill.jpg', 25, 'Visa ending in 7890'),
(26, 'paul_scott', SHA2('AnotherSecureP@ss!', 256), 'paul.scott@example.com', '555-2626', 'https://example.com/images/paul_scott.jpg', 26, 'MasterCard ending in 1234'),
(27, 'sandra_green', SHA2('S3cur3P@ssw0rd123', 256), 'sandra.green@example.com', '555-2727', 'https://example.com/images/sandra_green.jpg', 27, 'Amex ending in 5678'),
(28, 'steven_adams', SHA2('P@ssword123Secure!', 256), 'steven.adams@example.com', '555-2828', 'https://example.com/images/steven_adams.jpg', 28, 'Discover ending in 9012'),
(29, 'george_baker', SHA2('S3cureP@ssword789', 256), 'george.baker@example.com', '555-2929', 'https://example.com/images/george_baker.jpg', 29, 'Visa ending in 1234'),
(30, 'jessica_bell', SHA2('YetAnotherSecureP@ss123', 256), 'jessica.bell@example.com', '555-3030', 'https://example.com/images/jessica_bell.jpg', 30, 'MasterCard ending in 5678');

select * from users;

INSERT INTO Sellers (seller_id, company_name, password_hash, contact_details, business_logo, seller_rating, transfer_details, address_id) VALUES
(1, 'Acme Electronics', SHA2('password123', 256), 'contact@acmeelectronics.com, 555-0101', 'https://example.com/logos/acme_electronics.jpg', 4.5, 'Bank transfer', 1),
(2, 'Best Gadgets', SHA2('securePass!45', 256), 'info@bestgadgets.com, 555-0202', 'https://example.com/logos/best_gadgets.jpg', 4.7, 'PayPal', 2),
(3, 'Tech Innovations', SHA2('mySecretPwd', 256), 'support@techinnovations.com, 555-0303', 'https://example.com/logos/tech_innovations.jpg', 4.9, 'Wire transfer', 3),
(4, 'Gadget Store', SHA2('anotherPass789', 256), 'sales@gadgetstore.com, 555-0404', 'https://example.com/logos/gadget_store.jpg', 4.3, 'Credit card', 4),
(5, 'Home Electronics', SHA2('yetAnotherPass', 256), 'contact@homeelectronics.com, 555-0505', 'https://example.com/logos/home_electronics.jpg', 4.8, 'Bank transfer', 5),
(6, 'Fashion Tech', SHA2('examplePass456', 256), 'info@fashiontech.com, 555-0606', 'https://example.com/logos/fashion_tech.jpg', 4.4, 'PayPal', 6),
(7, 'Electro World', SHA2('secure123!', 256), 'support@electroworld.com, 555-0707', 'https://example.com/logos/electro_world.jpg', 4.6, 'Wire transfer', 7),
(8, 'Book Paradise Tech', SHA2('pass123Secure', 256), 'sales@bookparadisetech.com, 555-0808', 'https://example.com/logos/book_paradise_tech.jpg', 4.7, 'Credit card', 8),
(9, 'Sports Tech Gear', SHA2('mypassword789', 256), 'contact@sportstechgear.com, 555-0909', 'https://example.com/logos/sports_tech_gear.jpg', 4.5, 'Bank transfer', 9),
(10, 'Auto Gadgets', SHA2('!SecurePass456', 256), 'info@autogadgets.com, 555-1010', 'https://example.com/logos/auto_gadgets.jpg', 4.8, 'PayPal', 10),
(11, 'Outdoor Tech', SHA2('AnotherPass!789', 256), 'support@outdoortech.com, 555-1111', 'https://example.com/logos/outdoor_tech.jpg', 4.9, 'Wire transfer', 11),
(12, 'Kitchen Gadgets', SHA2('Passw0rd!123', 256), 'sales@kitchengadgets.com, 555-1212', 'https://example.com/logos/kitchen_gadgets.jpg', 4.7, 'Credit card', 12),
(13, 'Pet Tech Supplies', SHA2('S3cureP@ss', 256), 'contact@pettechsupplies.com, 555-1313', 'https://example.com/logos/pet_tech_supplies.jpg', 4.8, 'Bank transfer', 13),
(14, 'Gaming Gadgets', SHA2('AnotherS3cureP@ss', 256), 'info@gaminggadgets.com, 555-1414', 'https://example.com/logos/gaming_gadgets.jpg', 4.7, 'PayPal', 14),
(15, 'Office Tech', SHA2('SecureP@ssword123', 256), 'support@officetech.com, 555-1515', 'https://example.com/logos/office_tech.jpg', 4.5, 'Wire transfer', 15),
(16, 'Mobile Accessories', SHA2('YetAn0therP@ss', 256), 'sales@mobileaccessories.com, 555-1616', 'https://example.com/logos/mobile_accessories.jpg', 4.6, 'Credit card', 16),
(17, 'Camera Gadgets', SHA2('P@ssw0rdSecure!', 256), 'contact@cameragadgets.com, 555-1717', 'https://example.com/logos/camera_gadgets.jpg', 4.9, 'Bank transfer', 17),
(18, 'Smart Home Tech', SHA2('MyS3cureP@ss123', 256), 'info@smarthometech.com, 555-1818', 'https://example.com/logos/smart_home_tech.jpg', 4.7, 'PayPal', 18),
(19, 'Wearable Tech', SHA2('Passw0rd!Secure', 256), 'support@wearabletech.com, 555-1919', 'https://example.com/logos/wearable_tech.jpg', 4.5, 'Wire transfer', 19),
(20, 'Health Gadgets', SHA2('S3cur3Passw0rd!', 256), 'sales@healthgadgets.com, 555-2020', 'https://example.com/logos/health_gadgets.jpg', 4.8, 'Credit card', 20),
(21, 'Fitness Tech', SHA2('YetAnotherS3curePass!', 256), 'contact@fitnesstech.com, 555-2121', 'https://example.com/logos/fitness_tech.jpg', 4.7, 'Bank transfer', 21),
(22, 'Tech Toys', SHA2('P@ssw0rd!Another', 256), 'info@techtoys.com, 555-2222', 'https://example.com/logos/tech_toys.jpg', 4.9, 'PayPal', 22),
(23, 'Travel Gadgets', SHA2('S3cureP@ss!789', 256), 'support@travelgadgets.com, 555-2323', 'https://example.com/logos/travel_gadgets.jpg', 4.6, 'Wire transfer', 23),
(24, 'Luxury Tech', SHA2('YetAnotherP@ss789', 256), 'sales@luxurytech.com, 555-2424', 'https://example.com/logos/luxury_tech.jpg', 4.5, 'Credit card', 24),
(25, 'Music Gadgets', SHA2('MyS3cureP@ss123!', 256), 'contact@musicgadgets.com, 555-2525', 'https://example.com/logos/music_gadgets.jpg', 4.8, 'Bank transfer', 25),
(26, 'Tech Gifts', SHA2('AnotherSecureP@ss!', 256), 'info@techgifts.com, 555-2626', 'https://example.com/logos/tech_gifts.jpg', 4.7, 'PayPal', 26),
(27, 'Drone Gadgets', SHA2('S3cur3P@ssw0rd123', 256), 'support@dronegadgets.com, 555-2727', 'https://example.com/logos/drone_gadgets.jpg', 4.9, 'Wire transfer', 27),
(28, 'Virtual Reality Gadgets', SHA2('P@ssword123Secure!', 256), 'sales@vrgadgets.com, 555-2828', 'https://example.com/logos/vr_gadgets.jpg', 4.6, 'Credit card', 28),
(29, 'Tech Wearables', SHA2('S3cureP@ssword789', 256), 'contact@techwearables.com, 555-2929', 'https://example.com/logos/tech_wearables.jpg', 4.5, 'Bank transfer', 29),
(30, 'Robotics Gadgets', SHA2('YetAnotherSecureP@ss123', 256), 'info@roboticsgadgets.com, 555-3030', 'https://example.com/logos/robotics_gadgets.jpg', 4.8, 'PayPal', 30);

select * from Sellers;


INSERT INTO Categories (category_id, category_name, category_description) VALUES
(1, 'Smartphones', 'Latest smartphones from top brands'),
(2, 'Laptops', 'High-performance laptops for all your needs'),
(3, 'Tablets', 'Portable and powerful tablets'),
(4, 'Wearable Technology', 'Smartwatches, fitness trackers, and more'),
(5, 'Headphones', 'Noise-cancelling and high-fidelity headphones'),
(6, 'Cameras', 'Digital cameras, DSLRs, and accessories'),
(7, 'Televisions', 'Smart TVs, 4K Ultra HD TVs, and more'),
(8, 'Home Audio', 'Speakers, soundbars, and home audio systems'),
(9, 'Video Games', 'Consoles, games, and accessories'),
(10, 'Drones', 'High-tech drones with advanced features'),
(11, 'Virtual Reality', 'VR headsets and accessories'),
(12, 'Smart Home', 'Smart home devices and automation systems'),
(13, 'Fitness Technology', 'Fitness trackers, smart scales, and more'),
(14, 'Portable Chargers', 'Power banks and portable chargers'),
(15, 'Computer Accessories', 'Keyboards, mice, and other accessories'),
(16, 'Networking', 'Routers, modems, and networking equipment'),
(17, 'Monitors', 'High-resolution computer monitors'),
(18, 'Printers', 'Inkjet, laser, and 3D printers'),
(19, 'Storage Devices', 'External hard drives and SSDs'),
(20, 'Projectors', 'High-quality projectors for home and office'),
(21, 'Smart Lighting', 'Smart bulbs, light strips, and more'),
(22, 'Home Security', 'Cameras, alarms, and security systems'),
(23, 'Automotive Electronics', 'Car audio, GPS, and other car electronics'),
(24, 'Bluetooth Devices', 'Bluetooth speakers, headphones, and more'),
(25, 'Gaming Accessories', 'Controllers, headsets, and gaming chairs'),
(26, 'Office Electronics', 'Fax machines, scanners, and office equipment'),
(27, 'Health Tech', 'Digital thermometers, blood pressure monitors, and more'),
(28, 'Kitchen Gadgets', 'Electronic kitchen appliances and gadgets'),
(29, 'Photography Accessories', 'Tripods, camera bags, and other accessories'),
(30, 'Robotics', 'Educational and hobbyist robots and kits');

select * from Categories;

INSERT INTO Products (product_id, seller_id, category_id, name, description, price, quantity, product_image, product_rating) VALUES
(1, 1, 1, 'iPhone 13', 'Latest model of Apple iPhone', 799.99, 50, 'https://example.com/products/iphone13.jpg', 4.8),
(2, 2, 1, 'Samsung Galaxy S21', 'High-end Android smartphone', 699.99, 30, 'https://example.com/products/galaxy_s21.jpg', 4.7),
(3, 3, 2, 'MacBook Pro', 'Apple laptop with M1 chip', 1299.99, 20, 'https://example.com/products/macbook_pro.jpg', 4.9),
(4, 4, 2, 'Dell XPS 13', 'High-performance laptop', 999.99, 15, 'https://example.com/products/dell_xps_13.jpg', 4.6),
(5, 5, 3, 'iPad Pro', 'Apple tablet with A12Z Bionic chip', 799.99, 25, 'https://example.com/products/ipad_pro.jpg', 4.8),
(6, 6, 3, 'Samsung Galaxy Tab S7', 'High-end Android tablet', 649.99, 20, 'https://example.com/products/galaxy_tab_s7.jpg', 4.7),
(7, 7, 4, 'Apple Watch Series 6', 'Smartwatch with health tracking features', 399.99, 40, 'https://example.com/products/apple_watch_6.jpg', 4.8),
(8, 8, 4, 'Fitbit Versa 3', 'Fitness smartwatch with GPS', 229.99, 35, 'https://example.com/products/fitbit_versa_3.jpg', 4.5),
(9, 9, 5, 'Sony WH-1000XM4', 'Noise-cancelling headphones', 349.99, 50, 'https://example.com/products/sony_wh1000xm4.jpg', 4.9),
(10, 10, 5, 'Bose QuietComfort 35 II', 'Wireless noise-cancelling headphones', 299.99, 40, 'https://example.com/products/bose_qc35_ii.jpg', 4.7),
(11, 11, 6, 'Canon EOS R5', 'Full-frame mirrorless camera', 3899.99, 10, 'https://example.com/products/canon_eos_r5.jpg', 4.8),
(12, 12, 6, 'Nikon Z6 II', 'Mirrorless camera with 24.5MP sensor', 1999.99, 12, 'https://example.com/products/nikon_z6_ii.jpg', 4.7),
(13, 13, 7, 'Samsung QLED 4K TV', '65-inch smart TV with 4K resolution', 1499.99, 15, 'https://example.com/products/samsung_qled_4k.jpg', 4.9),
(14, 14, 7, 'LG OLED CX', '55-inch smart TV with OLED technology', 1399.99, 20, 'https://example.com/products/lg_oled_cx.jpg', 4.8),
(15, 15, 8, 'Sonos One', 'Smart speaker with Alexa built-in', 199.99, 30, 'https://example.com/products/sonos_one.jpg', 4.6),
(16, 16, 8, 'Bose Soundbar 700', 'Premium soundbar for home audio', 799.99, 20, 'https://example.com/products/bose_soundbar_700.jpg', 4.7),
(17, 17, 9, 'PlayStation 5', 'Next-gen gaming console from Sony', 499.99, 10, 'https://example.com/products/ps5.jpg', 4.9),
(18, 18, 9, 'Xbox Series X', 'Next-gen gaming console from Microsoft', 499.99, 12, 'https://example.com/products/xbox_series_x.jpg', 4.8),
(19, 19, 10, 'DJI Mavic Air 2', 'Advanced drone with 4K camera', 799.99, 15, 'https://example.com/products/dji_mavic_air_2.jpg', 4.7),
(20, 20, 10, 'Parrot Anafi', 'Compact and portable drone', 699.99, 20, 'https://example.com/products/parrot_anafi.jpg', 4.5),
(21, 21, 11, 'Oculus Quest 2', 'VR headset with advanced features', 299.99, 25, 'https://example.com/products/oculus_quest_2.jpg', 4.9),
(22, 22, 11, 'HTC Vive Cosmos', 'High-end VR headset', 699.99, 18, 'https://example.com/products/htc_vive_cosmos.jpg', 4.7),
(23, 23, 12, 'Amazon Echo', 'Smart speaker with Alexa', 99.99, 50, 'https://example.com/products/amazon_echo.jpg', 4.8),
(24, 24, 12, 'Google Nest Hub', 'Smart display with Google Assistant', 129.99, 40, 'https://example.com/products/google_nest_hub.jpg', 4.6),
(25, 25, 13, 'Fitbit Charge 4', 'Fitness tracker with GPS', 149.99, 30, 'https://example.com/products/fitbit_charge_4.jpg', 4.5),
(26, 26, 13, 'Garmin Forerunner 945', 'Advanced GPS running watch', 599.99, 20, 'https://example.com/products/garmin_forerunner_945.jpg', 4.7),
(27, 27, 14, 'Anker PowerCore 10000', 'Portable charger with high capacity', 39.99, 50, 'https://example.com/products/anker_powercore_10000.jpg', 4.8),
(28, 28, 14, 'RAVPower 20000mAh', 'Portable power bank with fast charging', 49.99, 40, 'https://example.com/products/ravpower_20000.jpg', 4.7),
(29, 29, 15, 'Logitech MX Master 3', 'Advanced wireless mouse', 99.99, 30, 'https://example.com/products/logitech_mx_master_3.jpg', 4.8),
(30, 30, 15, 'Corsair K95 RGB', 'Mechanical gaming keyboard', 199.99, 25, 'https://example.com/products/corsair_k95_rgb.jpg', 4.7);

select * from Products;

INSERT INTO Product_Categories (product_id, category_id) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(6, 3),
(7, 4),
(8, 4),
(9, 5),
(10, 5),
(11, 6),
(12, 6),
(13, 7),
(14, 7),
(15, 8),
(16, 8),
(17, 9),
(18, 9),
(19, 10),
(20, 10),
(21, 11),
(22, 11),
(23, 12),
(24, 12),
(25, 13),
(26, 13),
(27, 14),
(28, 14),
(29, 15),
(30, 15);

select * from Product_Categories;

INSERT INTO Carts (cart_id, user_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 21),
(22, 22),
(23, 23),
(24, 24),
(25, 25),
(26, 26),
(27, 27),
(28, 28),
(29, 29),
(30, 30);

select * from Carts;

INSERT INTO Cart_Items (cart_item_id, cart_id, product_id, quantity, price) VALUES
(1, 1, 1, 1, 799.99),
(2, 2, 2, 2, 699.99),
(3, 3, 3, 1, 1299.99),
(4, 4, 4, 3, 999.99),
(5, 5, 5, 1, 799.99),
(6, 6, 6, 2, 649.99),
(7, 7, 7, 1, 399.99),
(8, 8, 8, 4, 229.99),
(9, 9, 9, 1, 349.99),
(10, 10, 10, 2, 299.99),
(11, 11, 11, 1, 3899.99),
(12, 12, 12, 3, 1999.99),
(13, 13, 13, 1, 1499.99),
(14, 14, 14, 2, 1399.99),
(15, 15, 15, 1, 199.99),
(16, 16, 16, 1, 799.99),
(17, 17, 17, 2, 499.99),
(18, 18, 18, 1, 499.99),
(19, 19, 19, 3, 799.99),
(20, 20, 20, 1, 699.99),
(21, 21, 21, 2, 299.99),
(22, 22, 22, 1, 699.99),
(23, 23, 23, 1, 99.99),
(24, 24, 24, 3, 129.99),
(25, 25, 25, 1, 149.99),
(26, 26, 26, 1, 599.99),
(27, 27, 27, 2, 39.99),
(28, 28, 28, 1, 49.99),
(29, 29, 29, 2, 99.99),
(30, 30, 30, 1, 199.99);


select * from Cart_Items;

INSERT INTO Orders (order_id, user_id, status, total_price, shipping_details) VALUES
(1, 1, 'Processing', 1599.98, '123 Main St, New York, NY, 10001'),
(2, 2, 'Shipped', 1399.98, '456 Maple Ave, Los Angeles, CA, 90001'),
(3, 3, 'Delivered', 1299.99, '789 Oak St, Chicago, IL, 60601'),
(4, 4, 'Processing', 2999.97, '101 Pine Rd, Houston, TX, 77001'),
(5, 5, 'Shipped', 799.99, '202 Birch Blvd, Phoenix, AZ, 85001'),
(6, 6, 'Delivered', 1299.98, '303 Cedar Ln, Philadelphia, PA, 19101'),
(7, 7, 'Processing', 399.99, '404 Spruce St, San Antonio, TX, 78201'),
(8, 8, 'Shipped', 919.96, '505 Willow Dr, San Diego, CA, 92101'),
(9, 9, 'Delivered', 349.99, '606 Ash Ave, Dallas, TX, 75201'),
(10, 10, 'Processing', 599.98, '707 Elm St, San Jose, CA, 95101'),
(11, 11, 'Shipped', 3899.99, '808 Poplar St, Austin, TX, 73301'),
(12, 12, 'Delivered', 5999.97, '909 Fir St, Jacksonville, FL, 32099'),
(13, 13, 'Processing', 1499.99, '100 Redwood Blvd, Fort Worth, TX, 76101'),
(14, 14, 'Shipped', 2799.98, '110 Palm St, Columbus, OH, 43085'),
(15, 15, 'Delivered', 199.99, '120 Cypress Ave, Charlotte, NC, 28201'),
(16, 16, 'Processing', 799.99, '130 Magnolia Rd, San Francisco, CA, 94101'),
(17, 17, 'Shipped', 999.98, '140 Juniper St, Indianapolis, IN, 46201'),
(18, 18, 'Delivered', 499.99, '150 Sequoia Ave, Seattle, WA, 98101'),
(19, 19, 'Processing', 2399.97, '160 Dogwood Dr, Denver, CO, 80201'),
(20, 20, 'Shipped', 699.99, '170 Hemlock St, Washington, DC, 20001'),
(21, 21, 'Delivered', 599.98, '180 Chestnut St, Boston, MA, 02101'),
(22, 22, 'Processing', 299.99, '190 Maple Dr, El Paso, TX, 79901'),
(23, 23, 'Shipped', 99.99, '200 Oak Ln, Detroit, MI, 48201'),
(24, 24, 'Delivered', 387.96, '210 Pine Ave, Nashville, TN, 37201'),
(25, 25, 'Processing', 149.99, '220 Birch St, Memphis, TN, 37501'),
(26, 26, 'Shipped', 599.99, '230 Cedar Blvd, Portland, OR, 97201'),
(27, 27, 'Delivered', 79.98, '240 Spruce Ln, Oklahoma City, OK, 73101'),
(28, 28, 'Processing', 49.99, '250 Willow St, Las Vegas, NV, 89101'),
(29, 29, 'Shipped', 199.98, '260 Ash Blvd, Louisville, KY, 40201'),
(30, 30, 'Delivered', 199.99, '270 Elm Rd, Baltimore, MD, 21201');

INSERT INTO Orders (order_id, user_id, order_date, status, total_price, shipping_details) VALUES
(31, 11, '2023-01-15', 'Processing', 1599.98, '123 Main St, New York, NY, 10001'),
(32, 12, '2023-01-20', 'Shipped', 1299.99, '123 Main St, New York, NY, 10001'),
(33, 21, '2023-02-10', 'Delivered', 1399.98, '456 Maple Ave, Los Angeles, CA, 90001'),
(34, 24, '2023-03-05', 'Processing', 999.99, '456 Maple Ave, Los Angeles, CA, 90001'),
(35, 30, '2023-01-22', 'Shipped', 1299.98, '789 Oak St, Chicago, IL, 60601'),
(36, 13, '2023-02-15', 'Delivered', 919.96, '789 Oak St, Chicago, IL, 60601'),
(37, 24, '2023-03-10', 'Processing', 349.99, '101 Pine Rd, Houston, TX, 77001'),
(38, 14, '2023-03-18', 'Shipped', 599.98, '101 Pine Rd, Houston, TX, 77001');

INSERT INTO Orders (order_id, user_id, order_date, status, total_price, shipping_details) VALUES
(39, 30, '2022-01-15', 'Processing', 1599.98, '123 Main St, New York, NY, 10001'),
(40, 29, '2022-01-20', 'Shipped', 1299.99, '123 Main St, New York, NY, 10001'),
(41, 28, '2022-02-10', 'Delivered', 1399.98, '456 Maple Ave, Los Angeles, CA, 90001');
select * from Orders;

INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price) VALUES
(1, 1, 1, 2, 799.99),
(2, 2, 2, 2, 699.99),
(3, 3, 3, 1, 1299.99),
(4, 4, 4, 3, 999.99),
(5, 5, 5, 1, 799.99),
(6, 6, 6, 2, 649.99),
(7, 7, 7, 1, 399.99),
(8, 8, 8, 4, 229.99),
(9, 9, 9, 1, 349.99),
(10, 10, 10, 2, 299.99),
(11, 11, 11, 1, 3899.99),
(12, 12, 12, 3, 1999.99),
(13, 13, 13, 1, 1499.99),
(14, 14, 14, 2, 1399.99),
(15, 15, 15, 1, 199.99),
(16, 16, 16, 1, 799.99),
(17, 17, 17, 2, 499.99),
(18, 18, 18, 1, 499.99),
(19, 19, 19, 3, 799.99),
(20, 20, 20, 1, 699.99),
(21, 21, 21, 2, 299.99),
(22, 22, 22, 1, 299.99),
(23, 23, 23, 1, 99.99),
(24, 24, 24, 3, 129.99),
(25, 25, 25, 1, 149.99),
(26, 26, 26, 1, 599.99),
(27, 27, 27, 2, 39.99),
(28, 28, 28, 1, 49.99),
(29, 29, 29, 2, 99.99),
(30, 30, 30, 1, 199.99);

INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price) VALUES
(31, 1, 1, 1, 799.99),
(32, 1, 2, 1, 799.99),
(33, 1, 2, 1, 1299.99),
(34, 1, 3, 1, 699.99),
(35, 13, 4, 1, 699.99),
(36, 24, 4, 1, 999.99),
(37, 16, 5, 2, 649.99),
(38, 16, 6, 1, 649.99),
(39, 16, 7, 1, 269.99),
(40, 17, 7, 1, 349.99),
(41, 18, 8, 2, 299.99);

select * from Order_Items;

INSERT INTO Payments (payment_id, order_id, amount, payment_method) VALUES
(1, 1, 1599.98, 'Credit Card'),
(2, 2, 1399.98, 'PayPal'),
(3, 3, 1299.99, 'Credit Card'),
(4, 4, 2999.97, 'Bank Transfer'),
(5, 5, 799.99, 'Credit Card'),
(6, 6, 1299.98, 'PayPal'),
(7, 7, 399.99, 'Credit Card'),
(8, 8, 919.96, 'Bank Transfer'),
(9, 9, 349.99, 'Credit Card'),
(10, 10, 599.98, 'PayPal'),
(11, 11, 3899.99, 'Credit Card'),
(12, 12, 5999.97, 'Bank Transfer'),
(13, 13, 1499.99, 'Credit Card'),
(14, 14, 2799.98, 'PayPal'),
(15, 15, 199.99, 'Credit Card'),
(16, 16, 799.99, 'Bank Transfer'),
(17, 17, 999.98, 'Credit Card'),
(18, 18, 499.99, 'PayPal'),
(19, 19, 2399.97, 'Credit Card'),
(20, 20, 699.99, 'Bank Transfer'),
(21, 21, 599.98, 'Credit Card'),
(22, 22, 299.99, 'PayPal'),
(23, 23, 99.99, 'Credit Card'),
(24, 24, 387.96, 'Bank Transfer'),
(25, 25, 149.99, 'Credit Card'),
(26, 26, 599.99, 'PayPal'),
(27, 27, 79.98, 'Credit Card'),
(28, 28, 49.99, 'Bank Transfer'),
(29, 29, 199.98, 'Credit Card'),
(30, 30, 199.99, 'PayPal');

INSERT INTO Payments (payment_id, order_id, amount, payment_method) VALUES
(31, 31, 1599.98, 'Credit Card'),
(32, 32, 1299.99, 'PayPal'),
(33, 33, 1399.98, 'Credit Card'),
(34, 34, 999.99, 'Bank Transfer'),
(35, 35, 1299.98, 'Credit Card'),
(36, 36, 919.96, 'PayPal'),
(37, 37, 349.99, 'Credit Card'),
(38, 38, 599.98, 'Bank Transfer');
select * from Payments;

INSERT INTO Reviews (review_id, product_id, user_id, rating, comment) VALUES
(1, 1, 1, 5, 'Excellent product!'),
(2, 2, 2, 4, 'Very good, but could be cheaper.'),
(3, 3, 3, 5, 'Amazing performance!'),
(4, 4, 4, 4, 'Great laptop for the price.'),
(5, 5, 5, 5, 'Love my new iPad!'),
(6, 6, 6, 4, 'Good tablet, but a bit expensive.'),
(7, 7, 7, 5, 'Perfect smartwatch!'),
(8, 8, 8, 4, 'Nice features, but battery life could be better.'),
(9, 9, 9, 5, 'Best headphones I have ever owned!'),
(10, 10, 10, 4, 'Great sound quality.'),
(11, 11, 11, 5, 'Outstanding camera!'),
(12, 12, 12, 4, 'Very good, but heavy.'),
(13, 13, 13, 5, 'Love the picture quality!'),
(14, 14, 14, 4, 'Great TV, but expensive.'),
(15, 15, 15, 5, 'Best speaker ever!'),
(16, 16, 16, 4, 'Nice soundbar, but a bit pricey.'),
(17, 17, 17, 5, 'Amazing console!'),
(18, 18, 18, 4, 'Very good, but games are expensive.'),
(19, 19, 19, 5, 'Fantastic drone!'),
(20, 20, 20, 4, 'Great drone, but battery life could be better.'),
(21, 21, 21, 5, 'Best VR headset!'),
(22, 22, 22, 4, 'Very immersive experience.'),
(23, 23, 23, 5, 'Love my Echo!'),
(24, 24, 24, 4, 'Great smart display.'),
(25, 25, 25, 5, 'Best fitness tracker!'),
(26, 26, 26, 4, 'Very good, but a bit bulky.'),
(27, 27, 27, 5, 'Perfect portable charger!'),
(28, 28, 28, 4, 'Nice power bank.'),
(29, 29, 29, 5, 'Best mouse ever!'),
(30, 30, 30, 4, 'Great keyboard, but expensive.');


select * from Reviews;

INSERT INTO Support_Tickets (ticket_id, user_id, product_id, issue_description, status) VALUES
(1, 1, 1, 'Screen flickering issue.', 'Open'),
(2, 2, 2, 'Battery draining quickly.', 'Resolved'),
(3, 3, 3, 'Overheating problem.', 'Open'),
(4, 4, 4, 'Keyboard not working.', 'Closed'),
(5, 5, 5, 'Screen cracked.', 'Open'),
(6, 6, 6, 'Tablet not charging.', 'Resolved'),
(7, 7, 7, 'Watch strap broken.', 'Open'),
(8, 8, 8, 'GPS not accurate.', 'Closed'),
(9, 9, 9, 'Headphones not connecting.', 'Open'),
(10, 10, 10, 'Sound issues.', 'Resolved'),
(11, 11, 11, 'Camera lens scratched.', 'Open'),
(12, 12, 12, 'Focus issues.', 'Closed'),
(13, 13, 13, 'TV not turning on.', 'Open'),
(14, 14, 14, 'Remote not working.', 'Resolved'),
(15, 15, 15, 'Speaker distortion.', 'Open'),
(16, 16, 16, 'Soundbar not syncing.', 'Closed'),
(17, 17, 17, 'Console overheating.', 'Open'),
(18, 18, 18, 'Game crashing.', 'Resolved'),
(19, 19, 19, 'Drone not flying straight.', 'Open'),
(20, 20, 20, 'Battery not charging.', 'Closed'),
(21, 21, 21, 'VR headset not responding.', 'Open'),
(22, 22, 22, 'Controller not working.', 'Resolved'),
(23, 23, 23, 'Echo not responding.', 'Open'),
(24, 24, 24, 'Display flickering.', 'Closed'),
(25, 25, 25, 'Tracker not syncing.', 'Open'),
(26, 26, 26, 'Watch face cracked.', 'Resolved'),
(27, 27, 27, 'Power bank not charging.', 'Open'),
(28, 28, 28, 'Power bank overheating.', 'Closed'),
(29, 29, 29, 'Mouse double-clicking.', 'Open'),
(30, 30, 30, 'Keyboard keys sticking.', 'Resolved');

select * from Support_Tickets;

INSERT INTO Warranties (warranty_id, product_id, user_id, order_id, warranty_period, warranty_start_date, warranty_end_date) VALUES
(1, 1, 1, 1, 24, '2022-01-01', '2024-01-01'),
(2, 2, 2, 2, 24, '2022-02-01', '2024-02-01'),
(3, 3, 3, 3, 12, '2022-03-01', '2023-03-01'),
(4, 4, 4, 4, 12, '2022-04-01', '2023-04-01'),
(5, 5, 5, 5, 24, '2022-05-01', '2024-05-01'),
(6, 6, 6, 6, 24, '2022-06-01', '2024-06-01'),
(7, 7, 7, 7, 12, '2022-07-01', '2023-07-01'),
(8, 8, 8, 8, 12, '2022-08-01', '2023-08-01'),
(9, 9, 9, 9, 24, '2022-09-01', '2024-09-01'),
(10, 10, 10, 10, 24, '2022-10-01', '2024-10-01'),
(11, 11, 11, 11, 12, '2022-11-01', '2023-11-01'),
(12, 12, 12, 12, 12, '2022-12-01', '2023-12-01'),
(13, 13, 13, 13, 24, '2023-01-01', '2025-01-01'),
(14, 14, 14, 14, 24, '2023-02-01', '2025-02-01'),
(15, 15, 15, 15, 12, '2023-03-01', '2024-03-01'),
(16, 16, 16, 16, 12, '2023-04-01', '2024-04-01'),
(17, 17, 17, 17, 24, '2023-05-01', '2025-05-01'),
(18, 18, 18, 18, 24, '2023-06-01', '2025-06-01'),
(19, 19, 19, 19, 12, '2023-07-01', '2024-07-01'),
(20, 20, 20, 20, 12, '2023-08-01', '2024-08-01'),
(21, 21, 21, 21, 24, '2023-09-01', '2025-09-01'),
(22, 22, 22, 22, 24, '2023-10-01', '2025-10-01'),
(23, 23, 23, 23, 12, '2023-11-01', '2024-11-01'),
(24, 24, 24, 24, 12, '2023-12-01', '2024-12-01'),
(25, 25, 25, 25, 24, '2024-01-01', '2026-01-01'),
(26, 26, 26, 26, 24, '2024-02-01', '2026-02-01'),
(27, 27, 27, 27, 12, '2024-03-01', '2025-03-01'),
(28, 28, 28, 28, 12, '2024-04-01', '2025-04-01'),
(29, 29, 29, 29, 24, '2024-05-01', '2026-05-01'),
(30, 30, 30, 30, 24, '2024-06-01', '2026-06-01');

select * from Warranties;

INSERT INTO Shopping_Lists (shopping_list_id, user_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 21),
(22, 22),
(23, 23),
(24, 24),
(25, 25),
(26, 26),
(27, 27),
(28, 28),
(29, 29),
(30, 30);


select * from Shopping_Lists;

INSERT INTO Shopping_List_Items (list_item_id, shopping_list_id, product_id, quantity) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 1),
(4, 4, 4, 1),
(5, 5, 5, 2),
(6, 6, 6, 1),
(7, 7, 7, 1),
(8, 8, 8, 2),
(9, 9, 9, 1),
(10, 10, 10, 1),
(11, 11, 11, 1),
(12, 12, 12, 1),
(13, 13, 13, 2),
(14, 14, 14, 1),
(15, 15, 15, 1),
(16, 16, 16, 1),
(17, 17, 17, 2),
(18, 18, 18, 1),
(19, 19, 19, 1),
(20, 20, 20, 1),
(21, 21, 21, 2),
(22, 22, 22, 1),
(23, 23, 23, 1),
(24, 24, 24, 2),
(25, 25, 25, 1),
(26, 26, 26, 1),
(27, 27, 27, 1),
(28, 28, 28, 1),
(29, 29, 29, 2),
(30, 30, 30, 1);


select * from Shopping_List_Items;

INSERT INTO User_Profiles (profile_id, user_id, contact_details, order_history, basic_info) VALUES
(1, 1, '123 Main St, New York, NY, 10001, 555-0101', 'Order1, Order2', 'John Doe, Age 30'),
(2, 2, '456 Maple Ave, Los Angeles, CA, 90001, 555-0202', 'Order3, Order4', 'Jane Smith, Age 28'),
(3, 3, '789 Oak St, Chicago, IL, 60601, 555-0303', 'Order5, Order6', 'Mike Jones, Age 35'),
(4, 4, '101 Pine Rd, Houston, TX, 77001, 555-0404', 'Order7, Order8', 'Susan Brown, Age 32'),
(5, 5, '202 Birch Blvd, Phoenix, AZ, 85001, 555-0505', 'Order9, Order10', 'Karen Davis, Age 27'),
(6, 6, '303 Cedar Ln, Philadelphia, PA, 19101, 555-0606', 'Order11, Order12', 'James Wilson, Age 40'),
(7, 7, '404 Spruce St, San Antonio, TX, 78201, 555-0707', 'Order13, Order14', 'Patricia Taylor, Age 33'),
(8, 8, '505 Willow Dr, San Diego, CA, 92101, 555-0808', 'Order15, Order16', 'Robert Martin, Age 29'),
(9, 9, '606 Ash Ave, Dallas, TX, 75201, 555-0909', 'Order17, Order18', 'Linda Thomas, Age 31'),
(10, 10, '707 Elm St, San Jose, CA, 95101, 555-1010', 'Order19, Order20', 'Barbara Moore, Age 36'),
(11, 11, '808 Poplar St, Austin, TX, 73301, 555-1111', 'Order21, Order22', 'Richard Jackson, Age 34'),
(12, 12, '909 Fir St, Jacksonville, FL, 32099, 555-1212', 'Order23, Order24', 'Mary Lee, Age 28'),
(13, 13, '100 Redwood Blvd, Fort Worth, TX, 76101, 555-1313', 'Order25, Order26', 'William White, Age 37'),
(14, 14, '110 Palm St, Columbus, OH, 43085, 555-1414', 'Order27, Order28', 'Joseph Harris, Age 29'),
(15, 15, '120 Cypress Ave, Charlotte, NC, 28201, 555-1515', 'Order29, Order30', 'Sarah Clark, Age 32'),
(16, 16, '130 Magnolia Rd, San Francisco, CA, 94101, 555-1616', 'Order31, Order32', 'Charles Lewis, Age 40'),
(17, 17, '140 Juniper St, Indianapolis, IN, 46201, 555-1717', 'Order33, Order34', 'Karen Walker, Age 28'),
(18, 18, '150 Sequoia Ave, Seattle, WA, 98101, 555-1818', 'Order35, Order36', 'Daniel Hall, Age 30'),
(19, 19, '160 Dogwood Dr, Denver, CO, 80201, 555-1919', 'Order37, Order38', 'Betty Allen, Age 35'),
(20, 20, '170 Hemlock St, Washington, DC, 20001, 555-2020', 'Order39, Order40', 'David Young, Age 31'),
(21, 21, '180 Chestnut St, Boston, MA, 02101, 555-2121', 'Order41, Order42', 'Dorothy Hernandez, Age 33'),
(22, 22, '190 Maple Dr, El Paso, TX, 79901, 555-2222', 'Order43, Order44', 'Matthew King, Age 30'),
(23, 23, '200 Oak Ln, Detroit, MI, 48201, 555-2323', 'Order45, Order46', 'Lisa Wright, Age 36'),
(24, 24, '210 Pine Ave, Nashville, TN, 37201, 555-2424', 'Order47, Order48', 'Mark Lopez, Age 29'),
(25, 25, '220 Birch St, Memphis, TN, 37501, 555-2525', 'Order49, Order50', 'Nancy Hill, Age 34'),
(26, 26, '230 Cedar Blvd, Portland, OR, 97201, 555-2626', 'Order51, Order52', 'Paul Scott, Age 31'),
(27, 27, '240 Spruce Ln, Oklahoma City, OK, 73101, 555-2727', 'Order53, Order54', 'Sandra Green, Age 32'),
(28, 28, '250 Willow St, Las Vegas, NV, 89101, 555-2828', 'Order55, Order56', 'Steven Adams, Age 33'),
(29, 29, '260 Ash Blvd, Louisville, KY, 40201, 555-2929', 'Order57, Order58', 'George Baker, Age 35'),
(30, 30, '270 Elm Rd, Baltimore, MD, 21201, 555-3030', 'Order59, Order60', 'Jessica Bell, Age 28');

select * from User_Profiles;

INSERT INTO Seller_Profiles (profile_id, seller_id, product_listings, inventory, contact_details, order_status, shipping_info) VALUES
(1, 1, 'Product1, Product2', 'In Stock', 'contact@acmeelectronics.com, 555-0101', 'Pending, Shipped', 'Free shipping on orders over $50'),
(2, 2, 'Product3, Product4', 'Out of Stock', 'info@bestgadgets.com, 555-0202', 'Delivered, Returned', 'Standard shipping rates apply'),
(3, 3, 'Product5, Product6', 'In Stock', 'support@techinnovations.com, 555-0303', 'Processing, Delivered', 'Free shipping on all orders'),
(4, 4, 'Product7, Product8', 'In Stock', 'sales@gadgetstore.com, 555-0404', 'Pending, Shipped', 'Express shipping available'),
(5, 5, 'Product9, Product10', 'Out of Stock', 'contact@homeelectronics.com, 555-0505', 'Delivered, Returned', 'Free shipping on orders over $100'),
(6, 6, 'Product11, Product12', 'In Stock', 'info@fashiontech.com, 555-0606', 'Processing, Delivered', 'Standard shipping rates apply'),
(7, 7, 'Product13, Product14', 'In Stock', 'support@electroworld.com, 555-0707', 'Pending, Shipped', 'Free shipping on all orders'),
(8, 8, 'Product15, Product16', 'In Stock', 'sales@bookparadisetech.com, 555-0808', 'Delivered, Returned', 'Express shipping available'),
(9, 9, 'Product17, Product18', 'Out of Stock', 'contact@sportstechgear.com, 555-0909', 'Processing, Delivered', 'Free shipping on orders over $50'),
(10, 10, 'Product19, Product20', 'In Stock', 'info@autogadgets.com, 555-1010', 'Pending, Shipped', 'Standard shipping rates apply'),
(11, 11, 'Product21, Product22', 'In Stock', 'support@outdoortech.com, 555-1111', 'Delivered, Returned', 'Free shipping on all orders'),
(12, 12, 'Product23, Product24', 'Out of Stock', 'sales@kitchengadgets.com, 555-1212', 'Processing, Delivered', 'Express shipping available'),
(13, 13, 'Product25, Product26', 'In Stock', 'contact@pettechsupplies.com, 555-1313', 'Pending, Shipped', 'Free shipping on orders over $50'),
(14, 14, 'Product27, Product28', 'Out of Stock', 'info@gaminggadgets.com, 555-1414', 'Delivered, Returned', 'Standard shipping rates apply'),
(15, 15, 'Product29, Product30', 'In Stock', 'support@officetech.com, 555-1515', 'Processing, Delivered', 'Free shipping on all orders'),
(16, 16, 'Product31, Product32', 'In Stock', 'sales@mobileaccessories.com, 555-1616', 'Pending, Shipped', 'Express shipping available'),
(17, 17, 'Product33, Product34', 'Out of Stock', 'contact@cameragadgets.com, 555-1717', 'Delivered, Returned', 'Free shipping on orders over $50'),
(18, 18, 'Product35, Product36', 'In Stock', 'info@smarthometech.com, 555-1818', 'Processing, Delivered', 'Standard shipping rates apply'),
(19, 19, 'Product37, Product38', 'In Stock', 'support@wearabletech.com, 555-1919', 'Pending, Shipped', 'Free shipping on all orders'),
(20, 20, 'Product39, Product40', 'Out of Stock', 'sales@healthgadgets.com, 555-2020', 'Delivered, Returned', 'Express shipping available'),
(21, 21, 'Product41, Product42', 'In Stock', 'contact@fitnesstech.com, 555-2121', 'Processing, Delivered', 'Free shipping on orders over $50'),
(22, 22, 'Product43, Product44', 'In Stock', 'info@techtoys.com, 555-2222', 'Pending, Shipped', 'Standard shipping rates apply'),
(23, 23, 'Product45, Product46', 'Out of Stock', 'support@travelgadgets.com, 555-2323', 'Delivered, Returned', 'Free shipping on all orders'),
(24, 24, 'Product47, Product48', 'In Stock', 'sales@luxurytech.com, 555-2424', 'Processing, Delivered', 'Express shipping available'),
(25, 25, 'Product49, Product50', 'In Stock', 'contact@musicgadgets.com, 555-2525', 'Pending, Shipped', 'Free shipping on orders over $50'),
(26, 26, 'Product51, Product52', 'Out of Stock', 'info@techgifts.com, 555-2626', 'Delivered, Returned', 'Standard shipping rates apply'),
(27, 27, 'Product53, Product54', 'In Stock', 'support@dronegadgets.com, 555-2727', 'Processing, Delivered', 'Free shipping on all orders'),
(28, 28, 'Product55, Product56', 'In Stock', 'sales@vrgadgets.com, 555-2828', 'Pending, Shipped', 'Express shipping available'),
(29, 29, 'Product57, Product58', 'Out of Stock', 'contact@techwearables.com, 555-2929', 'Delivered, Returned', 'Free shipping on orders over $50'),
(30, 30, 'Product59, Product60', 'In Stock', 'info@roboticsgadgets.com, 555-3030', 'Processing, Delivered', 'Standard shipping rates apply');

select * from Seller_Profiles;

--  User Interfasce related Queries

-- 1. User registration

INSERT INTO Users (user_id, username, password_hash, email, contact_details, user_image, address_id, payment_info) VALUES
(31, 'joseph_gilbert', SHA2('password123', 256), 'joseph_gilbert@example.com', '558-0101', 'https://example.com/images/joseph_gilbert.jpg', 4, 'Visa ending in 1236');

select * from users;

-- 2. user Login
SELECT username, email, password_hash
FROM Users
WHERE username = 'mike_jones';

-- 3. User verification
SELECT CASE
    WHEN EXISTS (SELECT 1 FROM Users WHERE email = 'mike.jones@example.com')
    THEN 'Email exists.Password reset link is sent to the mail'
    ELSE 'Email does not exist. Go to registration'
END AS message;

-- 4. Seller Registration 
INSERT INTO Sellers (seller_id, company_name, password_hash, contact_details, business_logo, seller_rating, transfer_details, address_id) VALUES
(31, 'Hope Electronics', SHA2('password123', 256), 'contact@hopeelectronics.com, 555-0201', 'https://example.com/logos/hope_electronics.jpg', 4.5, 'Bank transfer', 4);

select * from Sellers;

-- 5. Category Display
SELECT category_id, category_name, category_description
FROM Categories;

-- 6. Adding Product 
INSERT INTO Products (product_id, seller_id, category_id, name, description, price, quantity, product_image, product_rating) VALUES
(31, 31, 1, 'iPhone 15', 'Latest model of Apple iPhone', 1199.99, 100, 'https://example.com/products/iphone15.jpg', 4.9);

-- 7. Editing product
UPDATE Products
SET price = 1000, quantity = 50
WHERE product_id = 31 AND seller_id = 31;

select * From Products;

-- 8. Deleting Product
DELETE FROM Products
WHERE product_id = 31 AND seller_id = 31;

-- 9. Product Listing
SELECT product_id, name, description, price, quantity, product_image, product_rating
FROM Products;

-- 10. Search filter
SELECT product_id, name, description, price, quantity, product_image, product_rating
FROM Products
WHERE name LIKE '%camera%' OR description LIKE '%camera%'
ORDER BY product_id DESC;

-- 11. Viewing cart items
SELECT ci.cart_item_id, p.name, ci.quantity, ci.price, (ci.quantity * ci.price) AS total_price
FROM Cart_Items ci
JOIN Products p ON ci.product_id = p.product_id
WHERE ci.cart_id = 5;

-- 12. Clear Cart:
DELETE FROM Cart_Items WHERE cart_id = 30;

select * from Cart_Items;

-- 13. List of order items in a order
SELECT ci.order_item_id, p.name, ci.quantity, ci.price, (ci.quantity * ci.price) AS total_price
FROM Order_Items ci
JOIN Products p ON ci.product_id = p.product_id
WHERE ci.order_id = 1;

-- 14. Calculate Subtotal for a order
SELECT order_id, SUM(quantity * price) AS total_price
FROM Order_Items
WHERE order_id = 1
GROUP BY order_id;


-- Queries for user and seller profiles

-- 15. See All Orders for a Particular User in the Last Year

SELECT order_id, order_date, status, total_price, shipping_details
FROM Orders
WHERE user_id = 3
  AND order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR);

--  16. See All Reviews for a Particular Seller

SELECT r.review_id, r.product_id, r.user_id, r.rating, r.comment, r.review_date
FROM Reviews r
JOIN Products p ON r.product_id = p.product_id
WHERE p.seller_id = 11;


--  17. See All Products for a Particular Seller  That Are In Stock

SELECT product_id, name, description, price, quantity, product_image, product_rating
FROM Products
WHERE seller_id = 11
  AND quantity > 0;
  
--  18. Retrieve Shopping Lists and Items for a Particular User
SELECT sl.shopping_list_id, sli.list_item_id, p.product_id, p.name AS product_name, p.description AS product_description, p.price, sli.quantity, sli.added_date
FROM Shopping_Lists sl
JOIN Shopping_List_Items sli ON sl.shopping_list_id = sli.shopping_list_id
JOIN Products p ON sli.product_id = p.product_id
WHERE sl.user_id = 3;


-- Bussiness Questions

-- 1.How many vendors do you have registered?
SELECT COUNT(*) AS vendor_count FROM Sellers;

-- 2.Number of active vs inactive vendors are there with the company (this month)?

-- First, determine the activity based on orders this month:

CREATE VIEW ThisMonthActivity AS
SELECT seller_id, COUNT(*) AS activity_count
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
WHERE MONTH(o.order_date) = MONTH(CURRENT_DATE) AND YEAR(o.order_date) = YEAR(CURRENT_DATE)
GROUP BY p.seller_id;

-- Query the view to get the number of active and inactive vendors:
select * from ThisMonthActivity;

SELECT 
    (SELECT COUNT(DISTINCT seller_id) FROM ThisMonthActivity) AS active_vendors,
    (SELECT COUNT(*) FROM Sellers) - (SELECT COUNT(DISTINCT seller_id) FROM ThisMonthActivity) AS inactive_vendors;



-- 3.How many customers have registered with your platform from the beginning?
SELECT COUNT(*) AS customer_count FROM Users;

-- 4.Who is the vendor with the most number listings? 
SELECT s.seller_id, s.company_name, COUNT(p.product_id) AS listing_count
FROM Sellers s
JOIN Products p ON s.seller_id = p.seller_id
GROUP BY s.seller_id, s.company_name
ORDER BY listing_count DESC
LIMIT 1;

-- 5.Who is the customer with most number of orders?
SELECT u.user_id, u.username, COUNT(o.order_id) AS order_count
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username
ORDER BY order_count DESC
LIMIT 1;

-- 6.Top 5 vendors by revenue by month- January, Feb, Mar?

SELECT 
    s.seller_id, s.company_name, 
    MONTH(o.order_date) AS month, YEAR(o.order_date) AS year, 
    SUM(oi.quantity * oi.price) AS total_revenue
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
JOIN Sellers s ON p.seller_id = s.seller_id
GROUP BY s.seller_id, s.company_name, 
	MONTH(o.order_date), 
    YEAR(o.order_date)
ORDER BY year DESC, month DESC, total_revenue DESC
LIMIT 5;



-- 7.Top 5 customers by revenue this year?

CREATE VIEW CustomerRevenue AS
SELECT u.user_id, u.username, SUM(oi.quantity * oi.price) AS total_revenue
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN Order_Items oi ON o.order_id = oi.order_id
WHERE YEAR(o.order_date) = YEAR(CURRENT_DATE)
GROUP BY u.user_id, u.username;

SELECT user_id, username, total_revenue
FROM CustomerRevenue
ORDER BY total_revenue DESC
LIMIT 5;


-- 8.Has our revenue increased last month compared to last year same month?

--  Query to display this month revenue and last year same month revenue in a single table
SELECT 'Last Month Revenue' AS period, SUM(oi.quantity * oi.price) AS revenue
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
WHERE MONTH(o.order_date) = MONTH(CURRENT_DATE - INTERVAL 0 MONTH)
AND YEAR(o.order_date) = YEAR(CURRENT_DATE)

UNION ALL

SELECT 'Last Year Same Month Revenue' AS period, SUM(oi.quantity * oi.price) AS revenue
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
WHERE MONTH(o.order_date) = MONTH(CURRENT_DATE - INTERVAL 0 MONTH)
AND YEAR(o.order_date) = YEAR(CURRENT_DATE) - 1;

-- CUSTOMER QUESTIONS: For user id 2
-- 9.What is most expensive order among my orders?
SELECT o.order_id, o.total_price
FROM Orders o
WHERE o.user_id = 2   -- considered user ID is 2
ORDER BY o.total_price DESC
LIMIT 1;

-- 10.How many orders did I place with your business?
SELECT COUNT(*) AS order_count
FROM Orders
WHERE user_id = 2;  


-- 11.Total historical spend with the business year to date?
SELECT SUM(o.total_price) AS total_spend
FROM Orders o
WHERE o.user_id = 2
AND YEAR(o.order_date) = YEAR(CURRENT_DATE);

-- 12.Present the customer with a trend chart of their expenditure, you can use excel for this question, if needed. Use data from your database.
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month, SUM(o.total_price) AS monthly_spend
FROM Orders o
WHERE o.user_id = 11
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY DATE_FORMAT(o.order_date, '%Y-%m');


-- 13.	What is the size of my database?
SELECT 
    table_schema AS database_name,
    ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS database_size_mb
FROM 
    information_schema.tables
WHERE 
    table_schema = 'Electronicdb'  -- Replaced with our database name
GROUP BY 
    table_schema;
  
  -- 14.	What is the size of each table in my database?

SELECT 
    table_name AS table_name,
    ROUND((data_length + index_length) / 1024 / 1024, 2) AS table_size_mb
FROM 
    information_schema.tables
WHERE 
    table_schema = 'Electronicdb'  
ORDER BY 
    table_size_mb DESC;

-- Indexing

-- Adding indexes to improve join and search performance
CREATE INDEX idx_orders_user_id ON Orders(user_id);
CREATE INDEX idx_order_items_order_id ON Order_Items(order_id);
CREATE INDEX idx_order_items_product_id ON Order_Items(product_id);
CREATE INDEX idx_products_seller_id ON Products(seller_id);
CREATE INDEX idx_products_category_id ON Products(category_id);
CREATE INDEX idx_users_user_id ON Users(user_id);
CREATE INDEX idx_sellers_seller_id ON Sellers(seller_id);

-- Query optimization
SELECT 
    (SELECT COUNT(DISTINCT p.seller_id)
     FROM Orders o
     JOIN Order_Items oi ON o.order_id = oi.order_id
     JOIN Products p ON oi.product_id = p.product_id
     WHERE MONTH(o.order_date) = MONTH(CURRENT_DATE) 
       AND YEAR(o.order_date) = YEAR(CURRENT_DATE)) AS active_vendors,
    (SELECT COUNT(*) 
     FROM Sellers) - 
    (SELECT COUNT(DISTINCT p.seller_id)
     FROM Orders o
     JOIN Order_Items oi ON o.order_id = oi.order_id
     JOIN Products p ON oi.product_id = p.product_id
     WHERE MONTH(o.order_date) = MONTH(CURRENT_DATE) 
       AND YEAR(o.order_date) = YEAR(CURRENT_DATE)) AS inactive_vendors;


-- Transaction Queries
START TRANSACTION;

-- Insert Order Record
INSERT INTO Orders (order_id, user_id, order_date, status, total_price, shipping_details) VALUES
(42, 30, '2022-01-15', 'Processing', 1599.98, '123 Main St, New York, NY, 10001');

-- Insert Order Items
INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price) VALUES
(42, 42, 1, 1, 799.99),
(43, 42, 2, 1, 699.99);

-- Update Product Quantities

UPDATE Products
SET quantity = quantity - 1
WHERE product_id = 1;

UPDATE Products
SET quantity = quantity - 1
WHERE product_id = 2;

-- Insert Payment Record
INSERT INTO Payments (payment_id, order_id, amount, payment_method) VALUES
(39, 1, 1699.98, 'Credit Card');

-- Commit the Transaction
COMMIT;

select * From Orders;

select * From Order_Items;
select * From Products;
select * From Payments;


-- Data Retrieval using Index

SELECT order_id, order_date, status, total_price, shipping_details
FROM Orders
WHERE user_id = 1
  AND order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR);
  
EXPLAIN SELECT order_id, order_date, status, total_price, shipping_details
FROM Orders
WHERE user_id = 1
  AND order_date >= DATE_SUB(CURRENT_DATE, INTERVAL 1 YEAR);






