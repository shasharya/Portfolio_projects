/*Screen1*/
/*Included Patient table*/

insert into Patient ( Patient_Number, Patient_First_Name, Patient_Last_Name, Age, Address, City, State, Country)

values ( '7896547848', 'Mr.Mangala', 'Girish', '24', '#3457/1 7th cross, Kutti street', 'Honolulu', 'Hawai', 'USA');

/*Using UPDATE query on the same screen1 to update the address, city and state*/

update Patient
set Address='#3455/5 York Street', City= 'Houston', State='Texas'
where Patient_Number='7896547848';

/*Screen2*/
/*Included Department table*/

select * from Department
where Department_Number='Anaesthesiology1012';

select * from Department
where Department_Number='BariatricSurgery1029';

select * from Department
where Department_Number='Cardiology6730';

select * from Department
where Department_Number='Dermatolgy3621';

select * from Department
where Department_Number='ENT4675';

select * from Department
where Department_Number='Gastrology3784';

select * from Department
where Department_Number='General Medicine6759';

select * from Department
where Department_Number='Haemotology6579';

select * from Department
where Department_Number='J9891';

select * from Department
where Department_Number='Neurology6749';

/*Screen3*/
/*Included Operation table*/

select * from Operation
where Operation_Name='Mastectomy';


/*Screen4*/
/*Included Doctor, Nurse and Degree type table*/

select * from Doctor a1 inner join Degree b1 on a1.Doctor_Number=b1.Doctor_Number where a1.Doctor_Number='J7891782872';

select * from Nurse
where Nurse_Last_Name='Regadda';

/*Screen5*/
/*Included Claim table*/

insert into Claim( Patient_Number, Company_Name, Claim_Number, Diagnosis, Operation_Name, Amount)
values ( '7896547848', 'Local Initiative Health Authority', 'MIA2892891', 'INGUINAL AND FEMORAL HERNIA PROCEDURES WITHOUT CC/MCC', 'Mastectomy', '8100');

/*Screen6*/
/*Included Insurance Company table*/

select * from Insurance_Company
where Company_Name='Local Initiative Health Authority';