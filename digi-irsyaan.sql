CREATE TABLE auths (
    auth_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    account_id BIGINT UNIQUE NOT NULL,
    username VARCHAR UNIQUE NOT NULL,
    password VARCHAR NOT NULL
);


CREATE TABLE accounts (
    account_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    nama VARCHAR NOT NULL,
    balance BIGINT NOT NULL,
    referral_account_id BIGINT,
    FOREIGN KEY (referral_account_id) REFERENCES accounts(account_id)
);

CREATE TABLE transaction_categories (
    transaction_category_id SERIAL PRIMARY KEY,
    nama VARCHAR NOT NULL
);


CREATE TABLE transaction (
    transaction_id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    transaction_category_id BIGINT REFERENCES transaction_categories(transaction_category_id) ON DELETE SET NULL,
    account_id BIGINT NOT NULL,
    from_account_id BIGINT,
    to_account_id BIGINT,
    amount BIGINT NOT NULL,
    transaction_date TIMESTAMP NOT NULL
);


INSERT INTO public.accounts 
("name", balance)
VALUES('Budi', 100000), ('Sumanto', 200000), ('Karim', 550000), ('Paulus', 700000), ('Stevan', 350000);

-

INSERT INTO public.transaction_categories
("name")
VALUES('Food Expenses'), ('Drink Expenses');

-

INSERT INTO public."transaction"
(transaction_category_id, account_id, from_account_id, to_account_id, amount, transaction_date)
VALUES(1, 1, 2, 3, 10000, '2023-01-05'), 
(1, 1, 2, 2, 240857, '2023-02-05'),
(2, 2, 4, 2, 171773, '2023-03-05'),
(1, 4, 4, 2, 109388, '2023-04-05'),
(2, 2, 3, 5, 167874, '2023-05-05'),
(2, 3, 2, 5, 267904, '2023-06-05'),
(1, 2, 1, 5, 125004, '2023-07-05'),
(2, 2, 3, 2, 32735, '2023-08-05'),
(1, 3, 3, 2, 183450, '2023-09-05'),
(1, 4, 4, 5, 184142, '2023-10-05'),
(1, 4, 4, 5, 184142, '2023-11-05'),
(2, 3, 1, 2, 234576, '2023-12-05');

-

UPDATE public.accounts
SET "name"='Samuel', balance=38000
WHERE account_id=4;

-

SELECT 
    t.transaction_id,
    a.name AS account_name,
    t.transaction_category_id,
    t.from_account_id,
    t.to_account_id,
    t.amount,
    t.transaction_date
FROM 
    public.transaction t
JOIN 
    public.accounts a ON t.account_id = a.account_id;

-
   
SELECT *
FROM public.accounts
ORDER BY balance DESC
LIMIT 1;

-

SELECT *
FROM public.transaction
WHERE EXTRACT(MONTH FROM transaction_date) = 5;

-