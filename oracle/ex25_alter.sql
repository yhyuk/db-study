-- ex25_alter.sql

/*

    DDL
    - 객체 생성: CREATE
    - 객체 삭제: DROP
    - 객체 수정: ALTER
    
    DML
    - 데이터 생성: INSERT
    - 데이터 삭제: DELETE
    - 데이터 수정: UPDATE
    
    
    테이블 수정하기, ALTER TABLE
    - 테이블 구조 수정하기 > 컬럼 정의 수정하기
    - 되도록 테이블을 수정하는 상황이 발생하면 안된다.************
    
    1. ALTER 사용 > 기존 테이블의 구조를 변경
        A. 기존테이블에 데이터가 없었을 경우 > 빈 테이블 > 아무일 없음
        B. 기존테이블에 데이터가 있었을 경우 > 미리 데이터 백업 > 수정 > 변수
            - 서비스 운영 중 사용
    
    2. 테이블 삭제 > 수정된 테이블 생성
        A. 기존 테이블에 데이터 없었을 경우 > 빈 테이블
        B. 기존 테이블에 데이터 있었을 경우 > 미리 데이터 백업 > 테이블 삭제 > 테이블 생성 > 데이터 복구
            - 서비스 운영 중 사용
            - 개발 중에 사용
    
    테이블 수정하기
    1. 새로운 컬럼 추가하기: 무난 + 고민 X
    
    2. 기존 컬럼 삭제하기: 무난 + 고민(데이터 삭제, FK)
    
    3. 기존 컬럼 정의 수정하기--> 고민 많이 해야함
        - 컬럼명 바꾸기: 무난 + 고민(기존 데이터X, 기존 쿼리..)
        - 컬럼의 길이 바꾸기: 무난 + 고민(기존 데이터의 길이)
        - 컬럼의 자료형 바꾸기: 무난 + 고민(기존 데이터) --> 되도록 안하는 방향으로..
        - 컬럼의 제약사항 바꾸기: 무난 + 고민(기존 데이터)

*/



DROP TABLE TBLEDIT;

CREATE TABLE TBLEDIT (
    SEQ NUMBER PRIMARY KEY,
    DATA VARCHAR2(20) NOT NULL
);

INSERT INTO TBLEDIT VALUES (1, '마우스');
INSERT INTO TBLEDIT VALUES (2, '키보드');
INSERT INTO TBLEDIT VALUES (3, '모니터');

SELECT * FROM TBLEDIT;

-- 1. 새로운 컬럼 추가하기 > 가격 컬럼
--ALTER TABLE TBLEDIT ADD (추가 컬럼 정의);
ALTER TABLE TBLEDIT 
    ADD (PRICE NUMBER(5) NULL); -- NULL 컬럼 추가
    
-- ORA-01758: table must be empty to add mandatory (NOT NULL) column
ALTER TABLE TBLEDIT
    ADD (DESCRIPTION VARCHAR2(100) NOT NULL); -- NOT NULL 컬럼 추가

ALTER TABLE TBLEDIT
    ADD (DESCRIPTION VARCHAR2(100) DEFAULT '임시' NOT NULL); -- NOT NULL 컬럼 추가

DELETE FROM TBLEDIT;

ALTER TABLE TBLEDIT
    ADD (ETC VARCHAR2(100) NOT NULL); -- NOT NULL 컬럼 추가


SELECT * FROM TBLEDIT;
-- 2. 기존 컬럼 삭제하기
ALTER TABLE TBLEDIT
    DROP COLUMN ETC;

ALTER TABLE TBLEDIT
    DROP COLUMN DESCRIPTION;
    
ALTER TABLE TBLEDIT
    DROP COLUMN SEQ; -- 심각하게 고민.. (PK값임) --> 되도록 금지


-- 3. 기존 컬럼 정의 수정하기
SELECT * FROM TBLEDIT;
INSERT INTO TBLEDIT VALUES (4, '올해 새롭게 출시된 초경량 노트북');

-- 3.A 컬럼의 길이 수정(확장, 축소)
-- ALTER TABLE TBLEDIT MODIFY(컬럼 정의);
ALTER TABLE TBLEDIT
    MODIFY (DATA VARCHAR2(100));
    
-- ORA-01441: cannot decrease column length because some value is too big
ALTER TABLE TBLEDIT
    MODIFY (DATA VARCHAR2(20)); --늘리거나 줄일수 있지만, 컬럼 데이터값에 따라 달라짐

DESC TBLEDIT;

-- 3.B 컬럼의 자료형 바꾸기
SELECT * FROM TBLEDIT;

-- ORA-01439: column to be modified must be empty to change datatype
ALTER TABLE TBLEDIT
    MODIFY (SEQ VARCHAR2(100));
    
DELETE FROM TBLEDIT;

-- 3.C 제약 사항 바꾸기
ALTER TABLE TBLEDIT
    MODIFY (DATA VARCHAR2(20) NULL);

DESC TBLEDIT;

-- 3.D 컬럼명 바꾸기
ALTER TABLE TBLEDIT
    RENAME COLUMN DATA TO NAME; --> DATA컬럼명이 NAME으로 변경


-- 기존 테이블 + 기존 컬럼에 새로운 제약 사항 추가하기
DESC TBLEDIT;

ALTER TABLE TBLEDIT -- 컬럼 추가하기
    ADD (COLOR VARCHAR2(100) NULL);

SELECT * FROM TBLEDIT;

ALTER TABLE TBLEDIT -- 제약사항 추가하기
    ADD CONSTRAINT TBLEDIT_COLOR_CK CHECK (COLOR IN ('RED', 'YELLOW', 'BLUE'));

INSERT INTO TBLEDIT VALUES (4, '핸드폰', 'YELLOW'); --확인
INSERT INTO TBLEDIT VALUES (5, '테블릿', 'BLACK');

CREATE TABLE TBLEDIT2 (
    SEQ NUMBER,                     --PK
    DATA VARCHAR2(30) NOT NULL,     --CK
    PSEQ NUMBER NOT NULL            --FK
);

ALTER TABLE TBLEDIT2
    ADD CONSTRAINT TBLEDIT2_SEQ_PK PRIMARY KEY(SEQ);

ALTER TABLE TBLEDIT2
    ADD CONSTRAINT TBLEDIT2_DATA_CK CHECK(LENGTH(DATA) > = 5);

ALTER TABLE TBLEDIT2
    ADD CONSTRAINT TBLEDIT2_PSEQ_FK FOREIGN KEY(PSEQ) REFERENCES TBLEDIT(SEQ);

ALTER TABLE TBLEDIT2
    DROP CONSTRAINT TBLEDIT2_PSEQ_FK;