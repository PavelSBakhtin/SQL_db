USE home_work_1;
CREATE TABLE home_work_1.nomenclature (
  id INT NOT NULL AUTO_INCREMENT,
  manufacturer VARCHAR(45) NOT NULL,
  model VARCHAR(45) NOT NULL,
  price FLOAT NOT NULL,
  PRIMARY KEY (id));
INSERT INTO home_work_1.nomenclature (manufacturer, model, price) VALUES ('Apple', 'iPhone', 99.99);
INSERT INTO home_work_1.nomenclature (manufacturer, model, price) VALUES ('Samsung', 'Galaxy S21 Plus', 59.99),
    ('Samsung', 'Galaxy A32', 49.99), ('Samsung', 'Galaxy M51', 39.99), ('Xiaomi', 'Mi 10T Pro', 79.99),
    ('Xiaomi', 'Redmi Note 9 Pro', 69.99), ('HUAWEI', 'P40 Pro', 49.99), ('HUAWEI', 'P Smart', 39.99),
    ('Realme', '6 Pro', 69.99), ('Realme', 'C3', 59.99), ('Nokia', '8.3', 49.99), ('Nokia', '3.4', 39.99),
    ('ZTE', 'Blade A5', 29.99), ('Vivo', 'V20', 49.99), ('OPPO', 'Reno4', 39.99);
ALTER TABLE nomenclature ADD COLUMN count INT AFTER model;
SELECT model, manufacturer, price FROM nomenclature WHERE count > 2;
SELECT * FROM nomenclature WHERE manufacturer = 'Samsung';
SELECT * FROM nomenclature WHERE model LIKE '%iPhone%';
SELECT * FROM nomenclature WHERE model LIKE '%Galaxy%';
# решил использовать Galaxy, так как Samsung - тоже самое, что и третье задание
SELECT * FROM nomenclature WHERE model RLIKE '[:digit:]';
SELECT * FROM nomenclature WHERE model RLIKE '3';
