--ex13_DDL.sql

/*

    DDL
    - 데이터 정의어
    - 데이터베이스 객체를 생성, 수정, 삭제한다.
    - 데이터베이스 객체: 테이블, 뷰, 인덱스, 트리거, 프로시저, 제약 사항, 계정 등..
    - CREATE, ALTER, DROP
    
    DDL + 테이블(제약사항)
    
    테이블 생성하기 -> 테이블을 구성하는 컬럼을 생성하기(컬럼 정의)
    
    CREATE TABLE 테이블명
    (
        컬럼 정의,
        컬럼 정의,
        컬럼 자료형(길이) NULL표기 제약사항
    );

    제약 사항, Constraint 
    - ******* 데이터베이스 공부할 때 굉장히 중요하다.
    - 해당 컬럼에 들어갈 데이터(값)에 대한 조건(규제 사항)
        -> 조건을 만족하면 데이터 통과, 조건을 만족하지 못하면 데이터 거부 
        -> 에러 발생 
        -> 유효성 검사 도구
        
    - 6가지
    1. NOT NULL
        - NULL을 가지지 못한다.
        - 해당 컬럼이 반드시 값이 가져야 한다.
        - 해당 컬럼이 값이 없으면 에러
        - 필수값(****)
        
    2. PRIMARY KEY, PK
        - 해당 컬럼이 모든 레코드 중에 유일한 값을 가져야 한다.
        - 다른 레코드와 같은 값을 가질 수 없다.
        - 유일하면서 반드시 필수값을 가진다(*********)
        - 주로 식별자로 사용합니다.(*********)
        - 테이블의 모든 행들을 유일하게 구분하는 역할의 키(컬럼)
        - 반드시 테이블엔 PK가 존재해야 한다.(BUT, PK가 없는 테이블을 만들 순 있다. --> 비권장)
        - 기본키의 형태
            a. 단일 기본키 > 기본키: 1개의 컬럼이 PK 역할
            B. 복합 기본키 > 복합키: 2개 이상의 컬럼이 모여서 PK 역할, Composite Key

    3. FOREIGN KEY
        - 참조키, 외래키
        - 나중에 수업
    
    4. UNIQUE
        - (PRIMARY KEY - NOT NULL)
        - 중복값은 가질 수 없는데 NULL은 가질 수 있다.
    
    5. CHECK
        - 사용자 정의 제약 조건
        - WHERE절에서 조건을 거는것과 동일
    
    6. DEFAULT
        - 기본값 설정
        - 해당 컬럼값이 NULL이면 미리 준비한 기본값을 대입한다.
*/


-- 메모 테이블
CREATE TABLE TBLMEMO (

    SEQ NUMBER(3),              -- 메모 번호
    NAME VARCHAR2(30),          -- 작성자
    MEMO VARCHAR2(1000) NULL,   -- 메모내용
    REGDATE DATE NULL           -- 작성날짜
    
); -- 테이블안 컬럼 끝에는 NULL이 항상 붙어있다.(작성 안해도 생략되어 포함되어 있음)

SELECT * FROM TBLMEMO;

-- 데이터 추가하기
INSERT INTO TBLMEMO (컬럼리스트) VALUES (값리스트);
INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (1, '홍길동', '메모입니다', SYSDATE);
INSERT INTO TBLMEMO (SEQ, NAME, MEMO) VALUES (1, '홍길동', '메모입니다'); -- 날짜 생략
INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (1, NULL, '메모입니다', SYSDATE);


-- 1. NOT NULL
DROP TABLE TBLMEMO;
CREATE TABLE TBLMEMO (

    SEQ NUMBER(3) NOT NULL,          
    NAME VARCHAR2(30) NOT NULL,      
    MEMO VARCHAR2(1000) NULL,    
    REGDATE DATE NULL      
    
);

INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (1, '홍길동', '메모입니다', SYSDATE);
INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (1, '홍길동', NULL, SYSDATE);

--ORA-01400: cannot insert NULL into ("HR"."TBLMEMO"."NAME")
INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (1, NULL, '메모입니다', SYSDATE);
INSERT INTO TBLMEMO (SEQ, MEMO, REGDATE) VALUES (1, '메모입니다', SYSDATE);

SELECT * FROM TBLMEMO;




-- 2. 기본키 PK
DROP TABLE TBLMEMO;

CREATE TABLE TBLMEMO (

    --모든 테이블에는 PK가 반드시 있어야 한다. -> 의미하는것?
    SEQ NUMBER(3) PRIMARY KEY, -- 기본키(PK) > 중복값을 가질 수 없다.(Unique) + Not Null = 완벽한 식별자    
    NAME VARCHAR2(30),      
    MEMO VARCHAR2(1000),    
    REGDATE DATE      
    
);

INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (1, '홍길동', '메모입니다', SYSDATE);
INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (2, '아무개', '테스트용', SYSDATE);

--ORA-01400: cannot insert NULL into ("HR"."TBLMEMO"."SEQ")
INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (NULL, '아무개', '테스트용', SYSDATE);

--PK를 지정안하면 중복값 때문에 현재 상태는 레코드를 구분할 방법이 없다 *****
--ORA-00001: unique constraint (HR.SYS_C007081) violated
SELECT SEQ, NAME, MEMO, TO_CHAR(REGDATE, 'YYYY-MM-DD HH24:MI:SS') FROM TBLMEMO
    WHERE SEQ = 2;
    
SELECT * FROM TBLINSA;      --NUM컬럼이 PK
SELECT * FROM TBLMEN;       --NAME컬럼이 PK
SELECT * FROM TBLCOUNTRY;   --NAME컬럼이 PK
SELECT * FROM TBLCOMEDIAN;  --FIRST + LAST 복합키


-- 4. UNIQUE
DROP TABLE TBLMEMO;

CREATE TABLE TBLMEMO (

    SEQ NUMBER(3) PRIMARY KEY,     
    NAME VARCHAR2(30) UNIQUE,   -- 중복값 금지, 식별자로는 사용할 수 없다.(NULL을 허용하기 때문에)   
    MEMO VARCHAR2(1000),    
    REGDATE DATE      
    
);

INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (1, '홍길동', '메모입니다', SYSDATE);
INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (2, '아무개', '메모입니다', SYSDATE);

--ORA-00001: unique constraint (HR.SYS_C007083) violated
INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (3, '홍길동', '다른메모당', SYSDATE);
INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (3, '하하하', '다른메모당', SYSDATE);
--UNIQUE 값이 있을때만 존재, 없으면 
INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (4, NULL, '다른메모당', SYSDATE);
INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (5, NULL, '다른메모당', SYSDATE);

SELECT * FROM TBLMEMO;


-- 5. DEFAULT - 초기화 개념
DROP TABLE TBLMEMO;

CREATE TABLE TBLMEMO (

    SEQ NUMBER(3) PRIMARY KEY,     
    NAME VARCHAR2(30) DEFAULT '익명',    
    MEMO VARCHAR2(1000) DEFAULT '메모없음',    
    REGDATE DATE      
    
);

INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (1, '홍길동', '메모입니다', SYSDATE);
INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (3, NULL, NULL, SYSDATE);
INSERT INTO TBLMEMO (SEQ, REGDATE) VALUES (2, SYSDATE);
SELECT * FROM TBLMEMO;

INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (seqNum.NEXTVAL, '홍길동', '메모입니다', SYSDATE);


/*

    제약 사항을 만드는 방법
    
    1. 컬럼 수준에서 만드는 방법
        - 현재 방법
        - 컬럼 1개를 정의할 때 제약 사항도 같이 정의하는 방법
        - 컬럼명 자료형(길이) [CONSTRAINT 제약명] 제약조건
        
    2. 테이블 수준에서 만드는 방법
*/

--방법1
DROP TABLE TBLMEMO;

CREATE TABLE TBLMEMO (

    SEQ NUMBER(3) constraint tblmemo_seq_pk PRIMARY KEY,     
    NAME VARCHAR2(30) constraint tblmemo_name_ck CHECK(LENGTH(NAME) BETWEEN 3 AND 5),    
    MEMO VARCHAR2(1000) constraint tblmemo_memo_ck CHECK(LENGTH(MEMO) > 10),    
    REGDATE DATE      
    
);
INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (5, '홍길동하ㅎ하', '메메모메모메모메모메모메메멤', SYSDATE);
SELECT * FROM TBLMEMO;
-- ORA-02290: 체크 제약조건(HR.SYS_C007590)이 위배되었습니다
-- ORA-02290: 체크 제약조건(HR.TBLMEMO_MEMO_CK)이 위배되었습니다
-- ORA-02290: 체크 제약조건(HR.TBLMEMO_NAME_CK)이 위배되었습니다
-- ORA-00001: 무결성 제약 조건(HR.TBLMEMO_SEQ_PK)에 위배됩니다
INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (1, '홍길동홍길동홍길동홍길동', '메모메모메모메모메모메모메모메모메모메모메모메모메모', SYSDATE);

--방법2
DROP TABLE TBLMEMO;

CREATE TABLE TBLMEMO (

    SEQ NUMBER(3),     
    NAME VARCHAR2(30),    
    MEMO VARCHAR2(1000),    
    REGDATE DATE,    
    
    --제약사항 추가 -> 가독성 차이
    CONSTRAINT tblmemo_seq_pk PRIMARY KEY(SEQ),
    CONSTRAINT tbLmemo_name_pk CHECK(LENGTH(NAME) BETWEEN 9 AND 30),
    CONSTRAINT tblmemo_memo_pk CHECK(LENGTH(MEMO) > 30)
    
);