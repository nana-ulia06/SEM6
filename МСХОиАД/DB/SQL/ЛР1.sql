use STAFF_DB;
go

drop table Employee;
drop table Employer;
drop table Manager;
drop table Vacancy;
drop table Application;
drop table Interview;
drop table Status_History;

-- 1. наемный персонал
create table Employee (
	employee_id int identity (1,1) primary key,
	fio nvarchar(100),
	date_of_birth date,
	phone_number nvarchar(13),
	email nvarchar(100),
	live_address nvarchar(100),
	resume_text text,
	status nvarchar(20) default 'new'
) on [primary];

-- 2. наниматель
create table Employer (
	employer_id int identity (1,1) primary key,
	fio nvarchar(100),
	company_name nvarchar(100),
	phone_number nvarchar(13),
	email nvarchar(100),
	company_address nvarchar(100)
) on [primary];

-- 3. менеджер по персоналу
create table Manager (
	manager_id int identity (1,1) primary key,
	fio nvarchar(100),
	phone_number nvarchar(13),
	email nvarchar(100),
);

-- 4. сама вакансия
create table Vacancy (
	vacancy_id int identity (1,1) primary key,
	employer_id int not null references Employer(employer_id),
	vacancy_title nvarchar(100) not null,
	description text,
	requirements text,
	salary decimal(10,2),
	open_date date not null,
	close_date date null,
	status nvarchar(20) default 'open'
) on [primary];

-- 5. ответ на вакансию
create table Application (
	application_id int identity (1,1) primary key,
	vacancy_id int not null references Vacancy(vacancy_id),
	employee_id int not null references Employee(employee_id),
	unique(vacancy_id, employee_id),
	application_date date not null,
	status nvarchar(20) default 'new', -- new, reviewed, interviewed, offered, hired, rejected 
);

-- 6. собесы
create table Interview (
	interview_id int identity (1,1) primary key,
	application_id int not null references Application(application_id),
	interview_date date not null,
	interview_time time,
	manager_id int not null references Manager(manager_id), -- надо сделать таблицу с менеджерами которые персонал собесы проводят
	result nvarchar(20) default 'pending' -- passed, failed, pending
);

-- 7. История статусов
create table Status_History (
	history_id int identity (1,1) primary key,
	application_id int not null references Application(application_id),
	status nvarchar(20) not null,
	changed_by int not null,
	changed_by_role nvarchar(20), -- 'manager' или 'employer'
	change_date datetime default getdate()
);