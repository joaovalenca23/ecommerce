CREATE DATABASE ecommerce;
USE ecommerce;


CREATE TABLE clients(
	idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(10),
    Minit CHAR(3),
    Lname VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    Address VARCHAR(40),
    CONSTRAINT unique_cpf_client unique (CPF)
    
);

CREATE TABLE product(
	idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(10) NOT NULL,
	classification_kids BOOL DEFAULT FALSE,
    category ENUM('Eletrônico', 'Vestimenta','Brinquedo', 'Alimentos') NOT NULL,
	avaliacao FLOAT DEFAULT 0, 
    size VARCHAR(10)
    
);

CREATE TABLE payments(
	idClient INT,
    idPayment INT,
    typePayment ENUM('Dinheiro', 'Cartão', 'Pix') NOT NULL,
    limitAvailable FLOAT,
    PRIMARY KEY(idClient, idPayment)
);

CREATE TABLE orders(
	idOrder INT AUTO_INCREMENT PRIMARY KEY,
	idOrderClient int, 
    orderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') DEFAULT 'Em processamento',
    ordersDescription VARCHAR(255),
    sendValue float default 10,
    paymentCash BOOL DEFAULT FALSE,
    CONSTRAINT fk_orders_client  FOREIGN KEY (idOrderClient) REFERENCES clients(idClient)
);

CREATE TABLE productStorage(
	idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
    storageLocation VARCHAR(255),
    quantity INT DEFAULT 0,
    CONSTRAINT pk_idProductStorage PRIMARY KEY (idProductStorage)
);

CREATE TABLE supplier (
	idSupplier INT AUTO_INCREMENT,
    socialName VARCHAR (255) NOT NULL,
    cnpj CHAR(15) NOT NULL,
    contact CHAR(11) NOT NULL,
    CONSTRAINT pk_idFornecedor PRIMARY KEY (idSupplier),
    CONSTRAINT unique_supplier UNIQUE (cnpj)
);

CREATE TABLE seller(
	idseller INT AUTO_INCREMENT,
    socialName VARCHAR (255) NOT NULL,
    cnpj CHAR(15),
    cpf CHAR(11),
    contact CHAR(11),
    location VARCHAR (255),
    CONSTRAINT pk_seller PRIMARY KEY (idseller),
    CONSTRAINT unique_cnpj UNIQUE (cnpj),
    CONSTRAINT unique_cfpf UNIQUE (cpf) 
);

CREATE TABLE productSeller (
	idPSeller INT,
    idPproduct INT,
    prodQuantity INT DEFAULT 1,
    CONSTRAINT pk_idPSeller_idProduct PRIMARY KEY (idPSeller, idPproduct),
    CONSTRAINT fk_idProduct FOREIGN KEY (idPproduct) REFERENCES product (idProduct),
    CONSTRAINT fk_idPseller FOREIGN KEY (idPSeller) REFERENCES seller (idSeller)
);

CREATE TABLE productOrder(
	idPOrder INT,
    idPOproduct INT,
    poQuantity INT DEFAULT 1,
    poStatus ENUM ('Disponível', 'Sem estoque') DEFAULT 'Disponível',
	CONSTRAINT pk_idPOrder_idPOproduct PRIMARY KEY (idPOrder, idPOproduct),
    CONSTRAINT fk_idPOrder FOREIGN KEY (idPOrder) REFERENCES orders (idOrder),
    CONSTRAINT fk_idPOproduct FOREIGN KEY (idPOproduct) REFERENCES product (idProduct)
);

CREATE TABLE storageLocation(
	idLproduct INT,
    idLstorage INT,
    location VARCHAR (255) NOT NULL,
	CONSTRAINT pk_idLproduct_idLstorage PRIMARY KEY (idLproduct, idLstorage),
    CONSTRAINT fk_idLproduct FOREIGN KEY (idLproduct) REFERENCES product (idProduct),
    CONSTRAINT fk_idLstorage FOREIGN KEY (idLstorage) REFERENCES productStorage (idProductStorage)
);

CREATE TABLE productSupplier (
	idPSupplier INT,
    idPsproduct INT,
    prodQuantity INT not null,
    CONSTRAINT pk_idPSupplier_idsProduct PRIMARY KEY (idPSupplier, idPsproduct),
    CONSTRAINT fk_Supplier_idProduct FOREIGN KEY (idPsproduct) REFERENCES product (idProduct),
    CONSTRAINT fk_idPSupplie_Supplier FOREIGN KEY (idPSupplier) REFERENCES supplier (idSupplier)
);

