=====================
FB
=====================

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    dob DATE,
    location VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    gender ENUM('male', 'female'),
    phone_number VARCHAR(20),
    secret_code VARCHAR(255),
    is_private BOOLEAN DEFAULT FALSE,
    last_login DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
images VARCHAR(255) DEFAULT 'images/defaultuserimg',
coins INT DEFAULT 100
);



CREATE TABLE posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT,
    image_path VARCHAR(255) DEFAULT 'images/defaultpostimg.png',
    visibility ENUM('public', 'private'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE ,
    FOREIGN KEY (user_id) REFERENCES users(id)ON DELETE CASCADE
);

CREATE TABLE likes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(id)  ON DELETE CASCADE ,
    FOREIGN KEY (user_id) REFERENCES users(id)  ON DELETE CASCADE
);

CREATE TABLE friend_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    status ENUM('pending', 'accepted', 'declined') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE ,
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE friends (
    id INT AUTO_INCREMENT PRIMARY KEY,
	user1_id INT, 
	user2_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user1_id) REFERENCES users(id) ON DELETE CASCADE ,
    FOREIGN KEY (user2_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    receiver_id INT,
    sender_id INT,
    content TEXT,
	is_displayed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE ,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE admin_announcements(
    id INT AUTO_INCREMENT PRIMARY KEY,
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    message TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE ,
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE `groups` (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE group_members (
    group_id INT NOT NULL,
    user_id INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (group_id) REFERENCES `groups`(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    PRIMARY KEY (group_id, user_id)
);

CREATE TABLE group_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    group_id INT NOT NULL,
    sender_id INT NOT NULL,
    message TEXT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (group_id) REFERENCES `groups`(id) ON DELETE CASCADE ,
    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE coin_requests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    requester_id INT NOT NULL,
    receiver_id INT NOT NULL,
    quantity INT NOT NULL,
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    FOREIGN KEY (requester_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE offers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
   image_path VARCHAR(255) DEFAULT 'images/defaultofferimg.jpg',
    cost INT NOT NULL
);

CREATE TABLE reports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
=====================================
MOBISHOP
=====================================
CREATE TABLE USER_DETAILS (
    User_Id INT AUTO_INCREMENT,
    Name VARCHAR(255),
    Username VARCHAR(255),
    Password VARCHAR(255),
    DOB DATE,
	Email VARCHAR(255),
    Gender VARCHAR(10),
    Mobile VARCHAR(10),
    Address VARCHAR(1000),
    secretcode VARCHAR(10),
	category ENUM('admin', 'user') NOT NULL DEFAULT 'user',
    PRIMARY KEY (User_Id)
);

CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
	category VARCHAR(255) NOT NULL,
    image VARCHAR(255) NOT NULL,
    description VARCHAR(1000) NOT NULL,
    vendor VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
	price DOUBLE NOT NULL
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    item_id INT ,
    quantity INT NOT NULL,    
    total_price DOUBLE NOT NULL DEFAULT 0.0,
    FOREIGN KEY (user_id) REFERENCES user_details(User_Id),
 FOREIGN KEY (item_id) REFERENCES items(id)
);

CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES items(id),
    FOREIGN KEY (user_id) REFERENCES user_details(User_Id)
);
===============
SHOP PROD
===============
CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
	category VARCHAR(255) NOT NULL,
    image VARCHAR(255) NOT NULL,
    description VARCHAR(1000) NOT NULL,
    vendor VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
	price DOUBLE NOT NULL
);
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_status ENUM('PENDING','COMPLETED','CANCELLED') DEFAULT 'PENDING',
	order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	total_price DOUBLE NOT NULL DEFAULT 0.0,
    FOREIGN KEY (user_id) REFERENCES user_details(User_Id)
);
CREATE TABLE orders_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    quantity INT,
	item_id INT,
	price DOUBLE NOT NULL,
    FOREIGN KEY (item_id) REFERENCES items(id),
	FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
CREATE TABLE pending_orders(
id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT NOT NULL,
order_id INT,
total_price DOUBLE NOT NULL DEFAULT 0.0,
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (user_id) REFERENCES user_details(User_Id)
 
);
CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT NOT NULL,
    user_id INT NOT NULL,
    rating INT NOT NULL,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (item_id) REFERENCES items(id),
    FOREIGN KEY (user_id) REFERENCES user_details(User_Id)
);
==============
ABC BANK
===============
CREATE TABLE users (
    id INT PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(50) NOT NULL,  
    mobile VARCHAR(10) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    isActive boolean NOT NULL default 1,
    LastLogin DATETIME NOT NULL default '1000-01-01 00:00:00',
    date_of_birth DATE NOT NULL;
);
CREATE TABLE accounts(
     account_id INT PRIMARY KEY,
      user_id INT,
      email VARCHAR(50) NOT NULL,
      name  VARCHAR(50) NOT NULL,
      balance DOUBLE NOT NULL default 0.0,
      isActive boolean NOT NULL default 0,
     FOREIGN KEY (user_id) REFERENCES users(id) 
);
---------------
CREATE TABLE password_history(
     pass_id INT AUTO_INCREMENT PRIMARY KEY,
     password VARCHAR(100),
     change_date DATETIME,
     email VARCHAR(50)
);

CREATE TABLE transactions(
       trans_id INT PRIMARY KEY,
       sender_account_id INT,
      sender_user_id INT,
      trans_datetime DATETIME,
      receiver_account_id INT,
      receiver_user_id INT,
      amount DOUBLE NOT NULL,
      message TEXT,
      isValid ENUM('VALID','INVALID') DEFAULT 'VALID',
      transaction_type ENUM('DEPOSIT','WITHDRAWAL','TRANSFER') NOT NULL,
      FOREIGN KEY (sender_account_id) REFERENCES accounts(account_id),
      FOREIGN KEY (sender_user_id) REFERENCES users(id),
      FOREIGN KEY (receiver_account_id) REFERENCES accounts(account_id),
      FOREIGN KEY (receiver_user_id) REFERENCES users(id)

);
-----
ALTER TABLE transactions
MODIFY COLUMN  isValid boolean NOT NULL default 1;


CREATE TABLE messages(
       message_id INT PRIMARY KEY,
       sender_id INT,
       receiver_id INT,
       message TEXT,
       sent_date DATETIME,
       is_Viewed boolean NOT NULL default 0,
       FOREIGN KEY (sender_id) REFERENCES users(id),
       FOREIGN KEY (receiver_id) REFERENCES users(id)
);

CREATE TABLE friends(
        friendship_id INT PRIMARY KEY,
        friend_id INT,
        user_id INT,
        sent_date DATETIME,
        status ENUM('PENDING','ACCEPTED','REJECTED') DEFAULT 'PENDING',
        FOREIGN KEY (friend_id) REFERENCES users(id),
       FOREIGN KEY (user_id) REFERENCES users(id)
);
       
---------------------------------------------------------------------------------------------
CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    source VARCHAR(50) NOT NULL,
    destination VARCHAR(50) NOT NULL,
    travel_date DATE NOT NULL,
    passengers INT(25) NOT NULL,
    bill DOUBLE(10,4) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
CREATE TABLE routes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    source VARCHAR(50) NOT NULL,
    destination VARCHAR(50) NOT NULL,
    vacancy INT(25) NOT NULL,
    fare DOUBLE(10,4) NOT NULL
);

"UPDATE routes SET source= ?, destination=?,vacancy=?,fare=? id = ?";



 










