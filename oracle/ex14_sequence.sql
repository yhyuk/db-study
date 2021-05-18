--ex14_sequence.sql

/*

    시퀀스, Sequence
    - 데이터베이스 객체 중 하나
    - 식별자를 만드는데 주로 사용 > PK 컬럼에서 잘 사용
    - 일련번호를 만들어서 제공하는 객체(중복되지 않은 번호)
    - 오라클 전용
    
    시퀀스 객체 만들기
    - CREATE SEQUENCE 시퀀스명;
    
    시퀀스 객체 삭제하기
    - DROP SEQUENCE 시퀀스명;
    
    시퀀스 객체 사용하기
    - 시퀀스명.NEXTVAL 함수(*** 주로 많이 쓰임)
    - 시퀀스명.CURRVAL 함수

*/

CREATE SEQUENCE seqNum;

SELECT seqNum.NEXTVAL FROM DUAL; --계수기

--시퀀스 NEXTVAL은 어떤 용도로 쓰일까?
--PRIMARY KEY를 1, 2, 3... 이런식으로 직접 써야했는데 NEXTVAL함수가 알아서 카운트 해준다
DROP TABLE TBLMEMO;
CREATE TABLE TBLMEMO (

    SEQ NUMBER(3) PRIMARY KEY,     
    NAME VARCHAR2(30) DEFAULT '익명',    
    MEMO VARCHAR2(1000) DEFAULT '메모없음',    
    REGDATE DATE      
    
);

INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (1, '홍길동', '메모입니다', SYSDATE);
INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (seqNum.NEXTVAL, '홍길동', '메모입니다', SYSDATE);
SELECT * FROM TBLMEMO;

--상품번호, 주문번호로 만들수도 있다.
SELECT 'A' || seqNum.NEXTVAL FROM DUAL; --A23
SELECT 'A' || TRIM(TO_CHAR(seqNum.NEXTVAL, '000')) FROM DUAL; --A001, A002, ..

--
SELECT seqNum.CURRVAL FROM DUAL; --39(자바의 QUEUE.PEEK()) --> 다음 값이 뭐가 나올지 출력만 해줌


/*

    시퀀스 상세 설정
    - CREATE SEQUENCE 시퀀스명;
    
    - CREATE SEQUENCE 시퀀스명
        INCREMENT BY N  --> 증감치(양수, 음수)
        START WITH N    --> 시작값(seed)
        MAXVALUE N      --> 최댓값(넘어가면 에러)
        MINVALUE N      --> 최솟값(넘어가면 에러)
        CYCLE           --> 순환구조(PK 써먹기에 곤란함)
        CACHE N;

*/

DROP SEQUENCE seqTest;

CREATE SEQUENCE seqTest 
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 10
    CYCLE
    CACHE 5;

SELECT seqTest.NEXTVAL FROM DUAL;

DROP SEQUENCE seqA;
CREATE SEQUENCE seqA
    MAXVALUE 10
    CYCLE
    CACHE 3;

CREATE SEQUENCE seqB
    MAXVALUE 5
    CYCLE
    CACHE 3;
    
SELECT 'ABC' || TRIM(TO_CHAR(seqA.NEXTVAL, '00')) || TRIM(TO_CHAR (seqB.NEXTVAL, '00')) FROM DUAL;
--ABC0101
--ABC0202
--...
--ABC0505
--ABC0601
--ABC0702

DROP SEQUENCE seqNum;

CREATE SEQUENCE seqNum;

SELECT seqNum.NEXTVAL FROM DUAL; --5 -> ?? -> 21
--ORA-08002: sequence SEQNUM.CURRVAL is not yet defined in this session
--CURRVAL 함수는 반드시 1번 이상의 NEXTVAL가 호출해야만 동작이 된다.
SELECT seqNum.CURRVAL FROM DUAL; 

DROP SEQUENCE seqNum;

CREATE SEQUENCE seqNum START WITH 125;

SELECT SEQNUM.NEXTVAL FROM DUAL;

/*

    오라클 서버를 중지하는 방법
    1. Win+R > service.max > OracleServiceXE 중지
    2. 메뉴 > Stop Database
    3. CMD > net stop OracleServiceXE

    오라클 서버를 시작하는 방법
    1. Win+R > service.max > OracleServiceXE 시작
    2. 메뉴 > Start Databse
    3. cmd > net start OracleServiceXE

*/
-- 메모 번호: seqMemo.NEXTVAL
-- 종복이 되면 안되는 번호(*******)
-- 순차로 숫자가 증가하는것에 대해 신경쓰지말자
-- 1, 2, 3, 4, 5 .. 21, 22, 23, 24... 
-- 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24...
drop sequence seqNum;

create sequence seqNum start with 125;

select seqNum.nextVal from dual;
