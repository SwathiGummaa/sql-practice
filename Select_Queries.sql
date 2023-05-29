SELECT first_name, last_name, gender
FROM patients
where gender = 'M';

SELECT first_name, last_name
FROM patients
where allergies is null;

SELECT first_name
FROM patients
where first_name like 'c%';

SELECT first_name, last_name
FROM patients
where weight between 100 and 120;

update patients
set allergies='NKA'
where allergies is null;

select concat(first_name, ' ',last_name) as full_name
from patients;

select patients.first_name, patients.last_name, province_names.province_name
from patients
inner join province_names
on patients.province_id= province_names.province_id;

select count(*) from patients
where year(birth_date) =2010;

select first_name, last_name, max(height)
from patients limit 1;

select *
from patients
where patient_id in (1,45,534,879,1000);

select count(*)
from admissions;

select *
from admissions
where admission_date = discharge_date;

select count(*), patient_id
from admissions
where patient_id= 579;

select distinct city
from patients
where province_id= 'NS';

select first_name,last_name,birth_date
from patients
where height > 160 and weight > 70;

select first_name,last_name, allergies
from patients
where city = 'Hamilton' and allergies is not null;

SELECT DISTINCT city
FROM patients
WHERE city LIKE '[AEIOU]%' OR city LIKE '[aeiou]%'
ORDER BY city ASC;

select distinct city
from patients
where
  city like 'a%'
  or city like 'e%'
  or city like 'i%'
  or city like 'o%'
  or city like 'u%'
order by city

SELECT distinct year(birth_date) as birth_year 
FROM patients
order by birth_year;

SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1;

SELECT patient_id, first_name
FROM patients
where first_name like 's%s' and length(first_name)>= 6;

SELECT patients.patient_id, patients.first_name, patients.last_name
FROM patients
inner JOIN admissions
on patients.patient_id= admissions.patient_id
where admissions.diagnosis= 'Dementia';

select first_name
from patients
order by len(first_name), first_name asc;

SELECT
    SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) AS male_count,
    SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) AS female_count
FROM
    patients;


SELECT 
  (SELECT count(*) FROM patients WHERE gender='M') AS male_count, 
  (SELECT count(*) FROM patients WHERE gender='F') AS female_count;

SELECT 
  SUM(Gender = 'M') as male_count, 
  SUM(Gender = 'F') AS female_count
FROM patients

select 
  sum(case when gender = 'M' then 1 end) as male_count,
  sum(case when gender = 'F' then 1 end) as female_count 
from patients;

select first_name, last_name, allergies
from patients
where allergies = 'Penicillin' or allergies = 'Morphine'
order by allergies, first_name, last_name;

select patient_id, diagnosis
from admissions
group by patient_id, diagnosis
having count(*)>1;

SELECT city, COUNT(*) AS total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC, city ASC;

SELECT first_name, last_name, 'Patient' role FROM patients
    union all
select first_name, last_name, 'Doctor' role from doctors;

SELECT
  allergies,
  COUNT(*) AS total_diagnosis
FROM patients
WHERE
  allergies IS NOT NULL
GROUP BY allergies
ORDER BY total_diagnosis DESC

select first_name, last_name, birth_date
from patients
where year(birth_date) like '197_'
order by birth_date asc;

SELECT
  CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS new_name_format
FROM patients
ORDER BY first_name DESC;

SELECT
  province_id,
  SUM(height) AS sum_height
FROM patients
GROUP BY province_id
HAVING sum_height >= 7000

SELECT
  (MAX(weight) - MIN(weight)) AS weight_delta
FROM patients
WHERE last_name = 'Maroni';

SELECT
  DAY(admission_date) AS day_number,
  COUNT(*) AS number_of_admissions
FROM admissions
GROUP BY day_number
ORDER BY number_of_admissions DESC

SELECT *
FROM admissions
WHERE patient_id = 542
GROUP BY patient_id
HAVING
  admission_date = MAX(admission_date);


SELECT *
FROM admissions
WHERE
  patient_id = '542'
  AND admission_date = (
    SELECT MAX(admission_date)
    FROM admissions
    WHERE patient_id = '542'
  )

SELECT *
FROM admissions
WHERE patient_id = 542
ORDER BY admission_date DESC
LIMIT 1

SELECT *
FROM admissions
GROUP BY patient_id
HAVING
  patient_id = 542
  AND MAX(admission_date)

select patient_id, attending_doctor_id, diagnosis
from admissions
WHERE (patient_id % 2 <> 0 AND attending_doctor_id IN (1, 5, 19))
    OR (attending_doctor_id LIKE '%2%' AND LENGTH(patient_id) = 3);

SELECT
  first_name,
  last_name,
  count(*) as admissions_total
from admissions a
  join doctors ph on ph.doctor_id = a.attending_doctor_id
group by attending_doctor_id

select doctor_id, concat(first_name,' ',last_name) as full_name, min(admission_date) as last_adm_date, max(admission_date) as first_adm_date 
from admissions
join doctors
on doctors.doctor_id= admissions.attending_doctor_id
group by doctor_id;

