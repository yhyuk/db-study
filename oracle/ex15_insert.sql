-- ex15_insert.sql

/*

    INSERT문
    DML
    데이터를 테이블에 추가하는 명령어(행추가, 레코드 추가)
    INSERT INTO �테이블명 (컬럼리스트) VALUES (값리스트);

*/

DROP TABLE tblMemo;

CREATE TABLE tblMemo (
    SEQ NUMBER PRIMARY KEY,
    NAME VARCHAR2(30) DEFAULT '익명' NOT NULL,
    MEMO VARCHAR2(1000) NOT NULL,
    REGDATE DATE DEFAULT SYSDATE NULL
);

DROP SEQUENCE seqMemo;
CREATE SEQUENCE seqMemo; --tblMemo.seq 대입

SELECT * FROM tblMemo;
--1. 표준: 원본 테이블에 정의된 컬럼 순서대로 컬럼리스트와 값리스트를 구성하는 방식
INSERT INTO tblMemo (SEQ, NAME, MEMO, REGDATE) VALUES (seqMemo.NEXTVAL, '홍길동', '메모입니다.', SYSDATE);

-- 2. 컬럼리스트의 순서와 값리스트의 순서는 반드시 일치해야 한다.
INSERT INTO tblMemo (NAME, MEMO, REGDATE, SEQ) VALUES (seqMemo.NEXTVAL, '홍길동', '메모입니다.', SYSDATE);

-- 3. 원본 테이블의 컬럼 순서와 insert 컬럼 순서는 무관하다.
INSERT INTO tblMemo (NAME, MEMO, REGDATE, SEQ) VALUES ('홍길동', '메모입니다.', SYSDATE, seqMemo.NEXTVAL);

-- 4. ORA-00947: not enough values
INSERT INTO tblMemo (SEQ, NAME, MEMO, REGDATE) VALUES (seqMemo.NEXTVAL, '홍길동', SYSDATE);

-- 5. ORA-00913: too many values
INSERT INTO tblMemo (SEQ, NAME, REGDATE) VALUES (seqMemo.NEXTVAL, '홍길동', '메모입니다.', SYSDATE);

-- 6. NULL 허용 컬럼 조작
--�암시적 방법(해당 컬럼이 명시X), SYSDATE값�추가됨 -> �WHY? -> DEFAULT가 명시 되어있으므로..
INSERT INTO tblMemo (SEQ, NAME, MEMO) VALUES (seqMemo.NEXTVAL, '홍길동', '메모입니다.'); 
-- 명시적 방법(null 상수), NULL값 추가됨 -> WHY? -> DEFAULT가 있지만 null값이 추가되서..
INSERT INTO tblMemo (SEQ, NAME, MEMO, REGDATE) VALUES (seqMemo.NEXTVAL, '홍길동', '메모입니다.', NULL); 

-- 7. DEFAULT 컬럼 조작
--�암시적 null 대입 -> default 동작
INSERT INTO tblMemo (SEQ, MEMO) VALUES (seqMemo.NEXTVAL, '메모입니다.');
INSERT INTO tblMemo (SEQ, NAME, MEMO, REGDATE) VALUES (seqMemo.NEXTVAL, NULL, '메모입니다', NULL); --명시작 NULL 대입
INSERT INTO tblMemo (SEQ, MEMO, REGDATE) VALUES (seqMemo.NEXTVAL, '메모입니다', NULL); --이름(암시작), 날짜(암시적)

SELECT * FROM tblMemo;

-- DEFALUT 상수(NULL 대입을 통해서 DEFAULT값을 호출하는 방법보다 훨신 직관적이고 편한 방법)
INSERT INTO tblMemo (SEQ, NAME, MEMO, REGDATE) VALUES (seqMemo.NEXTVAL, DEFAULT, '메모입니다', DEFAULT);

--8. 컬럼 리스트 생략 표현 (가독성 낮음)
INSERT INTO TBLMEMO VALUES (seqMemo.NEXTVAL, '홍길동', '메모입니다', SYSDATE);
INSERT INTO TBLMEMO VALUES (seqMemo.NEXTVAL, '홍길동', '메모입니다');
INSERT INTO TBLMEMO VALUES ('홍길동', '메모입니다');

--9. 서브 쿼리
CREATE TABLE tblMemoCopy (
    SEQ NUMBER PRIMARY KEY,
    NAME VARCHAR2(30) DEFAULT '익명' NOT NULL,
    MEMO VARCHAR2(1000) NOT NULL,
    REGDATE DATE DEFAULT SYSDATE NULL
);

INSERT INTO TBLMEMOCOPY SELECT * FROM TBLMEMO;

CREATE TABLE tblComedianMale
(
   first varchar2(20) not null,
   last varchar2(20) not null,
   gender varchar2(1) check(gender in ('m', 'f')) not null,
   height number not null,
   weight number not null,
   nick varchar2(50) not null
);

-- tblComedian 테이블에서 남자만 추출해서 따로 만들어 주세요
INSERT INTO tblComedianMale
    SELECT * FROM TBLCOMEDIAN WHERE GENDER = 'm';

SELECT * FROM tblMemo;                                                                                                                                                                                                                                                              
SELECT * FROM tblMemoCopy;
SELECT * FROM tblComedianMale;

-- 테이블 만들기 + 데이터 추가하기
-- 테이블 생성 시 제약 사항이 복사가 안된다.(*********************)
-- > 실제 사용하는 용도의 테이블이 아님
-- > 개발자 임시 테이블 용도
-- > 더미용
CREATE TABLE tblComdeianFemale
AS 
    SELECT * FROM tblComedian WHERE GENDER = 'f';
    
SELECT * FROM tblComdeianFemale;
