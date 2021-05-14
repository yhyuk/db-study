--ex09_numeric_function.sql


/*

    숫자 함수
    - 자바 MATH 클래스
    
    ROUND()
    - 반올림 함수
    - NUMBER ROUND(컬럼명) : 정수 반환
    - NUMBER ROUND(컬럼명, 소수이하 자릿수) : 실수 반환
    - 숫자형, 날짜형
*/

SELECT 
    HEIGHT, WEIGHT, 
    HEIGHT/WEIGHT, 
    ROUND(HEIGHT/WEIGHT) 
FROM TBLCOMEDIAN;

--10 / 3 결과값을 보고싶다..
SELECT 10 / 3 FROM TBLCOMEDIAN; --10
SELECT 10 / 3 FROM TBLINSA; --60

--10 / 3 결과값을 한줄만 보고싶은데..
SELECT 10 / 3 FROM TBLINSA WHERE NAME = '홍길동'; --방법1 
SELECT 10 / 3 FROM DUAL; --방법2, DUAL(시스템 테이블: 아무의미없는)

SELECT 
    ROUND(987.654),     --988
    ROUND(987.654, 1),  --987.7
    ROUND(987.654, 2)   --987.65
FROM DUAL;

SELECT ROUND(AVG(BASICPAY)) FROM TBLINSA;

SELECT ROUND(NAME) FROM TBLINSA;
SELECT ROUND(IBSADATE), IBSADATE FROM TBLINSA;
SELECT 
    TO_CHAR(ROUND(SYSDATE), 'YYYY-MM-DD HH24:MI:SS'),
    TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')
FROM TBLINSA;

/*
    
    FLOOR(), TRUNC()
    - 절삭 함수
    - 무조건 내림 함수
    - 자바의 정수/정수 --> 몫
    - NUMBER FLOOR(컬럼명)
    - NUMBER TRUNC(컬럼명 [, 소수이하 자릿수])
    
*/

SELECT
    5.6789,
    ROUND(5.6789),
    FLOOR(5.6789),
    FLOOR(5.999999999999991),
    TRUNC(5.6789, 1)
FROM DUAL;


/*

    CEIL()
    - 무조건 올림 함수
    - NUMBER CEIL(컬럼명)

*/

SELECT
    3.1,
    ROUND(3.1),
    CEIL(3.1),
    CEIL(3.0000000000000000001)
FROM DUAL;


/*

    MOD()
    - 나머지 함수
    - NUMBER MOD(피제수, 제수)

*/

SELECT MOD(10, 3) FROM DUAL; --1

--100분 -> 1시간 40분
--100 / 60 -> 몫(시간)
--100 % 60 -> 나머지(분)
SELECT
    FLOOR(100 / 60) AS 시,
    MOD(100, 60) AS 분
FROM DUAL;


SELECT
    ABS(-1), ABS(10),
    POWER(2, 8),
    SQRT(4)
FROM DUAL;