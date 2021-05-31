--ex29.plsql.sql

/*

    ANSI-SQL
    - 비 절차성 언어(명령어간의 순서가 없다. 흐름이 없다.) -> 제어 흐름이 없다. 문장 단위의 독립적인 언어
    

    PL/SQL
    - Procedural Language Extensions to SQL
    - 절차성 언어
    - 흐름과 제어를 추가
    - ANSI-SQL 모두 지원
    
    PL/SQL = ANSI-SQL + 확장(제어구조)
    
    프로시저, Procedure
    - 메소드, 함수, 서브루린 등..
    - 순서가 있는 코드의 집합
    
    1. 익명 프로시저
        - 1회용
        - 오라클에 저장 X
        
    2. 실명 프로시저
        - 반복용
        - 저장 프로시저
        - DB Object
    
    PL/SQL 프로시저 블럭 구조(골격)
    1. 4개의 키워드로 구성
        1) DECLARE
            - 선언부
            - 프로시저에 사용할 변수, 객체 등을 선언하는 영역
            - 생략 가능
        
        2) BEGIN
            - 실행부(구현부)
            - BEGIN ~ END : 블럭 역할
            - 프로시저 구현 코드를 작성하는 영역(메소드의 BODY 역할)
            - 생략 불가능
            - 업무 관련 코드 작성: ANSI-SQL + 연산, 제어 추가(PL/SQL 구문)
            - try절 역할
            
        3) EXCEPTION
            - 예외 처리부
            - catch절 역할
            - 예외 처리 코드를 작성하는 영역
            - 생략 가능
        
        4) END
            - 실행부(구현부)
            - 생략 불가능
        
    
    [ PL/SQL ]
    1. 자료형
        - ANSI-SQL과 동일(확장)
    
    2. 변수 선언하기
        - 변수명 자료형 [NOT NULL] [DEFAULT 값];
        - NAME VARCHAR2(100) NOT NULL
        - ANSI-SQL에서 테이블의 컬럼을 선언하는 방식과 유사
        - 변수는 주로 질의의 결과(***)나 인자값을 저장하는 용도로 사용
    
    3. 대입 연산자
        - 컬럼명 = 값 //ANSI: UPDATE
        - 변수명 := 값 //PL/SQL
        
        
    DBMS_OUTPUT_PUT_LINE
    - 기본적으로 꺼진상태
    SET SERVEROUTPUT ON;
    SET SERVEROUTPUT OFF;

*/

DECLARE
    NUM NUMBER;         -- 숫자형
    NAME VARCHAR2(30);  -- 문자형
    TODAY DATE;         -- 날짜형
BEGIN
    NUM := 10;
    DBMS_OUTPUT.PUT_LINE(NUM); --syso
    
    NAME := '홍길동';
    DBMS_OUTPUT.PUT_LINE(NAME);
    
    TODAY := '2021-05-26'; --리터럴 -> 암시적 형변환
    DBMS_OUTPUT.PUT_LINE(TODAY);
    
    TODAY := TO_DATE('2021-05-26', 'YYYY-MM-DD'); -- FM
    DBMS_OUTPUT.PUT_LINE(TODAY);
    
    TODAY := SYSDATE;
    DBMS_OUTPUT.PUT_LINE(TODAY);
END;



DECLARE
    NUM1 NUMBER;
    NUM2 NUMBER DEFAULT 200;
    NUM3 NUMBER NOT NULL := 300;
    NUM4 NUMBER NOT NULL DEFAULT 400;
BEGIN

    DBMS_OUTPUT.PUT_LINE('NUM1: ' || NUM1); -- NULL 출력
    DBMS_OUTPUT.PUT_LINE('NUM2: ' || NUM2); -- DEFAULT 출력
    DBMS_OUTPUT.PUT_LINE('NUM3: ' || NUM3); -- 값 출력
    DBMS_OUTPUT.PUT_LINE('NUM4: ' || NUM4); -- DEFAULT 출력

END;


/*

    질의의 결과? (SELECT)
    - 여태까지(ANSI-SQL만 사용) -> SELECT 결과 -> 1차 소비(눈) + 폐기
    - 지금부터 -> SELECT 결과 -> 변수 저장 -> 1,2,3차 소비...
    
    1. 1행 1열
        - 단일값
        - 1:1
        - 컬럼 1개 -> 변수 1개에 저장
    
    2. 1행 N열
        - 복합값
        - N:N
        - 컬럼 N개 -> 변수 N개에 저장
    
    3. N행 1열
        - 다중값 -> 커서 사용
    
    4. N행 N열
        - 다중+복합값 -> 커서 사용
        
    SELECT INTO절
        - SELECT의 결과 값을 변수에 저장하는 구문

*/

-- 예제1
SELECT BUSEO FROM TBLINSA WHERE NAME = '홍길동';

DECLARE
    VBUSEO VARCHAR2(15); -- 부서를 저장할 변수
BEGIN
    -- PLS-00428: an INTO clause is expected in this SELECT statement
    -- PL/SQL 블럭내부에서는 SELECT의 결과를 반드시 변수에 저장해야 한다.
    -- 만약 변수에 저장하지 않는 일반 ANSI-SQL의 SELECT문을 그냥 사용하면 에러가 발생한다.
    -- SELECT BUSEO FROM TBLINSA WHERE NAME = '홍길동';

    -- SELECT INTO 사용
    -- SELECT 컬럼 INTO 변수
    -- ANSI-SQL의 결과를 PL/SQL로 옮겨담는 작업 중 하나(*****)
    SELECT BUSEO INTO VBUSEO FROM TBLINSA WHERE NAME = '홍길동';
    DBMS_OUTPUT.PUT_LINE('결과: ' || VBUSEO); -- PL/SQL 변수
    
    -- ANSI-SQL 식별 PLS-00201: identifier 'BUSEO' must be declared
    -- PL/SQL 블럭내부에서는 ANSI-SQL의 식별자(테이블명, 컬럼명 등)를 직접 사용할 수 없다.
    DBMS_OUTPUT.PUT_LINE('결과: ' || BUSEO); --ERROR
END;



-- 예제2
DECLARE
    VNAME VARCHAR2(15);
    VBUSEO VARCHAR2(15);
BEGIN
    VNAME := '이순신';
    
    -- 기존의 ANSI-SQL을 구성하면서 PL/SQL 값을 상수로 사용할 수 있다.
    SELECT BUSEO INTO VBUSEO FROM TBLINSA WHERE NAME = VNAME;
    
    DBMS_OUTPUT.PUT_LINE(VBUSEO);
END;


-- 예제3
DECLARE
    VCOUNT NUMBER;
BEGIN
    SELECT COUNT(*) INTO VCOUNT FROM TBLINSA WHERE BUSEO = '총무부';
    DBMS_OUTPUT.PUT_LINE('총무부 직원수: ' || VCOUNT || '명');
END;


/* 
    SELECT INTO
    1. 컬럼의 갯수 = 변수의 갯수
    2. 자료형 일치
    3. 순서 일치
    
    --> 한가지라도 만족안하면 ERROR
*/

DECLARE
    VNAME VARCHAR2(15);
    VBUSEO VARCHAR2(15);
    VJIKWI VARCHAR2(15);
    VBASICPAY NUMBER;
BEGIN
    SELECT NAME, BUSEO, JIKWI, BASICPAY INTO VNAME, VBUSEO, VJIKWI, VBASICPAY 
    FROM TBLINSA WHERE NAME = '홍길동';
    
    DBMS_OUTPUT.PUT_LINE(VBUSEO);
    DBMS_OUTPUT.PUT_LINE(VJIKWI);
    DBMS_OUTPUT.PUT_LINE(VBASICPAY);
END;

-- 프로시저 생성 + ANSI+SQL(SELECT) + 결과(PL/SQL 변수에 저장)

SET SERVEROUTPUT ON;

DECLARE
    VNAME VARCHAR2(15);
    VBASICPAY NUMBER;
BEGIN

    SELECT NAME, BASICPAY INTO VNAME, VBASICPAY FROM TBLINSA
        WHERE BASICPAY = (SELECT MAX(BASICPAY) FROM TBLINSA);
    
    DBMS_OUTPUT.PUT_LINE(VNAME);
    DBMS_OUTPUT.PUT_LINE(VBASICPAY);

END;




CREATE TABLE TBLTEMP
AS
SELECT NAME, BUSEO, JIKWI, CITY FROM TBLINSA WHERE CITY = '서울';

SELECT * FROM TBLTEMP;

-- TBLINSA -> 연봉 1위(SELECT) -> TBLTEMP 추가(INSERT)

DECLARE
    VNAME VARCHAR2(15);
    VBUSEO VARCHAR2(15);
    VJIKWI VARCHAR2(15);
    VCITY VARCHAR2(15);
BEGIN

    --1.
    SELECT NAME, BUSEO, JIKWI, CITY INTO VNAME, VBUSEO, VJIKWI, VCITY FROM TBLINSA
        WHERE BASICPAY = (SELECT MAX(BASICPAY) FROM TBLINSA);
        
    --2.
    INSERT INTO TBLTEMP (NAME, BUSEO, JIKWI, CITY) VALUES (VNAME, VBUSEO, VJIKWI, VCITY);
    
END;

SELECT * FROM TBLTEMP; -- 허경운 정보 들어감





-- TBLINSA. 연봉 꼴지 -> 같은 부서 직원 TBLTEMP 삭제
DECLARE
    VBUSEO VARCHAR2(15);
BEGIN
    
    --1.
    SELECT BUSEO INTO VBUSEO FROM TBLINSA
        WHERE BASICPAY = (SELECT MIN(BASICPAY) FROM TBLINSA);
    
    --2.
    DELETE FROM TBLTEMP WHERE BUSEO = VBUSEO;
    
END;



/*

    참조 자료형
    - 테이블로부터 직접 자료형을 알아내는 방법
    - 생산성 + 유지보수성
    
    컬럼 참조하기!!
    1. %TYPE
        - 사용하는 테이블의 특정 컬럼 자료형을 그대로 참조해서 변수에 적용
        a. 자료형
        b. 길이
        c. not null
    
*/

DECLARE
    VNAME VARCHAR2(20);
    VSSN TBLINSA.SSN%TYPE; -- 실제 테이블 컬럼을 참조해서 자료형을 복사해온다.
    VSUDANG TBLINSA.SUDANG%TYPE;
BEGIN

    SELECT NAME, SSN, SUDANG INTO VNAME, VSSN, VSUDANG FROM TBLINSA WHERE NAME = '홍길동';
    DBMS_OUTPUT.PUT_LINE(VNAME);
    DBMS_OUTPUT.PUT_LINE(VSSN);
    DBMS_OUTPUT.PUT_LINE(VSUDANG);

END;


/*

    1. %TYPE
        - 컬럼 참조
        
    2. %ROWTYPE
        - 행 참조
        - %TYPE의 집합
        
*/


DECLARE
    -- '홍길동'의 모든정보?
    -- 변수10개 필요
    VNUM TBLINSA.NUM%TYPE;
    VNAME TBLINSA.NAME%TYPE;
    VSSN TBLINSA.SSN%TYPE;
    VIBSADATE TBLINSA.IBSADATE%TYPE;
    VCITY TBLINSA.CITY%TYPE;
    VTEL TBLINSA.TEL%TYPE;
    VBUSEO TBLINSA.BUSEO%TYPE;
    VJIKWI TBLINSA.JIKWI%TYPE;
    VBASICPAY TBLINSA.BASICPAY%TYPE;
    VSUDANG TBLINSA.SUDANG%TYPE;
BEGIN

    SELECT * INTO VNUM, VNAME, VSSN, VIBSADATE, VCITY, VTEL, VBUSEO, VJIKWI, VBASICPAY, VSUDANG FROM TBLINSA WHERE NAME = '홍길동';

    DBMS_OUTPUT.PUT_LINE(VNUM);
    DBMS_OUTPUT.PUT_LINE(VNAME);
    DBMS_OUTPUT.PUT_LINE(VTEL);
    
END;
--> TBLINSA 테이블의 컬럼이 10개 이므로 변수 하나하나 지정 하기에 매우 불편하다..


-- 해당 테이블의 모든 컬럼(행) 자료형 전부 적용
-- %ROWTYPE
DECLARE
    VROW TBLINSA%ROWTYPE; -- 테이블의 모든 컬럼의 집합 참조, 레코드 참조
BEGIN

    SELECT * INTO VROW FROM TBLINSA WHERE NAME = '홍길동';

    DBMS_OUTPUT.PUT_LINE(VROW.NAME);
    DBMS_OUTPUT.PUT_LINE(VROW.BUSEO);
    DBMS_OUTPUT.PUT_LINE(VROW.CITY);
    
END;
--> 무조건 %ROWTYPE이 좋은건 아니다. -> 전부 복사이기 때문에...


-- 변수 지정시, 여러가지(%TYPE 등..) 섞여서 쓸 일이 많다.
-- TBLINSA 테이블에 없는 컬럼(GENDER)을 우리가 직접 지정(변수) 해서 이용할 수 있다.
DECLARE
    VNAME TBLINSA.NAME%TYPE;
    VGENDER VARCHAR2(1);
BEGIN
    SELECT SUBSTR(SSN, 8, 1) INTO VGENDER FROM TBLINSA WHERE NAME = '이순신';
    DBMS_OUTPUT.PUT_LINE(VGENDER);
END;





-- 제어문(조건문)
-- IF
DECLARE
    VNUM NUMBER := 10; --1. 변수 생성 + 초기화
BEGIN
    IF VNUM > 0 THEN
        DBMS_OUTPUT.PUT_LINE('양수');
    END IF;
END;

-- ELSE
DECLARE
    VNUM NUMBER := -10; 
BEGIN
    IF VNUM > 0 THEN
        DBMS_OUTPUT.PUT_LINE('양수');
    ELSE
        DBMS_OUTPUT.PUT_LINE('양수아님');
    END IF;
END;

-- ELSE IF
DECLARE
    VNUM NUMBER := 0; 
BEGIN
    IF VNUM > 0 THEN
        DBMS_OUTPUT.PUT_LINE('양수');
    ELSIF VNUM < 0 THEN                        --> 주의할것 ELSIF 임
        DBMS_OUTPUT.PUT_LINE('양수아님');
    ELSE
        DBMS_OUTPUT.PUT_LINE('영');
    END IF;
END;


-- 특별 상여금
CREATE TABLE TBLBONUS (
    SEQ NUMBER PRIMARY KEY,                             -- 지급내역번호(PK)
    PNUM NUMBER NOT NULL REFERENCES TBLINSA(NUM),       -- 직원번호(FK)
    BONUS NUMBER NOT NULL,                              -- 지급액
    REGDATE DATE DEFAULT SYSDATE NOT NULL               -- 지급날짜
);

CREATE SEQUENCE SEQBONUS;

-- 특정 1명 -> 보너스 지급(직위에 따라)
DECLARE
    VJIKWI TBLINSA.JIKWI%TYPE;
    VNUM TBLINSA.NUM%TYPE;
    VBASICPAY TBLINSA.BASICPAY%TYPE;
    VBONUS NUMBER;
BEGIN
    --1. 
    SELECT JIKWI, NUM, BASICPAY INTO VJIKWI, VNUM, VBASICPAY FROM TBLINSA WHERE NAME = '홍길동';
    
    --2. 직위에 따른 보너스 금액 정하기
    IF VJIKWI IN ('부장', '과장') THEN
        VBONUS := VBASICPAY * 2;
    ELSIF VJIKWI IN ('대리', '사원') THEN
        VBONUS := VBASICPAY * 1.5;
    END IF;
    
    --3. 보너스 지급
    INSERT INTO TBLBONUS (SEQ, PNUM, BONUS, REGDATE) VALUES (SEQBONUS.NEXTVAL, VNUM, VBONUS, DEFAULT); 
END;

-- 잘들어갔는지 확인하기
SELECT * FROM TBLINSA;
SELECT * FROM TBLBONUS;

SELECT
    I.NAME AS "직원명",
    I.JIKWI AS "직위",
    I.BASICPAY AS "급여",
    B.BONUS AS "보너스"
FROM TBLINSA I
    INNER JOIN TBLBONUS B
        ON I.NUM = B.PNUM;
        
        

-- CASE문
-- ANSI-SQL(CASE문)과는 다른 구문!!
-- 1. ANSI-SQL의 CASE: 표현식 정도 수준만 사용
-- 2. PL/SQL의 CASE: 문장 단위 실행도 가능

SELECT
    NAME,
    CASE
        WHEN SUBSTR(SSN, 8, 1) = '1' THEN '남자'
        WHEN SUBSTR(SSN, 8, 1) = '2' THEN '여자'
    END AS GENDER
FROM TBLINSA;

SELECT * FROM TBLCOUNTRY;
-- TBLCOUNTRY, CONTINENT

DECLARE
    VNAME TBLCOUNTRY.NAME%TYPE;
    VCONTINENT TBLCOUNTRY.CONTINENT%TYPE;
    VRESULT VARCHAR2(30);
BEGIN
    SELECT NAME, CONTINENT INTO VNAME, VCONTINENT FROM TBLCOUNTRY WHERE NAME = '중국';
    
    IF VCONTINENT = 'AS' THEN
        VRESULT := '아시아';
    ELSIF VCONTINENT = 'EU' THEN
        VRESULT := '유럽';
    ELSIF VCONTINENT = 'AF' THEN
        VRESULT := '아프리카';
    ELSE 
        VRESULT := '기타';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(VNAME || '-' || VRESULT);
    
    CASE VCONTINENT
        WHEN 'AS' THEN VRESULT := '아시아';
        WHEN 'EU' THEN VRESULT := '유럽';
        WHEN 'AF' THEN VRESULT := '아프리카';
        ELSE VRESULT := '기타';
    END CASE;
    
    DBMS_OUTPUT.PUT_LINE(VNAME || '-' || VRESULT);
    
END;

/*

    반복문
    
    1. loop
        - 무한루프
        - 탈출 조건 처리
        
    2. for loop
        - 지정 횟수 반복(자바 for문 유사)
    
    3. while loop
        - 조건 반복(자바 while문 유사)

*/
set serveroutput on;

--예제1
BEGIN
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE, 'HH24:MI:SS'));
    END LOOP;
    
END;

--예제2
DECLARE
    VNUM NUMBER := 1;
BEGIN

    LOOP
        DBMS_OUTPUT.PUT_LINE(VNUM);
        VNUM := VNUM + 1;
        
        --IF + BREAK: EXIT --> IF와는 다르게 조건을 만족하면 구문을 빠져나감
        EXIT WHEN VNUM > 10;
    END LOOP;

END;




CREATE TABLE TBLLOOP (
    SEQ NUMBER PRIMARY KEY,
    DATA VARCHAR2(30) NOT NULL
);

CREATE SEQUENCE SEQLOOP;

-- 더미 데이터 + 10000개 추가
-- DATA: '데이터1', '데이터2', '데이터3'...

DECLARE
    VNUM NUMBER := 1;
BEGIN
    LOOP
        INSERT INTO TBLLOOP (SEQ, DATA) VALUES (SEQLOOP.NEXTVAL, '데이터' || VNUM);
        VNUM := VNUM + 1;
        EXIT WHEN VNUM > 10000;
    END LOOP;
END;

SELECT * FROM TBLLOOP;
DELETE FROM TBLLOOP;


DECLARE
    VNAME TBLINSA.NAME%TYPE;
    VNUM NUMBER;
BEGIN
    -- TBLINSA. 직원번호 1015 ~ 1045, 이름, TBLLOOP 추가
    VNUM := 1015;
    LOOP
        -- 1. 직원번호(1015~1045) 이름가져오기
        SELECT NAME INTO VNAME FROM TBLINSA WHERE NUM = VNUM;
        
        -- 2. TBLLOOP 추가(INSERT)
        INSERT INTO TBLLOOP (SEQ, DATA) VALUES (SEQLOOP.NEXTVAL, VNAME);
        VNUM := VNUM + 1;
        EXIT WHEN VNUM > 1045;
    END LOOP;
    
END;

SELECT * FROM TBLLOOP;


-- FOR LOOP
BEGIN

    -- I: 루프변수
    -- IN: 연결 키워드
    -- 1:초깃값
    -- 10: 최댓값
    -- ..:증가
    FOR I IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
    
    FOR I IN REVERSE 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;


-- 구구단
CREATE TABLE TBLGUGUDAN (
    --ORA-02260: table can have only one primary key
    --DAN NUMBER NOT NULL PRIMARY KEY,
    --NUM NUMBER NOT NULL PRIMARY KEY,
    DAN NUMBER NOT NULL,
    NUM NUMBER NOT NULL,
    RESULT NUMBER NOT NULL,
    
    -- 복합키 만드는 방법1
    CONSTRAINT TBLGUGUDAN_DAN_NUM_PK PRIMARY KEY(DAN, NUM) --> 복합키
);

-- 복합키 만드는 방법2
ALTER TABLE TBLGUGUDAN
    ADD CONSTRAINT TBLGUGUDAN_DAN_NUM_PK PRIMARY KEY(DAN, NUM);


BEGIN
    -- FOR IN 2..9 * 9
    FOR VDAN IN 2..9 LOOP
        FOR VNUM IN 1..9 LOOP
            INSERT INTO TBLGUGUDAN (DAN, NUM, RESULT)
                VALUES (VDAN, VNUM, VDAN * VNUM);
        END LOOP;
    END LOOP;
END;

SELECT * FROM TBLGUGUDAN;



-- 위에서 했던 직원번호(1015~1045) 이름 삽입하기를
-- FOR LOOP로 해보기
-- 더 쉽다!
DECLARE
    VNAME TBLINSA.NAME%TYPE;
BEGIN

    FOR VNUM IN 1030..1040 LOOP

        SELECT NAME INTO VNAME FROM TBLINSA WHERE NUM = VNUM;
        
        INSERT INTO TBLLOOP (SEQ, DATA) VALUES (SEQLOOP.NEXTVAL, VNAME);

    END LOOP;
    
END;

SELECT * FROM TBLLOOP;






-- WHILE LOOP
DECLARE
    VNUM NUMBER := 1;
BEGIN

    --FOR 조건 LOOP
    WHILE VNUM <= 10 LOOP
        DBMS_OUTPUT.PUT_LINE(VNUM);
        VNUM := VNUM + 1;
    END LOOP;

END;


-- 예외 처리부
DECLARE
    VNUM NUMBER;
    VNAME NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('시작');
    -- ORA-06502: PL/SQL: numeric or value error: character to number conversion error
    SELECT NAME INTO VNAME FROM TBLINSA WHERE NUM = 1001;
    DBMS_OUTPUT.PUT_LINE(VNAME);
    
    -- VNUM := 10;
    VNUM := 0;
    -- ORA-01476: divisor is equal to zero

    DBMS_OUTPUT.PUT_LINE(100 / VNUM);
    
    DBMS_OUTPUT.PUT_LINE('끝');

EXCEPTION
    -- CATCH절, 예외 처리부
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('자료형 불일치');
    
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('0으로 나누지못합니다');
    
    WHEN OTHERS THEN -- CATCH (EXCEPTION E) : 모든 종류의 예외 처리
        DBMS_OUTPUT.PUT_LINE('예외처리');
END;


create table tblh (
    name varchar2(20)
);

insert into tblh (name) values ('김영혁');
insert into tblh (name) values ('');

select * from tblh;











/*

    PL/SQL
    - SELECT -> 결과셋 -> PL/SQL 변수
    
    1. SELECT INTO 절 사용
    - 결과셋의 레코드가 1개일 때만 사용 가능(****)
    - 결과셋의 컬럼은 1개 이상~
    - 자바의 Iterator 구조와 유사
    
    DECLARE
        변수 선언;
    BEGIN
        SELECT 컬럼 INTO 변수 FROM 테이블;
    END;
    
    2. CURSOR 사용
    - 결과셋의 레코드가 0개 이상일 때 사용 가능(N개)
    - 컬럼셋의 컬럼은 1개 이상~
    - 일반적으로 결과셋의 레코드가 2개 이상일 때 권장
    
    DECLARE
        커서 선언;
    BEGIN
        커서 열기;
            LOOP
                레코드 접근 -> 커서 사용
            END LOOP;
        커서 닫기;
    END;

*/
SET SERVEROUTPUT ON;

-- SELECT INTO 예제
DECLARE
    VNAME TBLINSA.NAME%TYPE;
BEGIN
    --SELECT NAME INTO VNAME FROM TBLINSA WHERE NUM = 1;    -- ORA-01403: no data found
    --SELECT NAME INTO VNAME FROM TBLINSA;                  -- ORA-01422: exact fetch returns more than requested number of rows
    SELECT NAME INTO VNAME FROM TBLINSA WHERE NUM = 1001;

    DBMS_OUTPUT.PUT_LINE(VNAME);
END;

-- CURSOR 예제
DECLARE
    VNAME TBLINSA.NAME%TYPE;
    
    -- 커서 선언
    CURSOR VCURSOR IS SELECT NAME FROM TBLINSA; -- 결과셋 참조 객체
BEGIN
    -- 커서 열기: 커서가 가지고 있는 SELECT문이 실행된다. > 결과셋 > 커서가 참조
    OPEN VCURSOR;
        
        -- 커서 조작 -> 결과셋 탐색
        -- LOOP: 결과셋의 레코드들을 탐색 루프
        LOOP
        
            -- 커서를 전진한다. + 커서가 가르키는 레코드의 컬럼 접근(읽기)
            FETCH VCURSOR INTO VNAME; -- SELECT NAME INTO VNAME과 유사하다
            
            -- 탈출 -> 더이상 읽어올 레코드가 없을 때
            EXIT WHEN VCURSOR%NOTFOUND; -- 커서 프로퍼티
            DBMS_OUTPUT.PUT_LINE(VNAME);
            
        END LOOP;
        
    -- 커서 닫기
    CLOSE VCURSOR;
END;


-- CURSOR 예제2
SELECT * FROM TBLCOUNTRY;

DECLARE
    CURSOR VCURSOR
        IS SELECT NAME, CAPITAL, POPULATION FROM TBLCOUNTRY ORDER BY NAME ASC;
    VNAME TBLCOUNTRY.NAME%TYPE;
    VCAPITAL TBLCOUNTRY.CAPITAL%TYPE;
    VPOPULATION TBLCOUNTRY.POPULATION%TYPE;
BEGIN

    OPEN VCURSOR;
        LOOP
            -- SELECT NAME, CAPITAL, POPULATION INTO VNAME, VCAPITAL, VPOPULATION
            FETCH VCURSOR INTO VNAME, VCAPITAL, VPOPULATION;
            EXIT WHEN VCURSOR%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE(VNAME || '-' || VCAPITAL || '-' || VPOPULATION);
        END LOOP;
    CLOSE VCURSOR;
    
END;


-- CURSOR 예제3
-- 개발부 직원 -> 모두 보너스 지급
SELECT * FROM TBLBONUS;

DECLARE
    CURSOR VCURSOR IS SELECT NUM, BASICPAY FROM TBLINSA WHERE BUSEO = '개발부';
    VNUM TBLINSA.NUM%TYPE;
    VBASICPAY TBLINSA.BASICPAY%TYPE;
BEGIN

    OPEN VCURSOR;
        LOOP
        
            FETCH VCURSOR INTO VNUM, VBASICPAY;
            EXIT WHEN VCURSOR%NOTFOUND;
            
            -- 여기부터 업무에 따라 고민..
            INSERT INTO TBLBONUS (SEQ, PNUM, BONUS, REGDATE)
                VALUES (SEQBONUS.NEXTVAL, VNUM, ROUND(VBASICPAY * 0.7), DEFAULT);
        
        END LOOP;
    CLOSE VCURSOR;
END;



-- CURSOR 예제4
-- TBLINSA. 개발부 직원 + 모든 컬럼
DECLARE
    CURSOR VCURSOR IS SELECT * FROM TBLINSA WHERE BUSEO = '개발부';
    VROW TBLINSA%ROWTYPE; -- 레코드 참조 변수(컬럼 전체, 10개 짜리)
BEGIN
    OPEN VCURSOR;
        LOOP
            
            FETCH VCURSOR INTO VROW; -- 컬럼 10개 -> 변수 10개 복사
            EXIT WHEN VCURSOR%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE(VROW.NAME);
            DBMS_OUTPUT.PUT_LINE(VROW.BUSEO);
            DBMS_OUTPUT.PUT_LINE('---');
        
        END LOOP;
    CLOSE VCURSOR;
END;



-- CURSOR 간단하게 하는법?
DECLARE
    CURSOR VCURSOR IS SELECT * FROM TBLINSA WHERE BUSEO = '개발부';
    -- VROW TBLINSA%ROWTYPE; -- 생략 -> 아래에서 만든다.
BEGIN
    --OPEN VCURSOR;
        FOR VROW IN VCURSOR LOOP
            
            --FETCH VCURSOR INTO VROW;
            --EXIT WHEN VCURSOR%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE(VROW.NAME);
            DBMS_OUTPUT.PUT_LINE(VROW.BUSEO);
            DBMS_OUTPUT.PUT_LINE('---');
        
        END LOOP;
    --CLOSE VCURSOR;
END;

-- 위 간단버전 주석 지우기 -> 굉장히 간편....
DECLARE
    CURSOR VCURSOR IS SELECT * FROM TBLINSA WHERE BUSEO = '개발부';
BEGIN
    FOR VROW IN VCURSOR LOOP -- VROW + LOOP + FETCH + EXIT WHEN
        
        DBMS_OUTPUT.PUT_LINE(VROW.NAME);
        DBMS_OUTPUT.PUT_LINE(VROW.BUSEO);
        DBMS_OUTPUT.PUT_LINE('---');
    
    END LOOP;
END;


-- 권장 안하지만, 더 간략하게 하는법
CREATE VIEW VWDEV
AS
SELECT * FROM TBLINSA WHERE BUSEO = '개발부';

SELECT * FROM VWDEV;
SELECT * FROM (SELECT * FROM TBLINSA WHERE BUSEO = '개발부'); -- 인라인 뷰

-- 인라인 커서, -> 간략한 방법
-- 권장 안하는 이유?
-- 1. 가독성이 낮다.
-- 2. 예제 처럼 단순한 쿼리에만 사용한다.
BEGIN
    FOR VROW IN (SELECT * FROM TBLINSA WHERE BUSEO = '개발부') LOOP
        
        DBMS_OUTPUT.PUT_LINE(VROW.NAME);
        DBMS_OUTPUT.PUT_LINE(VROW.BUSEO);
        DBMS_OUTPUT.PUT_LINE('---');
    
    END LOOP;
END;






/*
     프로시저
     - PL/SQL 블럭(DECLARE, BEGIN, EXCEPTION, END)
     1. 익명 프로시저
        - 1회용(DB에 저장이 안됨, HDD에 *.sql로 저장)
        - 객체가 아니다!
        - 속도가 느리다.
        - 테스트용, 임시 개발용
        
    2. 실명 프로시저
        - 저장용(DB에 저장이 된다)
        - 객체이다.
        - 재사용 가능, 타 유저에 공유 가능
        - 속도가 빠르다.
        - 업무용
        
    실명 프로시저 > 저장 프로시저(Stored Procedure)
    1. 저장 프로시저(Stored Procedure)
        - 매개변수 구성 OR 반환값 구성 -> 자유
    
    2. 저장 함수(Stored Function)
        - 매개변수 필수, 반환값 필수 -> 고정
        
    익명 프로시저 선언
    [DECLARE 
        변수 선언;
        커서 선언;] --생략가능
    BEGIN
        구현부;
    [EXCEPTION
        예외처리;] --생략가능
    END;
    
    
    저장 프로시저 선언
    CREATE [OR REPLACE] PROCEDURE 프로시저명
    IS(AS)
    [DECLARE
        변수 선언;
        커서 선언;]
    BEGIN
        구현부;
    [EXCEPTION
        예외처리;] 
    END;
    
    
*/


DECLARE
    VNUM NUMBER;
BEGIN
    VNUM := 100;
    DBMS_OUTPUT.PUT_LINE(VNUM);
END;

CREATE OR REPLACE PROCEDURE PROCTEST
IS
    VNUM NUMBER;
BEGIN
    VNUM := 100;
    DBMS_OUTPUT.PUT_LINE(VNUM);
END;





/*
    
    저장 프로시저를 호출하는 방법
    
    1. 스크립트 환경에서 호출하기(ANSI-SQL 환경에서)
    2. PL/SQL 블럭에서 호출하기

*/


-- 2. PL/SQL 블럭에서 호출하기
BEGIN
    PROCTEST;
END;


-- ANSI-SQL 환경
PROCTEST;

--1. 스크립트 환경에서 호출하기(ANSI-SQL 환경에서)
    EXECUTE PROCTSET
    
    
/*

    프로젝트 적용
    1. 두 방식 모두 사용
    2. 비율 알아서 나누기..
        a. 핵심 업무(저장 프로시저). 잡다한 업무(ANSI-SQL)
        b. 회원, 게시판(저장 프로시저). 관리자(ANSI-SQL)


    SQL 처리 순서

    1. ANSI-SQL or 익명 프로시저
        - 클라이언트 구문 작성(select) -> 실행(Ctrl+Enter) -> 명령어가 오라클 서버에 전달
            -> 서버에서 명령어를 수신 -> 구문 분석(파싱) -> 컴파일 -> 실행 -> 결과 도출
            -> 결과셋을 클라이언트에게 반환
        - 한번 실행했던 명령어를 다시 실행 -> 위의 과정을 다시 처음부터 끝까지 모든 과정을 재실행한다.
        - 첫번째 실행 비용 = 다시 실행 비용
    
    2. 저장 프로시저(PL/SQL)
        - 클라이언트 구문 작성(select) -> 실행(Ctrl+Enter) -> 명령어가 오라클 서버에 전달
            -> 서버에서 명령어를 수신 -> 구문 분석(파싱) -> 컴파일 -> 실행 -> 결과 도출
            -> 결과셋을 클라이언트에게 반환
        - 한번 실행했던 명령어를 다시 실행 -> "구문 분석(파싱) -> 컴파일" 과정이 생략된다. : 이부분 비용 감소
        - 첫번째 실행 비용 > 다시 실행 비용

*/