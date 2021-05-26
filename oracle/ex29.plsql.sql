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