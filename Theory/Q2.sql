-- Q2 Part 1
create table Members (
    MemberID int primary key, --Constraint 1 PK
    MemName varchar(100) not null, --Constraint 2 Name Cant Be Null
    Email varchar(100) unique not null, --Constraint 3 Unique Emails
    JoinDate date default sysdate -- Constraint 4 DEFAULT
);

create table Books (
    BookID int primary key, -- PK
    Title varchar(200) not null, -- Cannot be NULL
    Author varchar(100) not null,
    CopiesAvailable int not null check(CopiesAvailable >= 0) --Constraint 5 Cannot be negative
);

create table IssuedBooks (
    IssueID int primary key, -- PK
    MemberID int not null, -- FK to Members
    BookID int not null, -- FK to Books
    IssueDate date default CURRENT_DATE, -- Default = current date
    ReturnDate date,
    constraint fk_member foreign key (MemberID) references Members(MemberID), -- Constraint 6 FK
    constraint fk_book foreign key (BookID) references Books(BookID) -- Constraint 6 FK
);


-- Q2 Part 3
-- Part a
insert into Members values (1, 'Alice Johnson', 'alice@example.com');
insert into Members values (2, 'Bob Smith', 'bob@example.com');
insert into Members values (3, 'Charlie Brown', 'charlie@example.com');

insert into Books values (101, 'Database Systems', 'Elmasri', 5);
insert into Books values (102, 'Learning SQL', 'Alan Beaulieu', 3);
insert into Books values (103, 'Clean Code', 'Robert C. Martin', 2);

-- Part b
insert into IssuedBooks (IssueID, MemberID, BookID) values (1001, 1, 101);
update books set CopiesAvailable = CopiesAvailable - 1 where BookID = 101 and CopiesAvailable > 0;

-- Part c
select M.MemName, B.Title, I.IssueDate from Members M join IssuedBooks I on M.MemberID = I.MemberID join Books B on I.BookID = B.BookID;


-- Q2 Part 4
-- Part a
insert into Members values (1, 'ABCD', 'wjdh@email.com'); -- 1 Already Exists (Above Queries Added It)

-- Part b
insert into IssuedBooks (IssueID, MemberID, BookID) values (2000, 2, 999); -- 999 BookID Doesnt Not Exist in Books.

-- Part c
insert into Books (BookID, Title, Author, CopiesAvailable) values (200, 'Faulty Book', 'Unknown Author', -5); -- The Check(>=0) wont allow neg values;


-- Q2 Part 6
-- Part a
select * from Members where MemberID not in (select distinct MemberID from IssuedBooks);

-- Part b
select BookID from Books where CopiesAvailable = (select max(CopiesAvailable) from Books);

-- Part c
select MemName from Members where MemberID = (select MemberID from (select MemberID from IssuedBooks group by MemberID order by count(*) desc) where rownum=1);

-- Part d
select BookID from Books where BookID not in (select distinct BookID from IssuedBooks);

-- Part e
select MemName, MemberID from Members where MemberID in (select MemberID from IssuedBooks where ReturnDate = null and IssueDate < sysdate - INTERVAL '30' day);


-- Q3
create table Patient (
    Patient_ID int primary key,
    Name varchar(100) not null,
    Gender char(1) check(Gender in ('M', 'F')),
    DOB date,
    Email varchar(150) unique,
    Phone varchar(20),
    Address varchar(255),
    Username varchar(50),
    Password varchar(50) 
);

create table Doctor (
    Doctor_ID int primary key,
    Name varchar(100) not null,
    Specialization varchar(100),
    Username varchar(50),
    Password varchar(50)
);

create table Appointment (
    Appointment_ID int primary key,
    Appointment_Date date not null,
    Appointment_Time time not null,
    Status varchar(20),
    Clinic_Number varchar(11),
    Patient_ID int,
    Doctor_ID int,
    constraint fk_patient foreign key (Patient_ID) references Patient(Patient_ID),
    constraint fk_doctor foreign key (Doctor_ID) references Doctor(Doctor_ID)
);

create table Prescription (
    Prescription_ID int primary key,
    Date date not null,
    Doctor_Advice varchar(500),
    Followup_Required char(1) check(Followup_Required in ('Y', 'N')),
    Patient_ID int,
    Doctor_ID int,
    constraint fk_prescription_patient foreign key (Patient_ID) references Patient(Patient_ID),
    constraint fk_prescription_doctor foreign key (Doctor_ID) references Doctor(Doctor_ID)
);

create table Invoice (
    Invoice_ID int primary key,
    Invoice_Date date not null,
    Amount int,
    Payment_Status varchar(20) check(Payment_Status in ('PAID','UNPAID','PENDING','REFUNDED')),
    Payment_Method varchar(50),
    Patient_ID int,
    constraint fk_invoice_patient foreign key (Patient_ID) references Patient(Patient_ID)
);

create table Tests (
    Test_ID int primary key,
    Blood_Test char(1) check(Blood_Test in ('Y', 'N')),
    X_Ray char(1) check(X_Ray in ('Y', 'N')),
    MRI char(1) check(MRI in ('Y', 'N')),
    CT_Scan char(1) check(CT_Scan in ('Y', 'N')),
    Patient_ID int,
    Doctor_ID int,
    constraint fk_prescription_patient foreign key (Patient_ID) references Patient(Patient_ID),
    constraint fk_prescription_doctor foreign key (Doctor_ID) references Doctor(Doctor_ID)
);

-- Q3 DML Queries
-- Part a
update Patient set Phone = '03001234567', Email = 'newemail@example.com' where Patient_ID = 101;

-- Part b
update Invoice set Payment_Status = 'PAID' where Invoice_ID = 200;

-- Part c
delete from Appointment where Status = 'CANCELLED';

-- Part d
delete from Invoice where Payment_Status = 'REFUNDED' and Invoice_ID = 120;

-- Part e
select * from Appointment where Status = 'BOOKED';

-- Part f
select * from Invoice where Payment_Status = 'UNPAID';

-- Part g
select * from Tests where Blood_Test = 'Y';

-- Part h
select * from Prescription Date = '2025-09-02';

-- Q3 Advance SQL
-- Part a
select p.Patient_ID, p.Name, d.Name from Patient p join Appointment a on p.Patient_ID = a.Patient_ID join Doctor d on a.Doctor_ID = d.Doctor_ID where a.Status = 'Booked';

-- Part b
select T.*, p.Name, d.Name from Patient p join Tests T on p.Patient_ID = T.Patient_ID join Doctor d on T.Doctor_ID = d.Doctor_ID;

-- Part c
select pr.Prescription_ID, pr.Doctor_Advice from Prescription pr join Patient p on pr.Patient_ID = p.Patient_ID where p.Name = 'Ali Khan';

-- Part d
select pr.Prescription_ID, pr.Doctor_Advice, pr.Followup_Required, d.Name, p.Name from Prescription pr join Doctor d on pr.Doctor_ID = d.Doctor_ID join Patient p on pr.Patient_ID = p.Patient_ID where pr.Followup_Required = 'Y';