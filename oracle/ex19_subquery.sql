--ex19_subquery.sql

/*

    메인쿼리, Main Query
    - 하나의 SELECT(INSERT, UPDATE, DELETE)로만 구성된 쿼리
    
    서브쿼리, Sub Query
    - 하나의 문장에 2개 이상의 SELECT를 추가해서 구성된 쿼리
    - 하나의 쿼리안에 또다른 쿼리가 들어있는 형태
    - 삽입 위치: SELECT절, FROM절, WHERE절, ORDER BY절 등..
    
    - SELECT + SELECT x N
    - INSERT + SELECT x N
    - UPDATE + SELECT x N
    - DELETE + SELECT x N

*/

--TBLCOUNTRY. 인구수가 가장 많은 나라의 인구수는? -> 그 나라?
SELECT MAX(POPULATION) FROM TBLCOUNTRY;
SELECT NAME FROM TBLCOUNTRY WHERE POPULATION = 120660;
SELECT NAME FROM TBLCOUNTRY WHERE POPULATION = MAX(POPULATION); --ORA-00934: group function is not allowed here
--오른쪽이 메인쿼리, 왼쪽 괄호 안에있는 것이 서브쿼리
SELECT NAME FROM TBLCOUNTRY WHERE POPULATION = (SELECT MAX(POPULATION) FROM TBLCOUNTRY);

-- TBLINSA. 급여가 가장 많은 사람의 이름?
SELECT MAX(BASICPAY) FROM TBLINSA;
SELECT NAME FROM TBLINSA WHERE BASICPAY = 2650000;
-- 메인쿼리                               (서브쿼리)
SELECT NAME FROM TBLINSA WHERE BASICPAY = (SELECT MAX(BASICPAY) FROM TBLINSA);

-- TBLINSA, 평균 급여보다 많이 받는 직원들?
SELECT AVG(BASICPAY) FROM TBLINSA; --1556526
SELECT * FROM TBLINSA WHERE BASICPAY > 1556526;
-- 메인쿼리                            (서브쿼리)
SELECT * FROM TBLINSA WHERE BASICPAY > (SELECT AVG(BASICPAY) FROM TBLINSA);

-- TBLINSA. '홍길동'과 같은 부서에 근무하는 사람들?
SELECT BUSEO FROM TBLINSA WHERE NAME = '홍길동';
SELECT * FROM TBLINSA WHERE BUSEO = '기획부';
SELECT * FROM TBLINSA WHERE BUSEO = (SELECT BUSEO FROM TBLINSA WHERE NAME = '홍길동') 
                                        AND NAME <> '홍길동';
/*
     서브쿼리의 용도
     1. 조건절 비교값으로 사용
        A. 반환값이 1행 1열 > 단일값, 값 1개 > 스칼라 쿼리(1행 1열) > 연산자 이용
        B. 반환값이 N행 1열 > 다중값, 값 N개 > IN 사용(열거형 비교)
        C. 반환값이 1행 N열 > 복합값, 값 4RO > 연산자 사용 (N:N)
        D. 반환값이 N행 N열 >     B + C      > B와 C의 방식을 혼합해서 아용
*/

-- 1-A 반환값이 1행 1열
SELECT 
    *
FROM TBLINSA
    WHERE BASICPAY = (SELECT MAX(BASICPAY) FROM TBLINSA);

-- 1-B 반환값이 N행 1열
-- 급여가 260만원 이상 받는 사람들이 근무하는 부서의 명단?
SELECT
    *
FROM TBLINSA
    WHERE BUSEO IN (SELECT BUSEO FROM TBLINSA WHERE BASICPAY >= 2600000);
    --WHERE BUSEO IN ('기획부', '총무부')

-- 기획부 대리와 같은 지역에 사는 사람들?
SELECT CITY FROM TBLINSA WHERE BUSEO = '기획부' AND JIKWI = '대리';
SELECT * FROM TBLINSA WHERE CITY IN ('서울', '인천', '전남');

SELECT * FROM TBLINSA WHERE CITY IN (SELECT CITY FROM TBLINSA WHERE BUSEO = '기획부' AND JIKWI = '대리');


-- 1-C
-- '홍길동'이 사는 지역과 같은 지역에 살고, 같은 직위를 가지는 직원?
SELECT CITY,JIKWI FROM TBLINSA WHERE NAME = '홍길동'; -- 서울, 부장
SELECT * FROM TBLINSA WHERE CITY = '서울' AND JIKWI = '부장 ';
SELECT * FROM TBLINSA WHERE (CITY, JIKWI;
SLECET * FROM TBLINSA WHERE (CITY, JIKWI) = (SELECT SITY, JIKWI FROM WHERE NAME = '홍길동');

-- 2:2 -> N:N 비교
SLECET * FROM TBLINSA WHERE (CITY, JIKWI) = (SELECT SITY, JIKWI FROM WHERE NAME = '홍길동');


-- 1-D
-- 급여를 2600000원 이상 받는 직원의 부서와 사는곳이 동일한 직원들?
select buseo, city from tblInsa where basicpay >= 2600000;

select * from tblInsa
    where (buseo, city) in (select buseo, city from tblInsa where basicpay >= 2600000);


/*
    서브쿼리의 용도
    1. 조건절 비교값으로 사용
        A. 반환값이 1행 1열 > 단일값, 값 1개 > 스칼라 쿼리(1행 1열) > 연산자 이용
        B. 반환값이 N행 1열 > 다중값, 값 N개 > IN 사용(열거형 비교)
        C. 반환값이 1행 N열 > 복합값, 값 4RO > 연산자 사용 (N:N)
        D. 반환값이 N행 N열 >     B + C      > B와 C의 방식을 혼합해서 사용
    
    2. 컬럼리스트에서 사용
        A. 반환값이 1행 1열 > 스칼라 쿼리
            1) 정적 쿼리 (모든 행에 동일한 값을 반환)
            2) 상관 서브 쿼리 (서브 쿼리의 값과 바깥쪽 메인 쿼리의 값을 연계시켜 값을 반환) ******
*/

SELECT 
    NAME,
    BASICPAY,
    AVG(BASICPAY)
FROM TBLINSA;

SELECT
    NAME,
    BASICPAY,
    --(SELECT 100 FROM DUAL),
    --100,
    (SELECT ROUND(AVG(BASICPAY)) FROM TBLINSA)
FROM TBLINSA;

SELECT
    NAME,
    BASICPAY,
    (SELECT ROUND(AVG(BASICPAY)) FROM TBLINSA) AS 평균급여,
    (SELECT JIKWI FROM TBLINSA WHERE NAME = '홍길동') --나머지 컬럼과 관계있는 서브쿼리만 사용
FROM TBLINSA;


SELECT * FROM TBLMEN;
SELECT * FROM TBLWOMEN;

-- 정적쿼리
-- 남자 이름,키 / 여자 이름,키 -> 홍길동
SELECT
    NAME AS 남자이름,
    HEIGHT AS 남자키,
    COUPLE AS 여자이름,
    -- 여자친구의 키??
    (SELECT HEIGHT FROM TBLWOMEN WHERE NAME = '장도연') AS 여자키
FROM TBLMEN
    WHERE NAME = '홍길동';
    
-- 상관서브쿼리    
-- 남자 이름,키 / 여자 이름,키 -> 모든 커플
SELECT
    NAME AS 남자이름,
    HEIGHT AS 남자키,
    COUPLE AS 여자이름,
    -- 여자친구의 키??
    (SELECT HEIGHT FROM TBLWOMEN WHERE NAME = TBLMEN.COUPLE) AS 여자키
FROM TBLMEN
    WHERE COUPLE IS NOT NULL; -- 커플



SELECT * FROM EMPLOYEES; --직원
SELECT * FROM DEPARTMENTS; --부서


-- 직원의 이름과 부서명을 가져오시오.
SELECT 
    FIRST_NAME || ' ' || LAST_NAME AS NAME,
    --DEPARTMENT_ID,
    (SELECT DEPARTMENT_NAME FROM DEPARTMENTS WHERE DEPARTMENT_ID = EMPLOYEES.DEPARTMENT_ID) AS DEPARTMENT
FROM EMPLOYEES;


-- 서브 쿼리
--10. tblAddressBook. 가장 많은 사람들이 가지고 있는 직업은 주로 어느 지역 태생(hometown)인가?

SELECT
    DISTINCT HOMETOWN
FROM TBLADDRESSBOOK
    WHERE JOB = (SELECT JOB FROM TBLADDRESSBOOK GROUP BY JOB HAVING COUNT(*) = 
                (SELECT MAX(COUNT(*)) FROM TBLADDRESSBOOK GROUP BY JOB));

--13. tblAddressBook. 이메일 도메인들 중 평균 아이디 길이가 가장 긴 이메일 사이트의 도메인은 무엇인가?

--14. tblAddressBook. 평균 나이가 가장 많은 출신(hometown)들이 가지고 있는 직업 중 가장 많은 직업은?

--16. tblAddressBook. 남자 평균 나이보다 나이가 많은 서울 태생 + 직업을 가지고 있는 사람들을 가져오시오.

--19. tblAddressBook. 가장 나이가 많으면서 가장 몸무게가 많이 나가는 사람과 같은 직업을 가지는 사람들을 가져오시오.

--20. tblAddressBook. '건물주'와 '건물주자제분'들의 거주지가 서울과 지방의 비율이 어떻게 되느냐?

--21. tblAddressBook.  동명이인이 여러명 있습니다. 이 중 가장 인원수가 많은 동명이인(모든 이도윤)의 명단을 가져오시오.

--22. tblAddressBook. 가장 사람이 많은 직업의(332명) 세대별 비율을 구하시오.
--    [10대]       [20대]       [30대]       [40대]
--    8.7%        30.7%        28.3%        32.2%

--38. employees. 급여를 12000 이상 받는 사원과 같은 부서에서 근무하는 사원들의 이름, 급여, 부서번호를 가져오시오.
SELECT 
    FIRST_NAME || ' ' || LAST_NAME AS NAME,
    SALARY,
    DEPARTMENT_ID
FROM EMPLOYEES
    WHERE DEPARTMENT_ID IN (SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES WHERE SALARY >= 12000);

--40. employees, departments. first_name이 'Jonathon'인 직원과 같은 부서에 근무하는 직원들 정보를 가져오시오.

SELECT 
    *
FROM EMPLOYEES
    WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Jonathon');

--61. employees. 2001~2003년사이에 입사한 사원의 이름(first_name), 입사일(hire_date), 관리자사번 (employee_id), 관리자 이름(fist_name)을 가져오시오. 단, 관리자가 없는 사원정보도 결과에 포함시켜 가져오시오.

SELECT * FROM EMPLOYEES;








--63. employees. last_name 에 'u' 가 포함되는 사원들과 동일 부서에 근무하는 사원들의 사번 및 last_name을 가져오시오.