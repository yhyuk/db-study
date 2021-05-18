-- ex12_ casting_function.sql

/*

    형변환 함수
    1. TO_CHAR()   : 숫자 -> 문자
    2. TO_CHAR()   : 날짜 -> 문자 ****
    3. TO_NUBMER() : 문자 -> 숫자
    4. TO_DATE()   : 문자 -> 날짜 ****


    1. TO_CHAR()
    - CHAR TO_CHAR(숫자 컬럼명, 형식 문자열)
    
    형식 문자열 구성요소
    a. 9 : 숫자 1개를 문자 1개로 바꾸는 역할(빈자리는 공백으로 치환한다.) + 부호 자리 추가
    b. 0 : 숫자 1개를 문자 1개로 바꾸는 역할(빈자리는 0으로 치환한다.) + 부호 자리 추가
    c. $ : 통화 기호 표시
    d. L : 통화 기호 표시(Loacle)
    e. . : 소수점 표시
    f. , : 자릿수 표시(천단위)

*/

SELECT
    '@' || 100 || '@', -- NUMBER
    '@' || TO_CHAR(100) || '@', -- CHAR
    '@' || LTRIM(TO_CHAR(100, '99999')) || '@', -- CHAR, 5자리 문자열로 바꾸기
    '@' || LTRIM(TO_CHAR(100, '00000')) || '@' -- CHAR, 5자리 문자열로 바꾸기
FROM DUAL;

SELECT 
    100,
    TO_CHAR(100, '$999'),
    TO_CHAR(100, 'L999'),
    '$' || 100
FROM DUAL;

SELECT 
    123.456,
    TO_CHAR(123.456),
    TO_CHAR(123.456, '999.999'),    
    TO_CHAR(123.456, '999.99'),    
    TO_CHAR(123.456, '999.9'), --ROUND() 유사
    
    1000000,
    TO_CHAR(123.456, '999,999,00'),
    TO_CHAR(123.456,'000')
FROM DUAL;

/*

    2.to_char()
    - 날짜 -> 문자
    - char to_char(날짜컬럼명, '형식문자열')

    형식 문자열 구성 요소
    a. yyyy
    b. yy
    c. month
    d. mon
    e. mm
    f. day
    g. dy
    h. ddd
    i. dd
    j. d
    k. hh(hh12)
    l. hh24
    m. mi
    n. ss
    o. am(pm)
    p. -, :
    
*/

SELECT
    SYSDATE,
    TO_CHAR(SYSDATE, 'YYYY'),  -- 2021, 년(4자리) ****                                                                                                                                                                                                                                                                                                                                                                                                               
    TO_CHAR(SYSDATE, 'YY'),    -- 21, 년(2자리)
    TO_CHAR(SYSDATE, 'MONTH'), -- 5월, 월(풀네임)
    TO_CHAR(SYSDATE, 'MON'),   -- 5월, 월(약어)
    TO_CHAR(SYSDATE, 'MM'),    -- 05, 월(2자리 숫자) ******
    TO_CHAR(SYSDATE, 'DAY'),   -- 월요일, 요일(풀네임) ***
    TO_CHAR(SYSDATE, 'DY'),    -- 월, 요일(약어) ***
    TO_CHAR(SYSDATE, 'DDD'),   -- 137, 날짜(올해..)
    TO_CHAR(SYSDATE, 'DD'),    -- 17, 날짜(이번달..)
    TO_CHAR(SYSDATE, 'D'),     -- 2, 날짜(이번주..) -> 요일(일1 ~ 토7) ***
    TO_CHAR(SYSDATE, 'HH'),    -- 10, 시(12H) 
    TO_CHAR(SYSDATE, 'HH24'),  -- 10, 시(24) *****
    TO_CHAR(SYSDATE, 'MI'),    -- 43, 분 ******
    TO_CHAR(SYSDATE, 'SS'),    -- 41, 초*****
    TO_CHAR(SYSDATE, 'AM')     -- 오전
FROM DUAL;

-- 활용EX) 1. 컬럼 리스트에서 사용
SELECT
    NAME,
    TO_CHAR(IBSADATE, 'YYYY-MM-DD') AS "YYYY년-MM월-DD일",
    --TO_CHAR(IBSADATE, 'YYYY년-MM월-DD일'), -- ERROR
    TO_CHAR(IBSADATE, 'YYYY') || '년' || TO_CHAR(IBSADATE, 'MM') || '월' || TO_CHAR(IBSADATE, 'DD') || '일' AS "YYYY년-MM월-DD일",
    TO_CHAR(IBSADATE, 'HH24:MI:SS') AS 시분초,
    TO_CHAR(IBSADATE, 'YYYY-MM-DD HH24:MI:SS') AS 년월일시분초
FROM TBLINSA;

-- 활용EX) 2. 조건절에서 사용
-- 2010년에 입사한 사람들?
SELECT
    NAME,
    IBSADATE
FROM TBLINSA
    --WHERE IBSADATE >= '2010-01-01' AND IBSADATE <= '2010-12-31'; --틀린방법1
    --WHERE IBSADATE BETWEEN '2010-01-01' AND '2010-12-31';        --틀린방법2
    -- 위 두방법은 왜틀린걸까? > 시분초의 기본값이 00:00:00 때문이다.
    
    --WHERE IBSADATE BETWEEN '2010-01-01 00:00:00' AND '2010-12-31 23:59:59'; --ERROR
    -- SQL에서 날짜 상수 표기법
    -- '2010-01-01' --> O
    -- '2010-01-01 12:00:00' --> X
    
    --WHERE TO_CHAR(IBSADATE, 'YYYY') = '2010'; -- 정답
    --WHERE TO_CHAR(IBSADATE, 'MM') = '05';      -- 년도와 상관없이 5월에 입사한 사람들
    
    --WHERE TO_CHAR(IBSADATE, 'DAY') = '월요일'; -- 월요일에 입사한 사람들 방법1
    --WHERE TO_CHAR(IBSADATE, 'DY') = '월';      -- 방법2
    WHERE TO_CHAR(IBSADATE, 'D') = 2;            -- 방법3(가독성은 낮지만, 활용도가 가장높다 -> 우리나라가 아닌 외국에서..)
    
SELECT
    '2010-01-01' --시분초? 따로 지정하지 않았다면, 기본값은 00:00:00
FROM DUAL;


--활용EX) 3. 정렬에서 사용
SELECT
    NAME, TO_CHAR(IBSADATE, 'YYYY-MM-DD') AS 입사일
FROM TBLINSA
    ORDER BY TO_CHAR(IBSADATE, 'MM') ASC, --년도 상관없이, 월별 오름차순
    TO_CHAR(IBSADATE, ' YYYY') ASC, 
    TO_CHAR(IBSADATE, 'DD');

-- 계절 순으로 출력
SELECT
    NAME, TO_CHAR(IBSADATE, 'YYYY-MM-DD') AS 입사일,
    CASE
        WHEN TO_CHAR(IBSADATE, 'MM') BETWEEN '03' AND '05' THEN '봄'
        WHEN TO_CHAR(IBSADATE, 'MM') BETWEEN '06' AND '09' THEN '여름'
        WHEN TO_CHAR(IBSADATE, 'MM') BETWEEN '10' AND '11' THEN '가을'
        WHEN TO_CHAR(IBSADATE, 'MM') IN ('12', '01', '02') THEN '겨울'
    END AS 계절
FROM TBLINSA
    ORDER BY CASE
        WHEN TO_CHAR(IBSADATE, 'MM') BETWEEN '03' AND '05' THEN 1
        WHEN TO_CHAR(IBSADATE, 'MM') BETWEEN '06' AND '09' THEN 2
        WHEN TO_CHAR(IBSADATE, 'MM') BETWEEN '10' AND '11' THEN 3
        WHEN TO_CHAR(IBSADATE, 'MM') IN ('12', '01', '02') THEN 4
    END ASC;

/*
    
    TO_NUMBER()
    - NUMBER TO_NUMBER(문자열)

*/

SELECT
    '123' AS "aaaaaaaaaaaaaa", -- 문자열
    TO_NUMBER('123'), -- 숫자형
    '123' * 2, --암시적 형변환 발생
    to_number('123') * 2
FROM DUAL;

/*

     TO_DATE() ****많이쓰임
     - DATE TO_DATE(문자열, 형식문자열)

    SQL의 날짜시간 리터럴(상수)
    - 문자열 표기
    - 문맥에 따라 날짜 상수로 인식하시고 하고 문자열 상수로 인식하기도 한다.
    -> 암시적 형변환 발생
*/
SELECT
    SYSDATE,                -- 자료형(DATE)
    '2010-05-17',           -- 자료형(CHAR)
    SYSDATE - '2021-01-01'  -- 자료형(CHAR)
FROM DUAL;

SELECT
*
FROM TBLINSA
    WHERE IBSADATE > '2010-01-01'; --자료형(DATE)
    
-- 문자열로 된, '2021-05-17' 원하는 날짜형식으로 변환하기
SELECT
    TO_DATE('2021-05-17'),
    TO_DATE('2021-05-17', 'YYYY-MM-DD'), 
    TO_DATE('2021/05/17', 'YYYY/MM/DD'), 
    TO_DATE('20210517', 'YYYYMMDD') 
FROM DUAL;

-- 위에서 했던, 2010년 입사 명단?
SELECT * FROM TBLINSA 
    WHERE IBSADATE BETWEEN '2010-01-01' AND '2010-12-31'; -- 2010-01-01 00:00:00 ~ 2010-12-31 00:00:00
SELECT * FROM TBLINSA 
    WHERE TO_CHAR(IBSADATE, 'YYYY') = '2010'; -- 정답
--아까 BETWEEN으로 못했던, 시분초 구하기
SELECT * FROM TBLINSA
    WHERE IBSADATE BETWEEN 
    TO_DATE('2010-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') AND 
    TO_DATE('2010-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS'); --정답

--시분초는 년월일이 필요하다. 잘 쓰이진 않는방법    
SELECT '14:23:45', TO_CHAR(TO_DATE('14:23:45', 'HH24:MI:SS'), 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;