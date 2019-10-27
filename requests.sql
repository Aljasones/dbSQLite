CREATE TABLE products
(
    id       INTEGER PRIMARY KEY AUTOINCREMENT,
    name     TEXT    NOT NULL,
    price    INTEGER NOT NULL CHECK ( price >= 0 ),
    quantity INTEGER NOT NULL CHECK ( quantity >= 0 ) DEFAULT 0
);

CREATE TABLE managers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    salary INTEGER NOT NULL CHECK ( salary > 0 ),
    plan INTEGER NOT NULL DEFAULT 0,
    boss_id INTEGER REFERENCES managers,
    departament TEXT DEFAULT NULL
);

CREATE TABLE orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    manager_id INTEGER REFERENCES managers NOT NULL
);

CREATE TABLE sales (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER REFERENCES orders NOT NULL,
    product_id INTEGER REFERENCES products NOT NULL,
    quantity INTEGER NOT NULL CHECK ( quantity > 0 ),
    price INTEGER NOT NULL CHECK ( price >= 0 )
);

INSERT INTO products (name, price, quantity) VALUES
('BigMac',200 ,10),
('ChickenMac', 150, 20),
('CheeseBurger', 120, 15),
('Tea', 100, 50),
('Cola', 100, 50),
('Cofee', 100, 50);

INSERT INTO managers (id, name, salary, plan, boss_id) VALUES
(1, 'Vasya', 100, 0, NULL),
(2, 'Petya', 80, 80, 1),
(3, 'Vanya', 60, 60, 2),
(4, 'Dasha', 90, 90, 1),
(5, 'Sasha', 70, 70, 4),
(6, 'Masha', 50, 50, 5);

INSERT INTO orders (id, manager_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO sales (order_id, product_id, quantity, price) VALUES
(1, 1, 5, 200),
(1, 2, 5, 200),
(2, 3, 10, 120),
(3, 3, 10, 120),
(4, 6, 20, 150),
(5, 6, 20, 150),
(5, 5, 10, 100);

UPDATE managers SET salary = salary + 10 WHERE id = 1;

INSERT INTO managers (name, salary, boss_id) VALUES ('Noname', 10, 4);

DELETE FROM managers WHERE name = 'Noname';

SELECT id, name, plan FROM managers;

SELECT id, salary - plan, name FROM managers;

SELECT id, salary - plan AS diff, name FROM managers;

SELECT id, salary FROM managers WHERE plan<>0;

SELECT id, salary FROM managers WHERE plan <> 0 AND salary < 80;

SELECT id, name FROM managers WHERE boss_id IS NULL;

SELECT id, name FROM managers LIMIT 3;
SELECT id, name FROM managers LIMIT 3 OFFSET 3;

SELECT id, name FROM managers ORDER BY name ASC;
SELECT id, name FROM managers ORDER BY name DESC;

UPDATE managers SET salary = 80 WHERE name = 'Sasha';

SELECT id, name, salary FROM managers ORDER BY salary DESC, name ASC;

SELECT id, salary, name FROM managers WHERE salary BETWEEN 50 AND 110;
SELECT id, name FROM managers WHERE  id IN (1,2,5);

SELECT id, name, salary, plan FROM managers WHERE name LIKE 'Va%';
SELECT id, name, salary, plan FROM managers WHERE name LIKE 'Va_ya';

SELECT max(price) FROM products;
SELECT id, name, sum(price * quantity) FROM products;

UPDATE managers SET departament = 'girls' WHERE id>=4;
UPDATE managers SET departament = 'boys' WHERE id IN (2, 3);

SELECT departament, max(salary) FROM managers GROUP BY departament;
SELECT departament, max(salary) FROM managers WHERE departament IS NOT NULL GROUP BY departament;
SELECT departament, max(salary) FROM managers GROUP BY departament HAVING departament IS NOT NULL;

