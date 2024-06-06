-- Drop tables if they exist
DROP TABLE IF EXISTS "language_list" CASCADE;
DROP TABLE IF EXISTS "currency_list" CASCADE;
DROP TABLE IF EXISTS authentication CASCADE;
DROP TABLE IF EXISTS profile CASCADE;
DROP TABLE IF EXISTS goal CASCADE;
DROP TABLE IF EXISTS "goal_record_money" CASCADE;
DROP TABLE IF EXISTS budget CASCADE;
DROP TABLE IF EXISTS wallet CASCADE;
DROP TABLE IF EXISTS "transaction_list" CASCADE;

--Create table language
create table "language_list" (
	id BIGSERIAL primary key,
	language_name text not null,
	createdAt TIMESTAMP default CURRENT_TIMESTAMP,
	updatedAt TIMESTAMP default CURRENT_TIMESTAMP,
	deletedAt TIMESTAMP
);

--Create table currency
create table "currency_list" (
	id BIGSERIAL primary key,
	currency_name text not null,
	createdAt TIMESTAMP default CURRENT_TIMESTAMP,
	updatedAt TIMESTAMP default CURRENT_TIMESTAMP,
	deletedAt TIMESTAMP
);

--Create table Authentication
create table authentication (
	id BIGSERIAL primary key,
	name VARCHAR(255) not null,
	email VARCHAR(255) not null,
	password VARCHAR(255) not null,
	pin BIGSERIAL not null,
	createdAt TIMESTAMP default CURRENT_TIMESTAMP,
	updatedAt TIMESTAMP default CURRENT_TIMESTAMP,
	deletedAt TIMESTAMP 
);

--Create table profile
create table profile (
	id BIGSERIAL primary key,
	image VARCHAR(50) not null,
	language_id INT not null,
	auth_id INT not null,
	quotes text not null,
	is_new_user BOOLEAN not null,
	on_board TIMESTAMP not null,
	createdAt TIMESTAMP default CURRENT_TIMESTAMP,
	updatedAt TIMESTAMP default CURRENT_TIMESTAMP,
	deletedAt TIMESTAMP,
	constraint fk_authentication foreign key (auth_id) references authentication(id),
	constraint fk_language foreign key (language_id) references "language_list"(id)
);

--Create table Goal
create table goal (
	id BIGSERIAL primary key,
	profile_id INT not null,
	image_goal VARCHAR(50) not null,
	goal_name text not null,
	currency_id INT not null,
	amount DECIMAL(10, 2) not null,
	description VARCHAR(255),
	createdAt TIMESTAMP default CURRENT_TIMESTAMP,
	updatedAt TIMESTAMP default CURRENT_TIMESTAMP,
	deletedAt TIMESTAMP,
	constraint fk_profile foreign key (profile_id) references profile(id),
	constraint fk_currency foreign key (currency_id) references "currency_list"(id)	
);

--Create table Goal Record Money
create table "goal_record_money" (
	id BIGSERIAL primary key,
	goal_id INT not null,
	name text not null,
	currency_id INT not null,
	amount DECIMAL(10,2) not null,
	createdAt TIMESTAMP default CURRENT_TIMESTAMP,
	updatedAt TIMESTAMP default CURRENT_TIMESTAMP,
	deletedAt TIMESTAMP,
	constraint fk_goal foreign key (goal_id) references goal(id),
	constraint fk_currency foreign key (currency_id) references "currency_list"(id)
);

--Create table Budget
create table budget (
	id BIGSERIAL primary key,
	profile_id INT not null,
	emoji VARCHAR(50),
	budget_name text not null,
	currency_id INT not null,
	amount DECIMAL(10, 2) not null,
	description VARCHAR(255),
	createdAt TIMESTAMP default CURRENT_TIMESTAMP,
	updatedAt TIMESTAMP default CURRENT_TIMESTAMP,
	deletedAt TIMESTAMP,
	constraint fk_profile foreign key (profile_id) references profile(id),
	constraint fk_currency foreign key (currency_id) references "currency_list"(id)	
);

--Create table Wallet
create table wallet (
	id BIGSERIAL primary key,
	profile_id INT not null,
	wallet_name text not null,
	currency_id INT not null,
	amount DECIMAL(10, 2) not null,
	is_main BOOLEAN not null,
	createdAt TIMESTAMP default CURRENT_TIMESTAMP,
	updatedAt TIMESTAMP default CURRENT_TIMESTAMP,
	deletedAt TIMESTAMP,
	constraint fk_profile foreign key (profile_id) references profile(id),
	constraint fk_currency foreign key (currency_id) references "currency_list"(id)	
);

--Create table Transaction
create table "transaction_list" (
	id BIGSERIAL primary key,
	profile_id INT not null,
	transaction_name VARCHAR(50) not null,
	transaction_type INT not null,
	transaction_date TIMESTAMP not null,
	currency_id INT not null,
	amount DECIMAL(10, 2) not null,
	budget_id INT not null,
	description VARCHAR(255),
	attachment VARCHAR(50),
	createdAt TIMESTAMP default CURRENT_TIMESTAMP,
	updatedAt TIMESTAMP default CURRENT_TIMESTAMP,
	deletedAt TIMESTAMP,
	constraint fk_profile foreign key (profile_id) references profile(id),
	constraint fk_currency foreign key (currency_id) references "currency_list"(id),
	constraint fk_budget foreign key (budget_id) references budget(id)
);

-- Insert into language_list
INSERT INTO "language_list" (language_name) VALUES
('English'),
('Spanish'),
('French'),
('German'),
('Chinese');

-- Insert into currency_list
INSERT INTO "currency_list" (currency_name) VALUES
('USD'),
('EUR'),
('GBP'),
('JPY'),
('CNY');

-- Insert into authentication
INSERT INTO authentication (name, email, password, pin) VALUES
('John Doe', 'john@example.com', 'password123', 1234),
('Jane Smith', 'jane@example.com', 'password456', 5678),
('Alice Brown', 'alice@example.com', 'password789', 9101),
('Bob White', 'bob@example.com', 'password012', 1121),
('Charlie Black', 'charlie@example.com', 'password345', 3141);

-- Insert into profile
INSERT INTO profile (image, language_id, auth_id, quotes, is_new_user, on_board) VALUES
('image1.jpg', 1, 1, 'Live and let live.', true, CURRENT_TIMESTAMP),
('image2.jpg', 2, 2, 'To be or not to be.', true, CURRENT_TIMESTAMP),
('image3.jpg', 3, 3, 'Carpe diem.', true, CURRENT_TIMESTAMP),
('image4.jpg', 4, 4, 'Seize the day.', true, CURRENT_TIMESTAMP),
('image5.jpg', 5, 5, 'No pain, no gain.', true, CURRENT_TIMESTAMP);

-- Insert into goal
INSERT INTO goal (profile_id, image_goal, goal_name, currency_id, amount, description) VALUES
(1, 'goal1.jpg', 'Buy a Car', 1, 20000.00, 'Save money to buy a new car'),
(2, 'goal2.jpg', 'Vacation', 2, 5000.00, 'Save money for a vacation'),
(3, 'goal3.jpg', 'House Down Payment', 3, 30000.00, 'Save for house down payment'),
(4, 'goal4.jpg', 'New Laptop', 4, 1500.00, 'Save money for a new laptop'),
(5, 'goal5.jpg', 'Wedding', 5, 10000.00, 'Save money for wedding expenses');

-- Insert into goal_record_money
INSERT INTO "goal_record_money" (goal_id, name, currency_id, amount) VALUES
(1, 'Initial Deposit', 1, 5000.00),
(2, 'Initial Deposit', 2, 1000.00),
(3, 'Initial Deposit', 3, 10000.00),
(4, 'Initial Deposit', 4, 500.00),
(5, 'Initial Deposit', 5, 2000.00);

-- Insert into budget
INSERT INTO budget (profile_id, emoji, budget_name, currency_id, amount, description) VALUES
(1, '🏠', 'Rent', 1, 1000.00, 'Monthly rent payment'),
(2, '🍔', 'Groceries', 2, 300.00, 'Monthly grocery expenses'),
(3, '🚗', 'Transportation', 3, 150.00, 'Monthly transportation costs'),
(4, '🎉', 'Entertainment', 4, 200.00, 'Monthly entertainment expenses'),
(5, '💡', 'Utilities', 5, 100.00, 'Monthly utility bills');

-- Insert into wallet
INSERT INTO wallet (profile_id, wallet_name, currency_id, amount, is_main) VALUES
(1, 'Main Wallet', 1, 5000.00, true),
(2, 'Savings Wallet', 2, 3000.00, false),
(3, 'Main Wallet', 3, 7000.00, true),
(4, 'Savings Wallet', 4, 2000.00, false),
(5, 'Main Wallet', 5, 4000.00, true);

-- Insert into transaction_list
INSERT INTO "transaction_list" (profile_id, transaction_name, transaction_type, transaction_date, currency_id, amount, budget_id, description, attachment) VALUES
(1, 'Rent Payment', 1, CURRENT_TIMESTAMP, 1, 1000.00, 1, 'Monthly rent', 'receipt1.jpg'),
(2, 'Grocery Shopping', 1, CURRENT_TIMESTAMP, 2, 150.00, 2, 'Weekly groceries', 'receipt2.jpg'),
(3, 'Bus Ticket', 1, CURRENT_TIMESTAMP, 3, 50.00, 3, 'Bus ticket to work', 'ticket.jpg'),
(4, 'Movie Night', 1, CURRENT_TIMESTAMP, 4, 20.00, 4, 'Movie with friends', 'ticket.jpg'),
(5, 'Electric Bill', 1, CURRENT_TIMESTAMP, 5, 80.00, 5, 'Monthly electric bill', 'bill.jpg'),
(1, 'Lunch', 1, CURRENT_TIMESTAMP, 1, 15.00, 2, 'Lunch at restaurant', 'receipt3.jpg'),
(2, 'Gasoline', 1, CURRENT_TIMESTAMP, 2, 40.00, 3, 'Gasoline for car', 'receipt4.jpg');

--Select all language
select * from "language_list"

--Select all currency
select * from "currency_list"

--Select all authentication
select * from authentication

--Select all language
select * from "language_list"

--Select Profile
select
	p.id as profile_id,
	p.image,
	p.quotes,
	p.is_new_user,
	p.on_board,
	p.createdat as profile_createdAt,
	p.updatedAt as profile_updatedAt,
	p.deletedat as profile_deletedAt,
	a.name as auth_name,
	a.email as auth_email,
	ll.id as language_id,
	ll.language_name
from profile p
join authentication a on p.auth_id = a.id 
join "language_list" ll on p.language_id = ll.id 

--Select Goal by profile id
select
	g.id as goal_id,
	g.image_goal as goal_image,
	g.goal_name,
	g.amount,
	g.description,
	g.createdat as goal_createdAt,
	g.updatedat as goal_updatedAt,
	a.name as auth_name,
	a.email as auth_email,
	cl.currency_name as currency_name
from goal g 
join profile p on g.profile_id = p.id 
join authentication a on p.auth_id = a.id 
join "currency_list" cl on g.currency_id = cl.id 
where p.id = 1

--Select Goal Record Money by profile id
select
	grm.id as goal_record_money_id,
	grm.name,
	grm.amount,
	grm.createdat as goal_record_money_createdAt,
	grm.updatedat as goal_record_money_updatedAt,
	g.id as goal_id,
	g.goal_name,
	p.id as profile_id,
	a."name" as profile_name
from "goal_record_money" grm 
join goal g on grm.goal_id = g.id 
join profile p on g.profile_id = p.id 
join authentication a on p.auth_id = a.id
where p.id = 3

--Select Budget by profile id
select
	b.id as budget_id,
	b.emoji as budget_emoji,
	b.budget_name,
	b.amount as budget_amount,
	b.description as budget_description,
	cl.currency_name,
	p.id as profile_id,
	a."name" as profile_name
from budget b 
join profile p on b.profile_id = p.id 
join authentication a on p.auth_id = a.id 
join "currency_list" cl on b.currency_id = cl.id 
where p.id = 5

--Select Wallet by profile id
select 
	w.id as wallet_id,
	w.wallet_name,
	w.amount as wallet_amount,
	w.is_main as main_wallet,
	w.createdat as wallet_createdAt,
	w.updatedat as wallet_updatedAt,
	p.id as profile_id,
	a."name" as profile_name
from wallet w 
join profile p on w.profile_id = p.id 
join authentication a on p.auth_id = a.id 
join currency_list cl on w.currency_id = cl.id 
where p.id = 4

--Select Transaction by profile id
select 
	tl.id as transaction_id,
	tl.transaction_name,
	tl.transaction_type,
	tl.transaction_date,
	tl.amount as transaction_amount,
	tl.description as transaction_description,
	tl.attachment as transaction_attachment,
	tl.createdat as transaction_createdAt,
	tl.updatedat as transaction_updatedAt,
	p.id as profile_id,
	a."name" as profile_name,
	b.budget_name as pocket_name,
	b.amount as pocket_amount
from transaction_list tl 
join profile p on tl.profile_id = p.id 
join authentication a on p.auth_id = a.id 
join budget b on tl.budget_id = b.id 
join currency_list cl on tl.currency_id = cl.id 
where p.id = 2