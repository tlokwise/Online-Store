CREATE TABLE category (
	category_id varchar(255) PRIMARY KEY,
    category_name varchar(255) NOT NULL
);

CREATE TABLE products (
	product_id int PRIMARY KEY,
    product_name varchar(255) NOT NULL,
    product_description varchar(255),
    price float NOT NULL,
    category_id varchar(255) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE product_images (
	image_id int PRIMARY KEY,
    product_id int NOT NULL,
    image_url varchar(1000),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
