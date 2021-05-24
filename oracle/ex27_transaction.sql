--ex27_transaction.sql

/*

    트랜잭션, Transaction
    - 트랜잭션 개념
    - 오라클에서 트랜잭션을 처리(조작)하는 방법
    - 오라클에서 발생하는 1개 이상의 명령들을 하나의 논리 집합으로 묶어 놓은 단위 > (실행된) 명령어들의 집합 > 통제(제어)
    - 트랜잭션에 포함되는 명령어 > INSERT, UPDATE, DELETE > 테이블 조작(변경)
    
    트랜잭션 명령어
    - DCL(TCL)
    - 하나의 트랜잭션으로 묶여있는 DML들을 감시하다가, 일부 DML에서 문제가 발생하면 이전에 성공한 모든 DML을 어떻게 처리 할지에 대한..
    1. COMMIT
    2. ROLLBACK
    3. SAVEPOINT
    
    새로운 트랜잭션이 시작하는 경우
    1. 클라이언트가 접속한 직 후
    2. COMMIT 실행 직 후
    3. ROLLBACK 실행 직 후
    
    현재 트랜잭션이 종료되는 경우
    1. COMMIT 실행 직 후
    2. ROLLBACK 실행 직 후
    3. 클라이언트가 접속을 종료하는 경우 
    4. DDL을 실행하는 경우(CREATE, ALTER, DROP) -> 자동으로 COMMIT 호출이 된다. (Auto Commit)
        - 구조를 바꾸는 작업이라 데이터를 완전 처리하는 작업을 내장

*/
DROP TABLE TBLTRANS;

CREATE TABLE TBLTRANS
AS
SELECT NAME, CITY, BUSEO, JIKWI FROM TBLINSA WHERE BUSEO = '개발부';

-- 클라이언트 접속(HR)
SELECT * FROM TBLTRANS;

DELETE FROM TBLTRANS WHERE NAME = '김신애';
SELECT * FROM TBLTRANS;

ROLLBACK;
SELECT * FROM TBLTRANS;

DELETE FROM TBLTRANS WHERE NAME = '임수봉';
UPDATE TBLTRANS SET CITY = '서울' WHERE NAME = '이순애';
INSERT INTO TBLTRANS VALUES ('하하하', '서울', '개발부', '사원');

SELECT * FROM TBLTRANS;

ROLLBACK;

SELECT * FROM TBLTRANS;

DELETE FROM TBLTRANS WHERE NAME = '임수봉';
SELECT * FROM TBLTRANS;

DELETE FROM TBLTRANS WHERE NAME = '임수봉';
SELECT * FROM TBLTRANS;
COMMIT;

/* 
    결론!!
    둘 다 한번 실행하면 취소 불가능.. (신중하게 해야함)
    
    ROLLBACK: 현재 트랜잭션의 모든 작업을 없었던 일로..
    COMMIT: 현재 트랜잭션의 모든 작업을 실제 데이터베이스(오라클)에 적용해라..
    
    트랜잭션 선택
    1. 사용
    2. 미사용
    
*/
SELECT * FROM TBLTRANS;

DELETE FROM TBLTRANS;

ROLLBACK;

-- COMMIT 발생
CREATE OR REPLACE VIEW VWCOUNTRY
AS
SELECT * FROM TBLCOUNTRY;




/*
    COMMIT, ROLLBACK 어떻게 제어?
    1. 주기
        - 어느 정도 자주 호출해야 하는가?
        - 논리적 작업 단위(스스로 선택)

*/


-- SAVEPOINT
COMMIT;
ROLLBACK;

SELECT * FROM TBLTRANS;

DELETE FROM TBLTRANS WHERE NAME = '김신애';

SELECT * FROM TBLTRANS;

SAVEPOINT A;

DELETE FROM TBLTRANS WHERE NAME = '황진이';

SELECT * FROM TBLTRANS;

SAVEPOINT B;

DELETE FROM TBLTRANS WHERE NAME = '홍길남';

SELECT * FROM TBLTRANS;

ROLLBACK TO B;
ROLLBACK TO A;
COMMIT;
SELECT * FROM TBLTRANS;