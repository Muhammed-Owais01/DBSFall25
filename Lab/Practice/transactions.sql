set transaction name 'sal_update';
update employees set salary = 7000 where last_name = 'Banda';
savepoint after_banda_sal;
update employees set salary = 12000 where last_name = 'Greene';
savepoint after_greene_sal;
rollback to savepoint after_banda_sal;
update employees set salary = 11000 where last_name = 'Greene';
rollback;
set transaction name 'sal_update2';
update employees set salary = 7050 where last_name = 'Banda';
update employees set salary = 10950 where last_name = 'Greene';
commit;

create table customers (
    customer_id number primary key,
    customer_name varchar(20),
    balance number
);

create table orders (
    order_id number primary key,
    customer_id number,
    order_amount number,
    order_status varchar(20),
    foreign key (customer_id) references customers(customer_id)
);

set serveroutput on;

set transaction name 'customer order transaction';
insert into customers values (101, 'Sohail Ahmed', 0);
savepoint customer_added;

insert into orders values (1001, 101, 150, 'Pending');
savepoint order_added;

declare
    insufficient_balance exception;
    customer_balance number;
begin
    select balance into customer_balance from customers where customer_id = 101;
    if customer_balance <= 0 then
        raise insufficient_balance;
    end if;
    commit;
exception
    when insufficient_balance then
        rollback to savepoint customer_added;
        dbms_output.put_line('Transaction rolled back due to insufficient balance');
    when others then
        rollback;
        dbms_output.put_line('Transaction failed and was rolled back.');
end;
/
