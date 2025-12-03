set serveroutput on

create or replace trigger insert_data
before insert on students
for each row
    begin
        if :new.gpa is null then
            :new.gpa := 0;
        end if;
    end;
/

select * from students;

insert into students (student_id, student_name, dept_id, fee_paid) values (2, 'Bob', 2, 20000);
alter table students add (h_pay int ,y_pay int);

create or replace trigger update_salary
before update on students
for each row
    begin
        :new.y_pay := :new.h_pay * 1920;
    end;
/

update students set h_pay = 250 where student_id = 2;

create or replace trigger prevent_record
before delete on students
for each row
    begin
        if :old.student_name = 'Ali' then
            raise_application_error(-20001, 'Cannot delete record: student name is Ali!');
        end if;
    end;
/

delete from students where student_name = 'Ali';

create table student_logs (
    student_id number,
    student_name varchar(50),
    inserted_by varchar(50),
    inserted_on date
);
  
create or replace trigger after_ins
after insert on students
for each row
    begin
        insert into student_logs values (:new.student_id, :new.student_name, sys_context('userenv', 'session_user'), sysdate);
    end;
/

insert into students values(8, 'Alice', 1, 2.8, 3000, 5, 500);
        
select * from student_logs;

create table schema_audit (
    ddl_date date,
    ddl_user varchar(50),
    object_created varchar(20),
    object_name varchar(20),
    ddl_operation varchar(20)
);

select * from schema_audit;

create or replace trigger hr_audit_tr
after ddl on schema
begin
    insert into schema_audit values (sysdate, sys_context('userenv', 'current_user'), ora_dict_obj_type, ora_dict_obj_name, ora_sysevent);
end;
/

create table ddl2_check (
    h_name varchar(20)
);

drop table ddl2_check;
        
        