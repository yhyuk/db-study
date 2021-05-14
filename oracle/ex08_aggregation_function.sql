--ex08_aggregation_function.sql

/*

    집계 함수, Aggregation Function
    1. count()
    2. sum()
    3. avg()
    4. max()
    5. min()
    
    
    1. count()
    - 결과셋의 레코드 갯수를 반환
    - number count(컬럼명)
    - null은 카운트에서 제외한다. ********
*/

--1. count 예제
select name from tblcountry;
select count(name) from tblcountry; --14개

select count(name) -- 3. 33개
from tblInsa -- 1. 60개
where city in ('서울', '경기'); -- 2. 33개

select area from tblCountry;
select count(area) from tblCountry; --14개

select population from tblCountry;
select count(population) from tblCountry; --13개 -> NULL은 제외됨

select name, name from tblCountry;
select count(name, name) from tblCountry; -- 컬럼리스트에 집계 함수와 단일 컬럼을 동시에 사용할 수 없다.
select count(name), count(area) from tblCountry; -- 이건 이용가능. 단일 캘럼 리스트가 각각 있기 때문에 상관X
select count(name, area) from tblCountry; --이건 불가능

-- tblCountry의 나라 개수는 ?
select count(name) from tblCountry;
select count(capital) from tblCountry;
select count(area) from tblCountry;
select count(population) from tblCountry;
select count(*) from tblCountry;   -- 무조건 모든 레코드 갯수가 반환된다.

select * from tblCountry;

-- 아직 안한 일의 갯수? 8개
select COUNT(*) from tblTodo where completedate is null; 

-- 한 일의 갯수? 12개
select COUNT(*) from tblTodo where COMPLETEDATE IS NOT NULL;

-- 안한 일의 갯수, 한 일의 갯수 -> 하나의 결과셋으로?
select 
    count(*) as "전체 할일 갯수",
    count(completedate) as "한 일의 갯수",
    count(*) - count(completedate) as "아직 안한 일의 갯수"
from tblTodo;


select
    count(*) as "총 직원수", --60
    count(tel) as "연락처가 있는 직원수", --57
    count(*) - count(tel) as "연락처가 없는 직원수"--3
from tblInsa;



-- tblInsa -> buseo컬럼 -> 어떤 부서들이 있나요?
-- tblInsa -> buseo컬럼 -> 부서가 몇개인가요?
select count(distinct buseo) from tblInsa;

--tblComedian 남자 몇명?, 여자 몇명?
--방법1
select * from tblComedian;
select count(*) from tblcomedian;
select count(*) from tblcomedian where gender = 'm';
select count(*) from tblcomedian where gender = 'f';

-- 전체 인원수, 남자 인숸수, 여자 인원수 -> 결과 셋
--방법2
SELECT
    COUNT(*) AS "전체 인원수",
    COUNT(CASE
        WHEN GENDER = 'm' THEN '남자'
    END) AS "남자 인원수",
    COUNT(CASE
        WHEN GENDER = 'f' THEN '여자'
    END) AS "여자 인원수 "
FROM TBLCOMEDIAN;


SELECT AVG(BASICPAY) FROM TBLINSA; --평균값 함수, 결과값:1556526

--평균 급여보다 많이 받는 직원들 명단을 가져오시오.
--ORA-00934: group function is not allowed here
--WHERE절에는 집계 함수를 사용할 수 없다. > WHERE 절은 개인에 대한 조건절(집합 정보를 가져올 수 없다.)
SELECT * FROM TBLINSA WHERE BASICPAY > AVG(BASICPAY); --ERROR
SELECT * FROM TBLINSA WHERE BASICPAY > 1556526; --27명




-- tblCountry. 아시아(AS)와 유럽(EU)에 속한 나라의 개수?? -> 7개
SELECT 
    COUNT(CASE
        WHEN CONTINENT = 'AS' THEN '아시아'
        WHEN CONTINENT = 'EU' THEN '유럽'
    END) AS "아시아/유럽"
FROM TBLCOUNTRY;
-- 인구수가 7000 ~ 20000 사이인 나라의 개수?? -> 2개
SELECT 
    COUNT(CASE
        WHEN POPULATION >= 7000 AND POPULATION <= 20000 THEN 'CHECK'
    END)
FROM TBLCOUNTRY;


-- hr.employees
-- job_id > 'IT_PROG' 중에서 급여가 5000불이 넘는 직원이 몇명? -> 2명
SELECT 
    COUNT(CASE
        WHEN JOB_ID = 'IT_PROG' AND SALARY >= 5000 THEN 'CHECK'
    END)
FROM EMPLOYEES;


-- tblInsa
-- tel. 010을 안쓰는 사람은 몇명?(연락처가 없는 사람은 제외) -> 42명
SELECT
    TEL
FROM TBLINSA;


-- city. 서울, 경기, 인천 -> 그 외의 지역 인원수? -> 18명

-- 80년대생 + 여자 직원 총 몇명? -> 9명










/*

    2. SUM()
    - NUMBER SUM(컬럼명)
    - 해당 컬럼값들의 합을 구한다.
    - 숫자형만 대상(문자형X, 날짜X)
    
*/

SELECT WEIGHT FROM TBLCOMEDIAN;
SELECT SUM(WEIGHT) FROM TBLCOMEDIAN;
SELECT SUM(FIRST) FROM TBLCOMEDIAN; --ERROR: 문자열 X

--BASICPAY합과 SUDANG합을 구하려면??
SELECT
    --방법1
    SUM(BASICPAY) + SUM(SUDANG),
    --방법2
    SUM(BASICPAY + SUDANG)
FROM TBLINSA;


/*

    3. AVG()
    - NUMBER AVG(컬럼명)
    - 해당 컬럼값들의 평균값을 반환한다.
    - 숫자형만 가능하다.
    - 해당 컬럼이 NULL을 가진 항목은 제외한다.

*/

--BASICPAY의 평균값 구하기?
SELECT
    --방법1
    SUM(BASICPAY)/COUNT(*), 
    --방법2
    AVG(BASICPAY)
FROM TBLINSA;


--평균 인구수?
SELECT 
    SUM(POPULATION)/ COUNT(*), --14475
    AVG(POPULATION), -- 15588
    
    --왜 값이 틀릴까?
    COUNT(*), -- 14
    COUNT(POPULATION) -- 13
FROM TBLCOUNTRY;

--평균값을 구할때 AVG()를 쓰는 방법과, SUM()과 COUNT(*) 쓰는 방법이 있다.
--AVG() 이용시 주의사항~
--회사 성과급 지급
--10명 팀원 -> 7명 참여 프로젝트 수익 발생, 3명은 관련 없음
--1. 균등 지급 -> 수익 / 모든 팀원수 = SUM() / COUNT(*)
--2. 차등 지급 -> 수익 / 참여 팀원수 = SUM() / COUNT(참여 팀원수) = AVG()


/*

    4. MAX()
    - OBJECT MAX(컬럼명) : 최댓값 반환
    - 숫자형,문자형,날짜형
    
    5. MIN()
    - OBJECT MIN(컬럼명) : 최솟값 반환
    - 숫자형,문자형,날짜형


*/

SELECT MAX(BASICPAY), MIN(BASICPAY) FROM TBLINSA; --숫자형
SELECT MAX(NAME), MIN(NAME) FROM TBLINSA; --문자형(가나다..순서 별로 쓰이진 않음)
SELECT MAX(IBSADATE), MIN(IBSADATE) FROM TBLINSA; --날짜형(최근날짜, 오래된날짜, 많이 쓰임)


--sum()
--1. 유럽과 아프리카에 속한 나라의 인구 수 합? tblCountry > 14,198
SELECT 
    SUM(CASE
        WHEN CONTINENT = 'EU' THEN POPULATION
        WHEN CONTINENT = 'AF' THEN POPULATION
    END)
FROM TBLCOUNTRY;

--2. 매니저(108)이 관리하고 있는 직원들의 급여 총합? hr.employees > 39,600
SELECT 
    SUM(CASE
        WHEN MANAGER_ID = 108 THEN SALARY
    END)
FROM EMPLOYEES;

--3. 직업(ST_CLERK, SH_CLERK)을 가지는 직원들의 급여 합? hr.employees > 120,000
SELECT
    SUM(CASE
        WHEN JOB_ID = 'ST_CLERK' THEN SALARY
        WHEN JOB_ID = 'SH_CLERK' THEN SALARY
    END)
FROM EMPLOYEES;

--4. 서울에 있는 직원들의 급여 합(급여 + 수당)? tblInsa > 33,812,400
SELECT
    SUM(CASE
        WHEN CITY = '서울' THEN BASICPAY + SUDANG
    END)
FROM TBLINSA;

--5. 장급(부장+과장)들의 급여 합? tblInsa > 36,289,000
SELECT
    SUM(CASE
        WHEN JIKWI = '부장' THEN BASICPAY
        WHEN JIKWI = '과장' THEN BASICPAY
    END)
FROM TBLINSA;


--avg()
--1. 아시아에 속한 국가의 평균 인구수? tblCountry > 39,165
SELECT
    AVG(CASE
        WHEN CONTINENT = 'AS' THEN POPULATION
    END)
FROM TBLCOUNTRY;

--2. 이름(first_name)에 'AN'이 포함된 직원들의 평균 급여?(대소문자 구분없이) hr.employees > 6,270.4
SELECT
    AVG(CASE
        WHEN FIRST_NAME LIKE '%AN%' THEN SALARY
        WHEN FIRST_NAME LIKE '%An%' THEN SALARY
        WHEN FIRST_NAME LIKE '%an%' THEN SALARY
    END)
FROM EMPLOYEES;

--3. 장급(부장+과장)의 평균 급여? tblInsa > 2,419,266.66
SELECT
    AVG(CASE
        WHEN JIKWI = '부장' THEN BASICPAY
        WHEN JIKWI = '과장' THEN BASICPAY
    END)
FROM TBLINSA;

--4. 사원급(대리+사원)의 평균 급여? tblInsa > 1,268,946.66
SELECT
    AVG(CASE
        WHEN JIKWI = '대리' THEN BASICPAY
        WHEN JIKWI = '사원' THEN BASICPAY
    END)
FROM TBLINSA;

--5. 장급(부장,과장)의 평균 급여와 사원급(대리,사원)의 평균 급여의 차액? tblInsa > 1,150,320
SELECT
    AVG(CASE
        WHEN JIKWI = '부장' THEN BASICPAY
        WHEN JIKWI = '과장' THEN BASICPAY
    END) -
    AVG(CASE
        WHEN JIKWI = '대리' THEN BASICPAY
        WHEN JIKWI = '사원' THEN BASICPAY
    END)
FROM TBLINSA;

--max(),min()
--1. 면적이 가장 넓은 나라의 면적은? tblCountry > 959
--2. 급여(급여+수당)가 가장 적은 직원은 총 얼마를 받고 있는가? tblInsa > 988,000


