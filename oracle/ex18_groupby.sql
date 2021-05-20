--ex18_groupby.sql

/*
   
    GROUP BY 절
    - 레코드들을 특정 컬럼값(1개 or N개)에 맞춰서 그룹을 나누는 역할
    - 그룹을 왜 나누는지?
        -> 각각의 나눠진 그룹 대상 > 집계 함수를 적용하기 위해서(****) -> COUNT, SUM, AVG, MAX, MIN
    - GROUP BY 컬럼명 [, 컬럼명] x N
    
    < SQL 기본문법 >
    SELECT 컬럼리스트
    FROM 테이블명
    WHERE 조건
    GROUP BY 그룹기준
    ORDER BY 정렬
    
    < SQL 실행순서 >
    1. FROM
    2. WHERE
    3. GROUP BY절
    4. SELECT
    5. ORDER BY
    
    GROUP BY를 사용한 SELECT절에서 사용할 수 있는 표현 2가지
    1. 집계 함수
    2. GROUP BY를 한 컬럼
    
*/

-- TBLINSA. 부서별로 직원수가 몇명?
SELECT COUNT(*) FROM TBLINSA; -- 총 직원수
SELECT DISTINCT BUSEO FROM TBLINSA; -- 부서
SELECT COUNT(*) FROM TBLINSA WHERE BUSEO = '총무부'; -- 7
SELECT COUNT(*) FROM TBLINSA WHERE BUSEO = '개발부'; -- 14
SELECT COUNT(*) FROM TBLINSA WHERE BUSEO = '영업부'; -- 16
SELECT COUNT(*) FROM TBLINSA WHERE BUSEO = '기획부'; -- 7
SELECT COUNT(*) FROM TBLINSA WHERE BUSEO = '인사부'; -- 4
SELECT COUNT(*) FROM TBLINSA WHERE BUSEO = '자재부'; -- 6
SELECT COUNT(*) FROM TBLINSA WHERE BUSEO = '홍보부'; -- 6

-- GROUP BY 적용
SELECT 
    BUSEO AS 부서명, 
    COUNT(*) AS 부서인원수, 
    ROUND(AVG(BASICPAY)) AS 부서평균급여,
    ROUND(SUM(BASICPAY)) AS 부서급여총액
FROM TBLINSA 
    GROUP BY BUSEO;
    
-- 직위
--ORA-00979: not a GROUP BY expression
SELECT 
    JIKWI,   -- 집합 데이터(그룹 기준)
    --NAME,    -- 개인데이터(개별 레코드 기준)
    COUNT(*) -- 집합 데이터(그룹 기준)
FROM TBLINSA
    GROUP BY JIKWI;


-- 남자 직원수? 여자 직원수? -> 성별 그룹
SELECT 
    SUBSTR(SSN, 8, 1),
    CASE
        WHEN SUBSTR(SSN, 8, 1) = '1' THEN '남자'
        WHEN SUBSTR(SSN, 8, 1) = '2' THEN '여자'
    END AS GENDER,
    COUNT(*)
FROM TBLINSA
    GROUP BY SUBSTR(SSN, 8, 1);
    

-- TBLCOUNTRY
SELECT * FROM TBLCOUNTRY;

SELECT 
    CONTINENT,
    COUNT(*),
    MAX(POPULATION)
FROM TBLCOUNTRY
    GROUP BY CONTINENT;

-- NAME으로 그룹은 묶어지지만, 의미가 없다.    
SELECT
    NAME,
    COUNT(*)
FROM TBLCOUNTRY
    GROUP BY NAME;
    
-- 남자, 여자 평균 키, 몸무게
SELECT 
    GENDER,
    ROUND(AVG(HEIGHT), 1),
    ROUND(AVG(WEIGHT), 1)
FROM TBLCOMEDIAN
    GROUP BY GENDER;

-- 직업별 인원수?
SELECT 
    JOB,
    COUNT(*)
FROM TBLADDRESSBOOK
    GROUP BY JOB
        ORDER BY COUNT(*) DESC;

-- 주소(시, 도)별로 나누기
SELECT
    --SUBSTR(ADDRESS, 1, 5) 5자리로 자르면 경기도, 강원도가 문제임
    --INSTR(ADDRESS, ' ')
    SUBSTR(ADDRESS, 1, INSTR(ADDRESS, ' ') - 1),
    COUNT(*)
FROM TBLADDRESSBOOK
    GROUP BY SUBSTR(ADDRESS, 1, INSTR(ADDRESS, ' ') - 1)
        ORDER BY COUNT(*) DESC;



/*
   
    HAVING 절
    - 조건절
    - GROUP BY에 대한 조건절 > 집계 결과를 대상으로 조건을 질문
    
    WHERE 절
    - 조건절
    - FROM에 대한 조건절 > 레코드 하나하나를 대상으로 조건을 질문
    
    < SQL 기본문법 >
    SELECT 컬럼리스트
    FROM 테이블명
    WHERE 조건
    GROUP BY 그룹기준
    HAVING 조건
    ORDER BY 정렬
    
    < SQL 실행순서 >
    1. FROM
    2. WHERE
    3. GROUP BY
    4. HAVING
    5. SELECT
    6. ORDER BY
    
    HAVING, WHERE의 차이점?
    - FROM절 -> WHERE절 : 개인(레코드 1개씩)에 대한 조건
    - GROUP BY절 -> HAVING절 : 그룹에(집계 함수)에 대한 조건
    
*/        

--F5번 어디 복사할떄 좋음(아래 처럼 이용 가능)

--BUSEO             COUNT(*)
----------------- ----------
--총무부                   7
--개발부                  14
--영업부                  16
--기획부                   7
--인사부                   4
--자재부                   6
--홍보부                   6

--BUSEO             COUNT(*)
----------------- ----------
--총무부                   3
--개발부                   4
--영업부                   5
--기획부                   2
--인사부                   2
--자재부                   2
--홍보부                   1

--BUSEO             COUNT(*)
----------------- ----------
--총무부                   7
--영업부                  16
--기획부                   7
--인사부                   4

SELECT 
    BUSEO,
    COUNT(*)
FROM TBLINSA      
    --WHERE BASICPAY > 2000000
    GROUP BY BUSEO
        HAVING AVG(BASICPAY) > 1500000; --BASICPAY > 2000000 : EEROR -> 집계함수가 아님
--실행순서
--1. FROM 60명
--2. WHERE 30명
--3. GROUP BY 30명의 그룹
--4. HAVING 30명 그룹에서의 조건 ..


-- tblCountry. 대륙별로 최대 인구수, 최소 인구수, 평균 인구수 가져오시오.
SELECT 
    CONTINENT,
    MAX(POPULATION),
    MIN(POPULATION),
    AVG(POPULATION)
FROM TBLCOUNTRY
    GROUP BY CONTINENT;
    
-- hr.employees. 직업별(job_id) 직원수를 가져오시오.
SELECT 
    JOB_ID,
    COUNT(*)
FROM EMPLOYEES
    GROUP BY JOB_ID;

-- tblinsa. 부서별로 직원들의 급여 총합, 부서인원수, 최고급여액, 최저급여액 가져오시오.
SELECT
    SUM(BASICPAY),
    COUNT(*),
    MAX(BASICPAY),
    MIN(BASICPAY)
FROM TBLINSA
    GROUP BY BUSEO;

-- tblAddressbook. 고향별(hometown) 인원수를 가져오시오. 정렬(인원수 내림차순)
SELECT 
    HOMETOWN,
    COUNT(*)
FROM TBLADDRESSBOOK
    GROUP BY HOMETOWN
        ORDER BY COUNT(*) DESC;

-- tblinsa. 부서별 직급의 인원수 가져오시오. GROUP BY + DECODE
--방법1
SELECT
    BUSEO AS 부서,
    COUNT(*) AS 인원,
    COUNT(DECODE(JIKWI, '부장', 1)) AS 부장,
    COUNT(DECODE(JIKWI, '과장', 1)) AS 과장,
    COUNT(DECODE(JIKWI, '대리', 1)) AS 대리,
    COUNT(DECODE(JIKWI, '사원', 1)) AS 사원
FROM TBLINSA
    GROUP BY BUSEO;
    
--방법2, 다중 그룹
SELECT
    BUSEO,
    JIKWI,
    COUNT(*)
FROM TBLINSA
    GROUP BY BUSEO, JIKWI
        ORDER BY BUSEO, JIKWI;


--부서별 남녀 인원수 ?
SELECT
    BUSEO,
    SUBSTR(SSN, 8, 1),
    COUNT(*)
FROM TBLINSA
    GROUP BY BUSEO, SUBSTR(SSN, 8, 1)
        ORDER BY BUSEO, SUBSTR(SSN, 8, 1);

/*

    ROLLUP()
    - GROUP BY에서 사용
    - GROUP BY의 결과에서 집계 결과를 더 자세하게 반환한다.

*/

SELECT
    BUSEO,
    COUNT(*),
    SUM(BASICPAY),
    ROUND(AVG(BASICPAY))
FROM TBLINSA
    GROUP BY ROLLUP(BUSEO); --(null) 총 정산
    
SELECT
    BUSEO,
    JIKWI,
    COUNT(*),
    SUM(BASICPAY),
    ROUND(AVG(BASICPAY)),
    GROUPING_ID(BUSEO,JIKWI) -- 0(일반행), 1(소계행), 3(총계행)
FROM TBLINSA
    GROUP BY ROLLUP(BUSEO, JIKWI); --(null) 중간 정산, (null)(null) 총 정산
    

SELECT
    BUSEO,
    JIKWI,
    COUNT(*),
    SUM(BASICPAY),
    ROUND(AVG(BASICPAY)),
    GROUPING_ID(BUSEO,JIKWI) -- 0(일반행), 1(소계행), 2(중계행), 3(총계행)
FROM TBLINSA
    WHERE JIKWI IN ('부장', '과장')
        GROUP BY CUBE(BUSEO, JIKWI);

--1. traffic_accident. 각 교통 수단 별(지하철, 철도, 항공기, 선박, 자동차) 발생한 총 교통 사고 발생 수, 총 사망자 수, 사건 당 평균 사망자 수를 가져오시오.

SELECT 
    TRANS_TYPE,
    COUNT(*),
    SUM(DEATH_PERSON_NUM),
    ROUND(AVG(DEATH_PERSON_NUM))
FROM TRAFFIC_ACCIDENT
    GROUP BY TRANS_TYPE;
--2. tblZoo. 종류(family)별 평균 다리의 갯수를 가져오시오.
SELECT 
    FAMILY,
    ROUND(AVG(LEG)) AS 평균다리개수
FROM TBLZOO
    GROUP BY FAMILY;

--3. tblZoo. 체온이 변온인 종류 중 아가미 호흡과 폐 호흡을 하는 종들의 갯수를 가져오시오.
SELECT
    BREATH,
    COUNT(*)
FROM TBLZOO
    WHERE THERMO = 'variable'
    GROUP BY BREATH;

--4. tblZoo. 사이즈와 종류별로 그룹을 나누고 각 그룹의 갯수를 가져오시오.
SELECT
    FAMILY,
    SIZEOF,
    COUNT(*)
FROM TBLZOO
    GROUP BY SIZEOF, FAMILY
        ORDER BY SIZEOF, FAMILY;

--6. tblTodo. 완료한 일의 갯수와 완료하지 않은 일의 갯수를 가져오시오.
SELECT
    SUM(COUNT(COMPLETEDATE)),
    CASE
        WHEN COMPLETEDATE = NULL THEN 0
    END
FROM TBLTODO
    GROUP BY COMPLETEDATE;
SELECT * FROM TBLTODO;
    

--7. tblAddressBook. 서울에 사는 10대, 20대, 30대, 40대 인원수를 가져오시오.
SELECT
    COUNT(CASE
        WHEN AGE BETWEEN 10 AND 19 THEN 1
    END) AS "10대",
    COUNT(CASE
        WHEN AGE BETWEEN 20 AND 29 THEN 1
    END) AS "20대",
    COUNT(CASE
        WHEN AGE BETWEEN 30 AND 39 THEN 1
    END) AS "30대",
    COUNT(CASE
        WHEN AGE BETWEEN 40 AND 49 THEN 1
    END) AS "40대"
FROM TBLADDRESSBOOK
    WHERE SUBSTR(ADDRESS, 1, 2) = '서울'
        GROUP BY SUBSTR(ADDRESS, 1, INSTR(ADDRESS, ' ') - 1);

--8. tblAddressBook. 현재 주소(address)와 고향(hometown)이 같은 지역인 사람들을 가져오시오.
SELECT ADDRESS FROM tblAddressBook 
    WHERE HOMETOWN = SUBSTR(ADDRESS, 1,  2) 
        GROUP BY ADDRESS;
        
--9. tblAddressBook. 역삼로에 사는 사람 중 gmail을 사용하는 사람들을 가져오시오.
SELECT 
    *
FROM tblAddressBook
    WHERE EMAIL LIKE '%gmail%' AND ADDRESS LIKE '%역삼로%';

--11. tblAddressBook. 전화번호에 '123'이 들어간 사람 중 여학생만을 가져오시오.
SELECT
    *
FROM tblAddressBook
    WHERE TEL LIKE '%123%' AND GENDER = 'f';

--12. tblAddressBook. 관리자의 실수로 몇몇 사람들의 이메일 주소가 중복되었다. 중복된 이메일 주소만 가져오시오.
SELECT
    EMAIL
FROM tblAddressBook
    GROUP BY EMAIL
        HAVING COUNT(*) > 1;

--15. tblAddressBook. 성씨별 인원수가 100명 이상 되는 성씨들을 가져오시오.
SELECT
    SUBSTR(NAME, 1, 1)
FROM tblAddressBook
    GROUP BY SUBSTR(NAME, 1, 1)
        HAVING COUNT(*) >= 100;

--17. tblAddressBook. 이메일이 스네이크 명명법으로 만들어진 사람들 중에서 여자이며, 20대이며, 키가 150~160cm 사이며, 고향이 서울 또는 인천인 사람들만 가져오시오.
SELECT
    *
FROM tblAddressBook
    WHERE INSTR(EMAIL, '_') <> 0 AND
    GENDER = 'f' AND 
    (AGE BETWEEN 20 AND 29) AND
    (HEIGHT BETWEEN 150 AND 160) AND
    HOMETOWN IN ('서울', '인천');

--18. tblAddressBook. gmail.com을 사용하는 사람들의 성별 > 세대별(10,20,30,40대) 인원수를 가져오시오.
SELECT
    TRUNC(AGE, -1) AS "세대",
    COUNT(*) AS "세대별 인원수",
    COUNT(CASE
        WHEN GENDER = 'f' THEN 1
    END) AS "여자",
    COUNT(CASE
        WHEN GENDER = 'm' THEN 1
    END) AS "남자"
FROM tblAddressBook
    WHERE SUBSTR(EMAIL, INSTR(EMAIL, '@')+1) = 'gmail.com'
        GROUP BY TRUNC(AGE, -1);

--53. employees. 총 사원 수 및 2003, 2004, 2005, 2006 년도 별 고용된 사원들의 총 수를 가져오시오.
SELECT
    TO_CHAR(HIRE_DATE, 'YYYY') || '년',
    COUNT(*) || '명'
FROM EMPLOYEES
        GROUP BY TO_CHAR(HIRE_DATE, 'YYYY')
            ORDER BY 1;

--55. employees. 직업이 'AD_PRESS' 인 사람은 A 등급을, 
--'ST_MAN' 인 사람은 B 등급을, 
--'IT_PROG' 인 사람은 C 등급을, 
--'SA_REP' 인 사람은 D 등급을, 
--'ST_CLERK' 인 사람은 E 등급을 
--기타는 0 을 부여하여 가져오시오.
SELECT
    EMPLOYEES.*,
    CASE
        WHEN JOB_ID = 'AD_PRES' THEN 'A'
        WHEN JOB_ID = 'ST_MAN' THEN 'B'
        WHEN JOB_ID = 'IT_PROG' THEN 'C'
        WHEN JOB_ID = 'ST_REP' THEN 'D'
        WHEN JOB_ID = 'ST_CLERK' THEN 'E'
        ELSE '0'
    END
FROM EMPLOYEES;
