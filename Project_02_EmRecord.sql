select * from EmRecord.enagement;
select * from EmRecord.recruit;
select * from EmRecord.training;
select * from EmRecord.info;
-- Q1: count how many applicants got rejected, offered, interviewing or in review:
select Status, COUNT(`Applicant ID`) as Counts
from EmRecord.recruit
group by Status;

-- Q2: count applicants of each education level:
select `Education Level`, COUNT(`Applicant ID`) as Counts
from EmRecord.recruit
group by `Education Level`;

-- Q3: display applicants with years of experience larger than 9, and have master or PhD degree:
select `Applicant ID` as ID, CONCAT(`First Name`,' ',`Last Name`) as 'Name', `Education Level`
from EmRecord.recruit
where `Years of Experience` > 9 and (`Education Level` = 'Master\'s Degree' or `Education Level` = 'PhD')
order by `Education Level`;

-- Q5: display applicants who got rejected, and have more than 10 years of experience:
select `Applicant ID`, CONCAT(`First Name`,' ',`Last Name`) as 'Name', Status, `Years of Experience`
from EmRecord.recruit
where Status = 'Rejected' and `Years of Experience` >= 10;

-- Q6: display the list of trainers, and their average training cost:
select Trainer, ROUND(AVG(`Training Cost`),2) as 'Average Cost'
from EmRecord.training
group by Trainer
order by Trainer;

-- Q7: display employees who fail their training and have work-life balance score lower than 3:
select t.`Employee ID` as ID, e.`Work-Life Balance Score` as "Work_Life Balance Score < 3", concat(i.FirstName,' ',i.LastName) as Name
from EmRecord.training t JOIN EmRecord.enagement e
on t.`Employee ID` = e.`Employee ID`
join EmRecord.info i on i.EmpID = e.`Employee ID`
where e.`Work-Life Balance Score` < 3 and t.`Training Outcome` = 'Failed';

-- Q8: display employee who is trainer, and their supervisor
select EmpID, FullName, Supervisor
from 
(select EmpID, concat(FirstName,' ',LastName) as FullName, Supervisor
from EmRecord.info) i join EmRecord.training t
on i.FullName = t.Trainer;

-- Q9: display active and full-time employees with their title, email and start date
select EmpID, concat(FirstName,' ',LastName) as FullName, Title, ADEmail, StartDate
from EmRecord.info
where EmployeeStatus = 'Active' and EmployeeClassificationType = 'Full-time';

