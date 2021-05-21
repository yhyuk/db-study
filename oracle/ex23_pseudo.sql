--ex23_pseudo.sql

/*
    
    Pseudo Column, 의사 컬럼
    - 실제 컬럼이 아닌데 컬럼처럼 행동하는 객체
    
    ROWNUM, rownum
    - 오라클 전용, MS-SQL(TOP), mySQL(limit)
    - 행번호를 반환하는 컬럼
    - 서브 쿼리에 많이 의존(인라인 뷰)
    - ROWNUM은 주로 FROM절이 호출될 때 같이 실행된다.(************)

*/

-- 와일드 카드(*)와 다른 컬럼(표현식 등)은 목록으로 연결될 수 없다.
SELECT *, SYSDATE FROM TBLCOUNTRY; --ERROR
SELECT C.*, SYSDATE FROM TBLCOUNTRY C; --OK

-- 질문의 조건에 1행이 포함되면 결과는 O, 포함 안되면 결과가 X
SELECT C.*, ROWNUM FROM TBLCOUNTRY C WHERE ROWNUM = 1; 
SELECT C.*, ROWNUM FROM TBLCOUNTRY C WHERE ROWNUM <= 5; 
SELECT C.*, ROWNUM FROM TBLCOUNTRY C WHERE ROWNUM >= 1 AND ROWNUM <= 7; 


-- 급여를 많이받는 순으로 1~10등까지 가져오기
SELECT                      --2. 
    NAME, 
    BASICPAY,
    ROWNUM
FROM TBLINSA                --1. 60명 + ROWNUM 할당
    ORDER BY BASICPAY DESC; --3. ROWNUM 이미 1번에 할당이 끝났다..
    
-- 인라인 뷰(FROM절 서브쿼리)    
SELECT NAME, BASICPAY, RNUM, ROWNUM 
FROM (SELECT NAME, BASICPAY, ROWNUM AS RNUM FROM TBLINSA ORDER BY BASICPAY DESC);     

SELECT NAME, BASICPAY, ROWNUM 
FROM (SELECT NAME, BASICPAY FROM TBLINSA ORDER BY BASICPAY DESC)
    WHERE ROWNUM <= 10;
    
SELECT NAME, BASICPAY, ROWNUM 
FROM (SELECT NAME, BASICPAY FROM TBLINSA ORDER BY BASICPAY DESC)
    WHERE ROWNUM = 1;    

SELECT NAME, BASICPAY, ROWNUM 
FROM (SELECT NAME, BASICPAY FROM TBLINSA ORDER BY BASICPAY DESC)
    WHERE ROWNUM >= 3 AND ROWNUM <= 5;
    
-- 급여 순위 3~5등
-- RNUM : 가운데 쿼리의 ROWNUM --> 정적인 번호
-- ROWNUM : 바깥쪽 쿼리의 ROWNUM --> 동적인 번호
SELECT NAME, BASICPAY, RNUM, ROWNUM 
FROM (SELECT NAME, BASICPAY, ROWNUM AS RNUM 
FROM (SELECT NAME, BASICPAY 
FROM TBLINSA ORDER BY BASICPAY DESC))
    WHERE RNUM BETWEEN 3 AND 5;
    

-- BASICPAY + SUDANG --> 급여 순위

-- 정리, 이 2가지 경우만 이해하면 끝!!
-- CASE A
SELECT NAME, SALARY, ROWNUM FROM (SELECT NAME, BASICPAY + SUDANG AS SALARY, ROWNUM FROM TBLINSA ORDER BY SALARY DESC)
    WHERE ROWNUM <= 5;

-- CASE B
SELECT NAME, SALARY, RNUM, ROWNUM 
FROM 
(SELECT NAME, SALARY, ROWNUM AS RNUM 
FROM 
(SELECT NAME, BASICPAY + SUDANG AS SALARY FROM TBLINSA ORDER BY BASICPAY + SUDANG DESC))
    WHERE RNUM BETWEEN 5 AND 10;
    
    
    


-- 지역별(HOMETOWN) 거주자가 몇명인지 구하기
SELECT HOMETOWN, CNT, ROWNUM FROM (SELECT 
                            HOMETOWN,
                            COUNT(*) AS CNT
                        FROM TBLADDRESSBOOK
                            GROUP BY HOMETOWN
                                ORDER BY COUNT(*) DESC)
                                    WHERE ROWNUM <= 3;


SELECT * FROM (SELECT HOMETOWN, CNT, ROWNUM AS RNUM FROM (SELECT 
                            HOMETOWN,
                            COUNT(*) AS CNT
                        FROM TBLADDRESSBOOK
                            GROUP BY HOMETOWN
                                ORDER BY COUNT(*) DESC)
                                    WHERE RNUM = 5;



-- tblAddressBook. 직업별 인원수 -> 순위 1~10등, 11~20등

SELECT JOB, CNT, ROWNUM AS RNUM 
FROM(SELECT JOB, COUNT(*) AS CNT 
FROM TBLADDRESSBOOK GROUP BY JOB ORDER BY COUNT(*) DESC)
    WHERE ROWNUM BETWEEN 1 AND 10;

SELECT JOB, CNT, RNUM 
FROM (SELECT JOB, CNT, ROWNUM AS RNUM 
FROM(SELECT JOB, COUNT(*) AS CNT 
FROM TBLADDRESSBOOK GROUP BY JOB ORDER BY COUNT(*) DESC))
    WHERE RNUM BETWEEN 11 AND 20;
