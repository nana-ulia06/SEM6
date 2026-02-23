use STAFF_DB;
go

create index IX_Vacancy_Status on Vacancy(status); -- статус вакансии
create index IX_App_Status on Application(status); -- статус заявки
create index IX_Employee_Email on Employee(email); -- почта нанимаемых сотрудников
create index IX_App_Vacancy on Application(vacancy_id); -- внешние ключи
create index IX_App_Employee on Application(employee_id); -- -//-

go
-- открытые вакансии
create view V_Open_Vacancies as
select v.vacancy_id, v.vacancy_title,
v.salary, v.open_date, e.company_name
from Vacancy v join Employer e on v.employer_id = e.employer_id
where v.status  = 'open';

go
-- все заявки с данными кандидата
create view V_App_Details as
select a.application_id, emp.fio as employee_name,
v.vacancy_title, a.application_date, a.status
from Application a join Employee emp on a.employee_id = emp.employee_id
join Vacancy v on a.vacancy_id = v.vacancy_id;

go
-- создание заявки - сразу добавляем в статус хистори
create trigger TR_App_Insert on Application
after insert
as
begin
	insert into Status_History(status, changed_by, changed_by_role)
	select status, employee_id, 'employee'
	from inserted;
end;

go
-- изменение статуса заявки
create trigger TR_App_Status_Update on Application
after update
as begin
	if update(status)
	begin
		insert into Status_History(status, changed_by, changed_by_role)
		select i.status, 0, 'manager'
		from inserted i;
	end;
end;

go

create procedure Apply_For_Vacancy
@vacancy_id int,
@employee_id int
as begin
	if exists (select 1 from Vacancy where vacancy_id = @vacancy_id and status = 'open')
	begin
		insert into Application(vacancy_id, employee_id, application_date)
		values (@vacancy_id, @employee_id, getdate());
	end;
end;

go

create view V_Pending_Interviews as
select i.interview_id, m.fio as manager_name,
v.vacancy_title, i.interview_date, i.result
from Interview i join Manager m on i.manager_id = m.manager_id
join Application a on i.application_id = a.application_id
join vacancy v on a.vacancy_id = v.vacancy_id
where i.result = 'pending';