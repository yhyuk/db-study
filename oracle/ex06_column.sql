--EX06_COLUMN.sql

/*

    distinct , DISITINCT
    - 컬럼 리스트에 사용
    - 중복값을 제거한다.
    - DISTINCT 컬럼명

*/

SELECT * FROM tblCountry;

-- tblCountry. 어떤 대륙? -> 분류 질문
SELECT CONTINENT FROM tblCountry;           --각 나라들의 대륙이 여러번(중복)으로 나옴
SELECT DISTINCT CONTINENT FROM tblCountry;  --중복제거
SELECT * FROM tblInsa;

-- tblInsa. 어떤 부서?
SELECT BUSEO FROM tblInsa;          --여러번..
SELECT DISTINCT BUSEO FROM tblInsa; --중복제거

--중복값이 단 1개도 없어도 동작된다.
--중복값이 없는 컬럼에 DISTINCT를 적용하는건 의미없다.
SELECT DISTINCT NAME FROM tblInsa; 


-- 1개의 캘럼 중복값 검사와 다른 하나의 캘럼을 출력하려면?
-- EX) DISTINCT BUSEO, NAME 한다면 BUSEO만 검사하는게 아니라 NAME까지 같이한다.
-- --> 출력 행 전체가 중복값이 있다는 가정하에 2개의 캘럼을 묶어서 봐야한다.
-- --> BUSEO, NAME이 아니라, BUSEO + NAME 이라고 생각하자..

-- tblInsa. 어떤 부서 + 이름 ?
SELECT DISTINCT BUSEO, NAME FROM tblInsa; --60명 그대로 출력

-- tblInsa. 어떤 부서 + 직위 ?
SELECT BUSEO, JIKWI FROM tblInsa; --60명 그대로 출력
SELECT DISTINCT BUSEO, JIKWI FROM tblInsa; --23명






/*
    
    지난 2일동안 Oracle 배운것 정리
    
    1. 자료형
        - number, varchar2, char, date
        
    2. select
        - from
        - select 컬럼 리스트 > 별칭(alias), 연산자(산술), distinct
        - where 절 -> 연산자(산술, 비교, 논리), between, in, like, is null, 

    
    
    오늘
    
    case 
    - 모든곳에서 사용 가능
        - 컬럼 리스트에서 사용
        - 조건절에서 사용
        - 정렬에서 사용
    
    - 자바의 if/switch와 비슷한 행동
    - 문장 단위의 제어(X) -> 값을 제어(O)
    - 조건을 만족하지 못하는 컬럼은 NULL을 반환(***)

*/

SELECT
    LAST || FIRST AS NAME,
    GENDER
FROM TBLCOMEDIAN;

--예제1
SELECT 
    LAST || FIRST AS NAME,
    CASE
        WHEN GENDER = 'm' THEN '남자'
        WHEN GENDER = 'f' THEN '여자'
        -- WHEN은 if라고 생각. 뒤에가 조건식. 
        -- GENDER가 'm' 이라면 '남자'로 바꿔라
        -- 'f''라면, NULL 반환
    END AS GENDER
FROM TBLCOMEDIAN;


--에제2 ELSE 예외
SELECT 
    NAME,
    CASE
        WHEN CONTINENT = 'AS' THEN '아시아'
        WHEN CONTINENT = 'EU' THEN '유럽'
        WHEN CONTINENT = 'AF' THEN '아프리카'
        --WHEN CONTINENT = 'AU' THEN '오세아니아'
        --WHEN CONTINENT = 'SA' THEN '남아메리카'
        --WHEN CONTINENT = 'AU' THEN CONTINENT --조건의 반환값이 반드시 상수일 필요가 없다.
        --ELSE '기타' --그 외 나머지 NULL이 되는 값을 '기타'로 표시
        --ELSE CONTINENT
        --ELSE PAPULATION --ERROR:자료형이 다른항목들과 동일
        ELSE '기타'
    END AS CONTINENT
FROM TBLCOUNTRY;

--예제3 비교연산, BETWEEN
SELECT
    LAST || FIRST AS NAME,
    WEIGHT,
    CASE
        WHEN WEIGHT > 100 THEN '과체중'
        WHEN WEIGHT > 50 THEN '정상체중'
        WHEN WEIGHT > 0 THEN '저체중'
    END AS STATE,
    CASE
        WHEN WEIGHT BETWEEN 50 AND 100 THEN '정상체중'
        ELSE '비정상체중'
    END AS STATE2
FROM TBLCOMEDIAN;

--예제4 IS NULL
SELECT
    TITLE,
    CASE
        WHEN COMPLETEDATE IS NULL THEN '완료'
        WHEN COMPLETEDATE IS NOT NULL THEN '미완료'
    END AS STATE
FROM TBLTODO;

--예제5 IN
SELECT
    NAME,
    JIKWI,
    CASE
        WHEN JIKWI IN ('과장', '부장') THEN '세단'
        WHEN JIKWI IN ('대리', '사원') THEN '경차'
    END AS STATE
FROM TBLINSA;

--예제6
SELECT
    NAME, BUSEO, JIKWI,
    --3년 미만: 주니어
    --3년 ~ 7년 미만: 시니어
    --7년 이상: 익스퍼트
    CASE
        WHEN IBSADATE > '2018-05-14' THEN '주니어'
        WHEN IBSADATE <= '2018-05-14' AND IBSADATE > '2014-05-14' THEN '시니어'
        WHEN IBSADATE <= '2014-05-14' THEN '익스퍼트'
    END AS STATE
FROM TBLINSA;




-- TBLINSA. SUDANG
-- 결과셋: NAME, BUSEO, JIKWI, SUDANG, 추가수당(계산)
-- 정챌1: 직위별 수당 + A > 부장(X2), 과장(X1.7), 대리(X1.5), 사원(X1.3)
-- 정책2: 직위별 수당 + A > 부장,과장(X2), 대리,사원(X1.5)

