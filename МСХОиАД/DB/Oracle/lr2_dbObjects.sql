-- indexes
create index IX_Vacancy_Status on Vacancy(status);
create index IX_App_Status on Application(status);
create index IX_Employee_Email on Employee(email);
create index IX_App_Vacancy on Application(vacancy_id);
create index IX_App_Employee on Application(employee_id);

-- views
create or replace view V_Open_Vacancies as
select v.vacancy_id, v.vacancy_title, v.salary,
v.open_date, e.company_name
from Vacancy v join Employer e on v.employer_id = e.employer_id
where v.status = 'open';

create or replace view V_App_Detail as
select a.application_id, emp.fio as employee_name,
v.vacancy_title, a.application_date, a.status
from Application a join Employee emp on a.employee_id = emp.employee_id
join Vacancy v on a.vacancy_id = v.vacancy_id;

create or replace view V_Pending_Interviews as
select i.interview_id, m.fio as manager_name,
v.vacancy_title, i.interview_date, i.result
from Interview i join Manager m on i.manager_id = m.manager_id
join Application a on i.application_id = a.application_id
join Vacancy v on a.vacancy_id = v.vacancy_id
where i.result = 'pending';

-- triggers
create or replace trigger TR_App_Insert
after insert on Application
for each row
begin
    insert into Status_History(status, changed_by, changed_by_role)
    values (:new.status, :new.employee_id, 'employee');
end;
/

create or replace trigger TR_App_Status_Update
after update of status on Application
for each row
begin
    insert into Status_History(status, changed_by, changed_by_role)
    values (:new.status, 0, 'manager');
end;
/

-- procedure
create or replace procedure Apply_For_Vacancy(
    p_vacancy_id in number,
    p_employee_id in number
) as v_count number;
begin
    select count(*) into v_count from Vacancy
    where vacancy_id = p_vacancy_id and status = 'open';
    
    if v_count > 0 then
        insert into Application(vacancy_id, employee_id, application_date)
        values (p_vacancy_id, p_employee_id, sysdate);
    end if;
end;
/