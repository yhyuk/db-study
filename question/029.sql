--029.sql

--요구사항1
select * from tblCountry;

--요구사항2 국가명, 수도명
select name, capital from tblCountry;

--요구사항3
select name as "[국가명]", capital as "[수도명]", 
 population as "[인구수]", area as "[면적]", continent "[대륙]" from tblCountry;

--요구사항4
select  '국가명: ' || name || 
        ', 수도명: ' || capital || 
        ', 인구수: ' || population as "[국가정보]" from tblCountry;

--요구사항5
select  first_name || ' ' || last_name as "[이름]",
        email || '@gmail.com' as "[이메일]",
        phone_number as "[연락처]",
        '$' || salary as "[급여]" from employees;

--요구사항6
select name, area from tblCountry where area <= 100;

--요구사항7
select name, continent from tblCountry
    where continent in ('EU','AS');

--요구사항8
select first_name || last_name as full_name, phone_number, job_id from employees
    where job_id = 'IT_PROG';

--요구사항9
select first_name || last_name as full_name, phone_number, hire_date from employees
    where last_name = 'Grant';

--요구사항10
select first_name || last_name as full_name, salary, phone_number from employees
    where manager_id = 120;

--요구사항11
select first_name || last_name as full_name, phone_number, email, department_id from employees
    where department_id in 60 or department_id in 80 or department_id in 100;
    
--요구사항12
SELECT NAME FROM tblInsa 
    WHERE BUSEO = '기획부';

--요구사항13
SELECT NAME, JIKWI, TEL FROM TBLINSA
    WHERE   CITY = '서울' AND 
            JIKWI = '부장';

--요구사항14
SELECT NAME, CITY FROM TBLINSA
    WHERE   BASICPAY + SUDANG >= 1500000 AND 
            CITY = '서울';

--요구사항15
SELECT NAME, JIKWI, SUDANG FROM TBLINSA
    WHERE   SUDANG <= 150000 AND 
            JIKWI IN ('사원','대리');

--요구사항16
SELECT NAME, JIKWI, BASICPAY FROM TBLINSA
    WHERE   BASICPAY*12 >= 20000000 AND 
            CITY = '서울' AND 
            JIKWI IN ('과장', '부장');
    
--요구사항17
SELECT NAME FROM TBLCOUNTRY
    WHERE NAME LIKE '%국';

--요구사항18
SELECT FIRST_NAME, PHONE_NUMBER FROM EMPLOYEES
    WHERE PHONE_NUMBER LIKE '515%';
    
--요구사항19
SELECT FIRST_NAME, JOB_ID FROM EMPLOYEES
    WHERE JOB_ID LIKE 'SA%';
    
--요구사항20
SELECT FIRST_NAME FROM EMPLOYEES
    WHERE   FIRST_NAME LIKE '%de%' OR 
            FIRST_NAME LIKE '%De%' OR 
            FIRST_NAME LIKE '%DE%';

--요구사항21
SELECT NAME, SSN FROM TBLINSA
    WHERE SSN LIKE '%-1%';

--요구사항22
SELECT NAME, SSN FROM TBLINSA
    WHERE SSN LIKE '%-2%';
    
--요구사항23
SELECT NAME, SSN FROM TBLINSA
    WHERE   SSN LIKE '__07%' OR 
            SSN LIKE '__08%' OR 
            SSN LIKE '__09%';
    
--요구사항24
SELECT NAME, CITY FROM TBLINSA
    WHERE   NAME LIKE '김%' AND 
            CITY IN ('서울', '인천');

--요구사항25
SELECT BUSEO, JIKWI, TEL FROM TBLINSA
    WHERE   BUSEO IN ('영업부', '총무부', '개발부') AND 
            JIKWI IN ('사원', '대리') AND 
            TEL LIKE '010%';

--요구사항26
SELECT NAME, CITY, IBSADATE FROM TBLINSA
    WHERE   CITY IN ('서울', '인천', '경기') AND
            IBSADATE BETWEEN '2008-01-01' AND '2010-12-31';

--요구사항27
SELECT FIRST_NAME, DEPARTMENT_ID FROM EMPLOYEES
    WHERE DEPARTMENT_ID IS NULL;
    
--요구사항28
SELECT DISTINCT JOB_ID FROM EMPLOYEES;

--요구사항29
SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES
    WHERE HIRE_DATE BETWEEN '2002-01-01' AND '2004-12-31';

--요구사항30
SELECT SALARY, MANAGER_ID FROM EMPLOYEES
    WHERE SALARY >= 5000;

--요구사항31
SELECT DISTINCT JIKWI FROM TBLINSA
    WHERE SSN LIKE '8%-1%';

--요구사항32
SELECT DISTINCT CITY FROM TBLINSA
    WHERE SUDANG > 200000;

--요구사항33
SELECT DISTINCT BUSEO FROM TBLINSA
    WHERE TEL IS NULL;
