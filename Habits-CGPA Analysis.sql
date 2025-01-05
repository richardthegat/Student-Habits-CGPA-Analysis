/* This program will take a look at the student data in the table, 
clean it as necessary, and make use of queries to explore relationships between
student actions and their grades*/

# Turn off safe update mode for this session
SET SQL_SAFE_UPDATES = 0;

# Rename table 
rename table student_depression_dataset to student_data;

select * from student_data;

# Drop irrelevant columns from table
alter table student_data
drop column `Have you ever had suicidal thoughts ?`,
drop column `Family History of Mental Illness`, 
drop column Depression, 
drop column `Study Satisfaction`;

 select * from student_data;

#Add a Country column
alter table student_data
add column Country VARCHAR(50) after City;

# Populate the Country column
UPDATE student_data
SET Country = 'India';

select * from student_data;

# Academic Pressure and Grades
select `Academic Pressure`,
    case 
        when `Academic Pressure` >= 4 then 'High Pressure'
        when `Academic Pressure` > 2 then 'Medium Pressure'
        else 'Low Pressure'
    end as Pressure_Level,
    avg(CGPA) AS Average_CGPA
from student_data
group by `Academic Pressure`, Pressure_Level
order by `Academic Pressure` desc;


# Amount of Sleep and Grades
select `Sleep Duration`, avg(CGPA) as Average_CGPA from student_data
group by `Sleep Duration`
order by Average_CGPA asc; 

select
    case
        when `Financial Stress` >= 4 then 'High Stress'
        when `Financial Stress` > 2 then 'Medium Stress'
        else 'Low Stress'
    end as Stress_Levels,
    avg(CGPA) as Average_CGPA
from student_data
group by  Stress_Levels
order by Average_CGPA DESC;

        
# Dietary habits
select `Dietary Habits`, avg(CGPA) as Average_CGPA from student_data
group by `Dietary Habits`
order by Average_CGPA;

# Study Hours
select `Work/Study Hours` as Study_hours , avg(CGPA) as Average_CGPA from student_data
group by Study_Hours
order by Study_Hours;

/* As the data illustrates, he most optimal grades come from high pressure environments with healthy eating habits,
low levels of financial stress, where students are getting more than 8 hours of sleep, and where said students are getting a 
moderate "not too hot, not too cold" 5 hours of studying.*/

/* Thus, looking at the data, the best way to optimize your grades are to have high expectations, eat healthy, not have fiannaces in mind,
get lots of sleep, and to study hard, but in moderation.*/

# Export updated spreadsheet to computer 
show variables like 'secure_file_priv';
select *
from student_data
into outfile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\student_data.csv'
fields terminated by ',' 
enclosed by '"' 
lines terminated by '\n';

