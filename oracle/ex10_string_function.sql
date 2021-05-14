--ex10_string_function.sql



/*
    SUBSTR()
    - 문자열 추출 함수
    - VARCHAR2 SUBSTR(컬럼명, 시작위치, 가져올 문자 개수
    - VARCHAR2 SUBSTR(컬럼명, 시작위치)
    - 서수를 1부터 시작(***)
*/
SELECT
    '가나다라마바사아자차카타파하',
    SUBSTR('가나다라마바사아자차카타파하', 5, 3),
    SUBSTR('가나다라마바사아자차카타파하', 5)
FROM DUAL;

--남자 직원
SELECT COUNT(*) FROM TBLINSA
    WHERE SSN LIKE '%-1%';

--주민등록번호로 남자, 여자 구하기    
--방법1
SELECT COUNT(*) FROM TBLINSA
    WHERE SUBSTR(SSN, 8, 1) = '1'; --남자
SELECT COUNT(*) FROM TBLINSA
    WHERE SUBSTR(SSN, 8, 1) = '2'; --여자
SELECT COUNT(*) FROM TBLINSA
    WHERE SUBSTR(SSN, 8, 1) = '1' OR SUBSTR(SSN, 8, 1) = '3'; --남자
SELECT COUNT(*) FROM TBLINSA
    WHERE SUBSTR(SSN, 8, 1) IN ('2', '4'); --여자

--방법2
SELECT
    NAME, SSN,
    CASE
        WHEN SUBSTR(SSN, 8, 1) = '1' THEN '남자'
        WHEN SUBSTR(SSN, 8, 1) = '2' THEN '여자'
    END AS GENDER
FROM TBLINSA;

--1900년대생 구하기
SELECT
    NAME, '19' || SUBSTR(SSN, 1, 2) AS BIRTHYEAR
FROM TBLINSA;


--장급(부장, 과장)들은 어떤 성을 가지고있나?
SELECT
    DISTINCT SUBSTR(NAME, 1, 1)
FROM TBLINSA
    WHERE JIKWI IN ('부장','과장')
        ORDER BY SUBSTR(NAME, 1, 1);


-- 직원 성? 26가지
SELECT
    DISTINCT SUBSTR(NAME, 1, 1)
FROM TBLINSA;

-- 각각의 성이 몇명인지?
SELECT
    COUNT(CASE
        WHEN SUBSTR(NAME, 1, 1) = '김' THEN 1
    END) AS "김",
    COUNT(CASE
        WHEN SUBSTR(NAME, 1, 1) = '이' THEN 1
    END) AS "이",
    COUNT(CASE
        WHEN SUBSTR(NAME, 1, 1) = '박' THEN 1
    END) AS "박",
    COUNT(CASE
        WHEN SUBSTR(NAME, 1, 1) = '정' THEN 1
    END) AS "정",
    COUNT(CASE
        WHEN SUBSTR(NAME, 1, 1) = '최' THEN 1
    END) AS "최",
    COUNT(CASE
        WHEN SUBSTR(NAME, 1, 1) IN ('김', '이', '박', '정', '최') THEN 1
    END) AS "기타"
FROM TBLINSA;


--태어난 월별, 순으로 정렬(SSN -> SUBSTR(SSN, 3, 2))
SELECT
    *
FROM TBLINSA
    ORDER BY SUBSTR(SSN, 3, 2) ASC;

/*

    LENGTH()
    - 문자열 길이
    - NUMBER LENGTH(컬럼명)
    
*/

-- 컬럼 리스트에서 사용
SELECT NAME, LENGTH(NAME) FROM TBLCOUNTRY;

-- 조건절에서 사용
SELECT NAME FROM TBLCOUNTRY WHERE LENGTH(NAME) > 3;
SELECT NAME FROM TBLCOUNTRY WHERE LENGTH(NAME) BETWEEN 4 AND 6;
SELECT NAME, CAPITAL FROM TBLCOUNTRY WHERE LENGTH(NAME) < LENGTH(CAPITAL);

-- 정렬에서 사용
SELECT NAME, LENGTH(NAME) FROM TBLCOUNTRY ORDER BY LENGTH(NAME) DESC, NAME ASC;

-- 긴 내용은 ..으로 나타내기?
SELECT
    CASE
        WHEN LENGTH(TITLE) >= 8 THEN SUBSTR(TITLE, 1, 8) || '..'
        ELSE TITLE
    END AS TITLE 
FROM TBLTODO;

-- hr.employees
-- 1. 전체 이름(first_name + last_name : fullname)이 가장 긴->짧은 사람 순으로 가져오기
--      컬럼리스트 : first_name + last_name, length(fullename)
SELECT
    FIRST_NAME || LAST_NAME,
    LENGTH(FIRST_NAME || LAST_NAME)
FROM EMPLOYEES
ORDER BY FIRST_NAME || LAST_NAME, lENGTH(FIRST_NAME || LAST_NAME) DESC;

-- 2. 전체 이름(first_name + last_name : fullname)이 가장 긴 사람이 몇글자? 가장 짧은 사람이 몇글자?
--      컬럼리스트 : 숫자만 출력 MAX MIN
SELECT
    MAX(LENGTH(FIRST_NAME || LAST_NAME)) AS "가장 긴 사람",
    MIN(LENGTH(FIRST_NAME || LAST_NAME)) AS "가장 짧은 사람"
FROM EMPLOYEES;

-- 3. last_name이 4자인 사람들의 first_name이 궁금하다. 정렬 : first_name 길이 오름차순으로
SELECT
    FIRST_NAME, LAST_NAME
FROM EMPLOYEES
    WHERE LENGTH(LAST_NAME) = 4
        ORDER BY FIRST_NAME DESC;
        

/*

    INSTR()
    - INDEXOF()
    - 검색어의 위치를 반환
    - ONE-BASED INDEX(서수가 1부터 시작)
    - NUMBER INSTR(컬럼명, 검색어)
    - NUMBER INSTR(컬럼명, 검색어, 시작위치)

*/

SELECT
    '안녕하세요. 홍길동님' AS C1,
    INSTR('안녕하세요. 홍길동님', '홍길동') AS C2,
    INSTR('안녕하세요. 홍길동님', '아무개') AS C3,
    INSTR('안녕하세요. 홍길동님. 잘가세요. 홍길동님', '홍길동', 11) AS C4
FROM DUAL;

--제목입니다. ->(*)제목입니다.
SELECT
    CASE
        WHEN INSTR(TITLE, '자바') > 0 THEN '(*)' || TITLE
        ELSE TITLE
    END AS TITLE
FROM TBLTODO;


/*

    LPAD(), RPAD(), LEFT PADDING, RIGHT PADDING
    - VRACHAR2 LPAD(컬럼명, 개수, 문자)
    - VRACHAR2 RPAD(컬럼명, 개수, 문자)
    
*/

SELECT
    '1',
        LPAD('1', 3, '0'), -- ***
        LPAD('1', 3, '@'),
        LPAD(' ', 20, '='),
        RPAD('1', 3, 0),
        RPAD('1', 3, '+')
FROM DUAL;

/*
    TRIM(), ITRIM(), RTRIM()
    - VARCHAR2 TRIM(컬럼명)
    - VARCHAR2 LTRIM(컬럼명)
    - VARCHAR2 RTRIM(컬럼명)
*/

SELECT
    '   하나   둘   셋   ',
    TRIM('   하나   둘   셋   '),
    LTRIM('   하나   둘  셋   '),
    RTRIM('   하나   둘   셋   ')
FROM DUAL;

/*

    REPLACE()
    - 문자열 치환
    - VARCHAR2, REPLACE(컬럼명, 찾을문자, 바꿀 문자열)

*/

SELECT REPLACE('홍길동', '홍', '김'), REPLACE('홍길동', '이', '김') FROM DUAL;


--TBLINSA. 직원명, 주민번호, 성별(남자, 여자)
SELECT NAME, SSN, SUBSTR(SSN, 8, 1) FROM TBLINSA;

SELECT NAME, SSN,
    CASE
        WHEN SUBSTR(SSN, 8, 1) = '1' THEN '남자'
        WHEN SUBSTR(SSN, 8, 1) = '2' THEN '여자'
    END
FROM TBLINSA;


SELECT NAME, SSN, REPLACE(SUBSTR(SSN,8,1), '1', '남자') FROM TBLINSA;

--각 나라 바꾸기
SELECT
    NAME,
    --방법1
    CASE
        WHEN CONTINENT = 'AS' THEN '아시아'
        WHEN CONTINENT = 'EU' THEN '유럽'
        WHEN CONTINENT = 'AF' THEN '아프리카'
        WHEN CONTINENT = 'AU' THEN '오세아니아'
        WHEN CONTINENT = 'SA' THEN '아메리카'
    END AS CONTINENT,
    
    --방법2, 안하는게 나음.. REPLACE 불편..
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(CONTINENT, 'AS', '아시아'), 'SA', '아메리카'), 'EU', '유럽'), 'AF', '아프리카'), 'AU', '오세아니아'),

    --방법3
    DECODE(CONTINENT, 'AS', '아시아', 'EU', '유럽', 'AF', '아프리카', 'AU', '호주', 'SA', '아프리카')

FROM TBLCOUNTRY;



/*

    DECODE()
    - 문자열 치환
    - REPLACE() 유사
    - VARCHAR2 DECODE(컬럼명, 찾을문자열, 바꿀문자열[, 찾을문자열, 바꿀문자열] X N)
*/

SELECT
    NAME,
    SSN,
    DECODE(SUBSTR(SSN, 8, 1), '1', '남자', '2', '여자'), --없는 값은 NULL 반환
    REPLACE(REPLACE(SUBSTR(SSN, 8, 1), '1', '남자'), '2', '여자') --없는 값은 NULL 이 아닌, 원래값 돌려줌
FROM TBLINSA;

SELECT
    NAME,
    CONTINENT,
    DECODE(CONTINENT, 'AS', '아시아', 'EU', '유럽', 'AF', '아프리카', 'AU', '호주', 'SA', '아프리카')
FROM TBLCOUNTRY;



--팁(***)
--DECODE 유용하게 쓰는법 

--남자, 여자 몇명씩 있는지 개수 구하기
--WHERE 방법
select * from tblComedian;
select count(*) from tblcomedian;
select count(*) from tblcomedian where gender = 'm';
select count(*) from tblcomedian where gender = 'f';

--CASE, AND 방법
SELECT
    COUNT(CASE
        WHEN GENDER = 'm' THEN '남자'
    END) AS "남자 인원수",
    COUNT(CASE
        WHEN GENDER = 'f' THEN '여자'
    END) AS "여자 인원수 "
FROM TBLCOMEDIAN;

--DECODE 방법
SELECT
    COUNT(DECODE(GENDER, 'm', 1)),
    COUNT(DECODE(GENDER, 'f', 1))
FROM TBLCOMEDIAN;


-- tblinsa. 부장 몇명?, 과장 몇명?, 대리 몇명?, 사원 몇명?
SELECT
    COUNT(DECODE(JIKWI, '부장',1)) AS 부장,
    COUNT(DECODE(JIKWI, '과장',1)) AS 과장,
    COUNT(DECODE(JIKWI, '대리',1)) AS 대리,
    COUNT(DECODE(JIKWI, '사원',1)) AS 사원
FROM TBLINSA;

-- tblAddressBook. job. 학생 몇명?, 건물주 몇명?
SELECT
    COUNT(DECODE(JOB, '학생', 1)) AS 학생,
    COUNT(DECODE(JOB, '건물주', 1)) AS 건물주
FROM TBLADDRESSBOOK;

-- tblAddressBook. address. 강동구 몇명? 마포구 몇명?
--방법1
SELECT
    COUNT(CASE
        WHEN ADDRESS LIKE '%강동구%' THEN 1
    END) AS 강동구,
    COUNT(CASE
        WHEN ADDRESS LIKE '%마포구%' THEN 1
    END) AS 마포구
FROM TBLADDRESSBOOK;

--방법2
SELECT
    COUNT(CASE
        WHEN INSTR(ADDRESS, '강동구') > 0 THEN 1
    END) AS 강동구,
    COUNT(CASE
        WHEN INSTR(ADDRESS, '마포구') > 0 THEN 1
    END) AS 마포구
FROM TBLADDRESSBOOK;

--방법3
SELECT
    COUNT(*) - COUNT(DECODE(INSTR(ADDRESS, '강동구'), 0, 1)) AS "강동구",
    COUNT(*) - COUNT(DECODE(INSTR(ADDRESS, '마포구'), 0, 1)) AS "마포구"
FROM TBLADDRESSBOOK;