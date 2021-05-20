--ex20_join.sql

/*

    직원 정보 테이블
    - 직원 번호, 직원명, 급여, 거주지, 담당프로젝트

*/

CREATE TABLE tblStaff(
    
    SEQ NUMBER PRIMARY KEY,         --직원번호(PK)
    NAME VARCHAR2(30) NOT NULL,     --직원명
    SALARY NUMBER NOT NULL,         --급여
    ADDRESS VARCHAR2(300) NOT NULL, --거주지
    PROJECT VARCHAR2(300) NULL      --담당프로젝트
    
);

INSERT INTO tblStaff (SEQ, NAME, SALARY, ADDRESS, PROJECT) VALUES (1, '홍길동', 300, '서울시', '홍콩수출');
INSERT INTO tblStaff (SEQ, NAME, SALARY, ADDRESS, PROJECT) VALUES (2, '아무개', 250, '인천시', 'TV광고');
INSERT INTO tblStaff (SEQ, NAME, SALARY, ADDRESS, PROJECT) VALUES (3, '김신입', 180, '수원시', '매출분석');

-- 1명의 직원이 2개 이상의 프로젝트를 담당했을 때
-- 홍길동 + 프로젝트 1건 추가(고객관리)
INSERT INTO tblStaff (SEQ, NAME, SALARY, ADDRESS, PROJECT) VALUES (4, '홍길동', 300, '서울시', '고객관리');

-- 김과장 + 2개 프로젝트 담당
INSERT INTO tblStaff (SEQ, NAME, SALARY, ADDRESS, PROJECT) VALUES (5, '김과장', 270, '인천시', '홍콩수출, 고객관리');

SELECT * FROM tblStaff;

/*
    CASE A. 홍길동
        - 프로젝트 1개당 레코드 1개
        - 직원 정보가 계속 반복된다.(******)
        
    CASE B. 김과장
        - 프로젝트 전부를 1개의 컬럼에 누적
        - 직원 정보가 유일(1개 레코드)
*/

UPDATE tblStaff SET SALARY = 310 WHERE SEQ = 1;

-- 홍길동 + 프로젝트 1건 추가(고객관리)
INSERT INTO tblStaff (SEQ, NAME, SALARY, ADDRESS, PROJECT) VALUES (6, '홍길동', 300, '서울시', '반품처리');

-- 김과장 + 2개 프로젝트 담당
UPDATE tblStaff SET PROJECT = PROJECT || ', 반품처리' WHERE SEQ = 5;

-- 홍길동 고객관리 -> 담당 해제
DELETE FROM tblStaff WHERE SEQ = 4;

-- 호호호 고객관리 -> 담당 해제
UPDATE tblStaff SET PROJECT = REPLACE(PROJECT, '고객관리,', '') WHERE SEQ = 5;
SELECT * FROM tblStaff;

/*
    홍길동, 김과장중 어떤것이 잘만들었을까?
    
    CASE A, 홍길동
        장점: 추가, 삭제만 하면되므로 작업이 수월하다.
        단점: 추가할때마다 정보가 계속 반복된다. > 반복될 수록 수정 시 정보가 망가지는 경우 발생
    
    CASE B, 김과장
        장점: 해당 정보를 테이블에서 눈으로 확인하기에 좋다.
        단점: 수정 시 하나씩 수정해야하므로 불편하며, 나중에 변수가 많다.
        
    두 케이스 모두 장단점이 있으며, 애초에 테이블 설계가 잘못되었다.
*/



DROP TABLE TBLSTAFF;

-- 테이블 분산시키기
CREATE TABLE tblStaff(
    
    SEQ NUMBER PRIMARY KEY,         --직원번호(PK)
    NAME VARCHAR2(30) NOT NULL,     --직원명
    SALARY NUMBER NOT NULL,         --급여
    ADDRESS VARCHAR2(300) NOT NULL  --거주지
    
);

DROP TABLE tblProject;

CREATE TABLE tblProject (
    SEQ NUMBER PRIMARY KEY,                                 --프로젝트번호(PK)
    PROJECT VARCHAR2(300) NULL,                             --담당프로젝트
    STAFF_SEQ NUMBER NOT NULL REFERENCES tblStaff(SEQ)      --직원번호(FK, Foreign Key, 외래키, 참조키)
);

--  tblStaff <-------> tblProject
--  PK(부모키)         FK(자식키)
--  부모               자식
--  부모테이블         자식테이블


INSERT INTO tblStaff (SEQ, NAME, SALARY, ADDRESS) VALUES (1, '홍길동', 300, '서울시');
INSERT INTO tblStaff (SEQ, NAME, SALARY, ADDRESS) VALUES (2, '아무개', 250, '인천시');
INSERT INTO tblStaff (SEQ, NAME, SALARY, ADDRESS) VALUES (3, '김신입', 180, '수원시');

INSERT INTO tblStaff (SEQ, NAME, SALARY, ADDRESS) VALUES (5, '김대리', 280, '서울시');

INSERT INTO tblProject (SEQ, PROJECT, STAFF_SEQ) VALUES (1, '홍콩수출', 1);  
INSERT INTO tblProject (SEQ, PROJECT, STAFF_SEQ) VALUES (2, 'TV광고', 2);  
INSERT INTO tblProject (SEQ, PROJECT, STAFF_SEQ) VALUES (3, '매출분석', 3);  

-- 홍길동, 프로젝트 1개 추가
INSERT INTO tblProject (SEQ, PROJECT, STAFF_SEQ) VALUES (4, '연봉협상', 1);  

-- 홍길동, 프로젝트 1개 해제
DELETE FROM tblProject WHERE SEQ = 1;

SELECT * FROM TBLSTAFF;     -- 3명
SELECT * FROM TBLPROJECT;   -- 3건

-- 위 2개의 테이블의 문제점? 
-- A. 신입 사원 입사 > 신규 프로젝트 담당  
-- A.1 신입 사원 추가 --> O
INSERT INTO tblStaff (SEQ, NAME, SALARY, ADDRESS) VALUES (4, '신입사원', 150, '서울시');

-- A.2 신규 프로젝트 추가 --> O
INSERT INTO tblProject (SEQ, PROJECT, STAFF_SEQ) VALUES (5, '자재매입', 4);  

-- A.3 신규 프로젝트 추가 --> X, 5번에 해당하는 직원이 없음!!
-- ORA-02291: integrity constraint (HR.SYS_C007178) violated - parent key not found
INSERT INTO tblProject (SEQ, PROJECT, STAFF_SEQ) VALUES (6, '고객유치', 5);  

-- B. '홍길동' 퇴사
-- B.1 '홍길동' 삭제 --> X, 문제 발생, 추후 홍길동이 했던 프로젝트가 남아있음
-- ORA-02292: integrity constraint (HR.SYS_C007178) violated - child record found
DELETE FROM tblStaff WHERE SEQ = 1;

-- B.2 '홍길동'의 모든 업무 > 위임(업무 인수인계)  > '홍길동' 삭제 --> O
UPDATE tblProject SET STAFF_SEQ = 2 WHERE STAFF_SEQ = 1;
DELETE FROM tblStaff WHERE SEQ = 1;


/*

    관계를 맺고 있는 2개의 테이블을 조작하면 발생하는 일 
    - 이 규칙이 깨지면 데이터 무결성(유효성)이 깨진다. > 데이터 가치 상실
    - 반드시 지켜야 하는 상황
    
    1. 부모 테이블 조작. tblStaff
        a. 행 추가(INSERT): 아무 영향 없음
        b. 행 수정(UPDATE): 아무 영향 없음
        c. 행 삭제(DELETE): 자식 테이블에 자신을 참조하는 행이 존재하는지 반드시 사전 체크 해야한다. 
                            -> FK 존재 유무 체크!!
                            -> child record found

    2. 자식 테이블 조작. tblProject
        a. 행 추가(INSERT): 자신이 참조하는 대상이 실제로 부모 테이블에 존재하는 값인지 사전 체크 요망!! 
                            -> parent key not found
        b. 행 수정(UPDATE): 수정 컬럼이 FK 컬럼일 때 >  부모 테이블에 존재하는 값인지 사전 체크 요망!!
                            -> parent key not found
        c. 행 삭제(DELETE): 아무 영향 없음   
*/



/*
    관계를 맺고 있는 테이블 생성하기
    - 2개의 테이블 중 누가 부모 테이블이 되고, 누가 자식 테이블이 되야하는지??
    - 2개의 테이블의 데이터 중 시간 흐름 순서상 누가 먼저 생겨나야 하는지??
    - -> 먼저 생성할 테이블(부모 테이블), 나중에 생성할 테이블(자식 테이블)
*/

-- 고객 <-> 판매

-- tblCustomer가 자식 테이블일때
-- 1. 고객이 회원가입 > SSEQ를 비워둔 채 가입
-- 2. 구매 > INSERT(tblSales) + UPDATE(tblCustomer)
-- 3. 구매 > INSERT(tblSales) + UPDATE(tblCustomer) -> "1, 2"

-- tblSales가 자식 테이블일때
-- 1. 고객이 회원가입
-- 2. 구매 > INSERT(tblSales)
-- 3. 구매 > INSERT(tblSales)


-- 고객테이블
CREATE TABLE tblCustomer (
    SEQ NUMBER PRIMARY KEY,                     --고객번호(PK)
    NAME VARCHAR2(30) NOT NULL,                 --고객명
    TEL VARCHAR2(15) NOT NULL,                  --연락처
    ADDRESS VARCHAR2(100) NOT NULL              --주소
    --SSEQ NUMBER NULL REFERENCES tblSales(SEQ) --참조키(판매번호)
);

-- 판매내역 테이블
CREATE TABLE tblSales (
    SEQ NUMBER PRIMARY KEY,                         --판매번호(PK)
    ITEM VARCHAR2(50) NOT NULL,                     --제품명
    QTY NUMBER NOT NULL,                            --수량
    REGDATE DATE DEFAULT SYSDATE NOT NULL,          --판매날짜
    CSEQ NUMBER NOT NULL REFERENCES tblCustomer(SEQ)--고객번호(FK)
);

-- 사원 테이블(자식)
-- 부서 테이블(부모)

SELECT * FROM tblCustomer;
SELECT * FROM tblSales;


-- 비디오 대여점 만들기
-- *** 관계를 맺고 있는 테이블들의 생성과 삭제
-- 1. 생성: 부모 테이블 생성-> 자식 테이블 생성
-- 2. 삭제: 자식 테이블 삭제 -> 부모 테이블 삭제

DROP TABLE tblGenre; -- ORA-02449: unique/primary keys in table referenced by foreign keys
DROP TABLE tblVideo;

-- 장르 테이블
CREATE TABLE tblGenre (
    SEQ NUMBER PRIMARY KEY,             --장르번호(PK)
    NAME VARCHAR2(30) NOT NULL,         --장르명
    PRICE NUMBER NOT NULL,              --대여가격
    PERIOD NUMBER NOT NULL              --대여기간(일)
);

-- 비디오 테이블
CREATE TABLE tblVideo (
    SEQ NUMBER PRIMARY KEY,                         --비디오 번호(PK)
    NAME VARCHAR2(100) NOT NULL,                    --제목
    QTY NUMBER NOT NULL,                            --보유 수량
    COMPANY VARCHAR2(50) NULL,                      --제작사
    DIRECTOR VARCHAR2(50) NULL,                     --감독
    MAJOR VARCHAR2(50) NULL,                        --주연배우
    GENRE NUMBER NOT NULL REFERENCES tblGenre(SEQ)  --장르(FK)
);

-- 고객 테이블
CREATE TABLE tblMember (
    SEQ NUMBER PRIMARY KEY,             --회원번호(PK)
    NAME VARCHAR2(38) NOT NULL,         --회원명
    GRADE NUMBER(1) NOT NULL,           --회원등급(1,2,3)
    BYEAR NUMBER(4) NOT NULL,           --생년
    TEL VARCHAR2(15) NOT NULL,          --연락처
    ADDRESS VARCHAR2(300) NOT NULL,     --주소                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          --주소
    MONEY NUMBER NOT NULL               --예치금
);

-- 대여 테이블
CREATE TABLE tblRent (
    SEQ NUMBER PRIMARY KEY,                             --대여번호(PK)                                                                                                                                                      \\
    MEMBER NUMBER NOT NULL REFERENCES tblMember(SEQ),   --회원번호(FK)
    VIDEO NUMBER NOT NULL REFERENCES tblVideo(SEQ),     --비디오번호(FK)
    RENTDATE DATE DEFAULT SYSDATE NOT NULL,             --대여시각
    RETDATE DATE NULL,                                  --반납시각
    REMARK VARCHAR2(500) NULL                           --비고
);

CREATE SEQUENCE genreSeq;
CREATE SEQUENCE videoSeq;
CREATE SEQUENCE memberSeq;
CREATE SEQUENCE rentSeq;

SELECT * FROM tblGenre; --6개
SELECT * FROM tblVideo; --11개
SELECT * FROM tblMember; --8개
SELECT * FROM tblRent; --6개

DROP TABLE TBLGENRE;
DROP TABLE TBLVIDEO;
DROP TABLE TBLMEMBER;
DROP TABLE TBLRENT;

DROP SEQUENCE genreSeq;
DROP SEQUENCE videoSeq;
DROP SEQUENCE memberSeq;
DROP SEQUENCE rentSeq;

/*

    조인, JOIN
    - (서로 관계를 맺고 있는) 2개(1개) 이상의 테이블의 내용을 동시에 가져와서 1개의 결과셋을 만드는 작업
    - 조인에서 컬럼은 반드시 테이플명(소유주)을 적는게 좋다
    
    조인의 종류(ANSI-SQL)
    1. 단순 조인, CROSS JOIN
        - 사용을 거의 안함 > 결과셋에 유효한 레코드와 유효하지 않은 레코드가 뒤섞여 있기 때문에
        - 가끔식 개발자가 테스트 용도의 큰 데이터가 필요한 경우에 사용(더미 데이터 - 유효성과 무관한)
        - SELECT * FROM tableA CROSS JOIN tableB;
        - SELECT * FROM tableA, tableB;
    
    2. 내부 조인, INNER JOIN (*** 가장 많이 쓰인다.)
        - 단순 조인의 결과셋에서 유효한 레코드만 추출한 조인
        - 두 테이블의 교집합
        - SELECT * FROM tableA INNER JOIN tableB ON tableA.PK = tableB.FK;
        
    3. 외부 조인, OUTER JOIN (*** INNER JOIN만큼 많이 쓰인다.)
        - 내부 조인 + 부모 테이블
        - 내부 조인 + 차집합(부모 테이블)
        - 내부 조인의 결과셋에 참조되지 않은 부모 레코드를 더한 결과셋
        - 일반적으로 부모 테이블을 가르킨다. (LEFT or RIGHT)
        - SELECT * FROM tableA LEFT OUTER JOIN tableB ON tableA.PK = tableB.FK;
          
    4. 전체 외부 조인, FULL OUTER JOIN
        - LFET, RIGHT OUTER JOIN을 합쳐 놓은것과 똑같다.
        - LEFT + RIGHT OUTER JOIN
    
    5. 셀프 조인, SELF JOIN
        - 1개의 테이블을 사용해서 조인
        - 셀프 조인 + 단순 조인
        - 셀프 조인 + 내부 조인
        - 셀프 조인 + 외부 조인
        
*/

-- 1. 단순 조인, CROESS JOIN
SELECT * FROM tblCustomer; --3건
SELECT * FROM tblSales; --9건

SELECT * FROM tblCustomer CROSS JOIN tblSales; -- 27건
SELECT * FROM tblCustomer , tblSales;

-- 모든 조인은 연장해서 계속 이어갈 수 있다.
SELECT COUNT(*) FROM TBLADDRESSBOOK CROSS JOIN TBLADDRESSBOOK CROSS JOIN TBLCOMEDIAN;

-- 2. 내부 조인, INNER JOJIN(*******)

--고객 정보와 판매 내역을 동시에 가져오기
--방법1. INNER JOIN
SELECT * FROM tblCustomer    
    INNER JOIN tblSales
        ON tblCustomer.SEQ = tblSales.CSEQ; -- 어떤 레코드만 남길지에 대한 조건(부모 테이블.PK = 자식테이블.PK)

--방법2. CROSS JOIN, 잘안쓰인다.(이런 방법도 있구나~ 라고만 알아둘 것)
SELECT * FROM tblCustomer
    CROSS JOIN tblSales
        WHERE tblCustomer.SEQ = tblSales.CSEQ; -- 사용안함

-- 조인을 할 때 자주 발생하는 현상
-- ORA-00918: column ambiguously defined, 열의 정의가 애매합니다.
SELECT tblCustomer.SEQ, tblSales.SEQ FROM tblCustomer    
    INNER JOIN tblSales
        ON tblCustomer.SEQ = tblSales.CSEQ;      

-- 무조건 어떤 테이블인지 앞에 적어라!!
SELECT 
    tblCustomer.NAME,
    tblCustomer.ADDRESS,
    tblSales.ITEM,
    tblSales.QTY
FROM tblCustomer    
    INNER JOIN tblSales
        ON tblCustomer.SEQ = tblSales.CSEQ;            
        
-- 테이블명을 항상 적으면 가독성도 좋고 알겠는데.. 매번 타이핑 하기 힘들다..?        
-- 테이블명도 별칭(ALIOS)을 할 수 있다
-- AS 붙이지말것, 1~2글자만 가능
SELECT
    C.NAME,
    C.ADDRESS,
    S.ITEM,
    S.QTY
FROM tblCustomer C
    INNER JOIN tblSales S
        ON C.SEQ = S.CSEQ;



-- SUB QUERY VS JOIN
SELECT * FROM tblCustomer; --고객명, 연락처
SELECT * FROM tblSales;    --제품명, 수량

-- JOIN
SELECT
    C.NAME,
    C.ADDRESS,
    S.ITEM,
    S.QTY
FROM tblCustomer C
    INNER JOIN tblSales S
        ON C.SEQ = S.CSEQ;

-- SUB QUERY(상관 서브 쿼리)
SELECT 
    ITEM, QTY, CSEQ, 
    (SELECT NAME FROM tblCustomer WHERE tblCustomer.SEQ = tblSales.CSEQ) AS NAME, 
    (SELECT TEL FROM tblCustomer WHERE tblCustomer.SEQ = tblSales.CSEQ) AS TEL
FROM tblSales;

-- JOIN -> SUB QUERY로 짜보고, SUB QUERY -> JOIN으로도 짜보자
-- JOIN으로만 풀어야되는것이 있고, SUB QUERY으로만 풀어야 되는것이 있기때문에 하다보면 도움이 많이 된다.

-- INNER JOIN 예제1
SELECT * FROM tblStaff;
SELECT * FROM tblProject;

SELECT
    S.NAME AS 직원명,
    S.SALARY AS 급여,
    P.PROJECT AS 프로젝트명
FROM tblStaff S
    INNER JOIN tblProject P
        ON S.SEQ = P.STAFF_SEQ;

-- INNER JOIN 예제2 
SELECT * FROM tblMen;
SELECT * FROM tblWomen;

SELECT 
    M.NAME AS 남자, 
    F.NAME 여자
FROM tblMen M 
    INNER JOIN tblWomen F 
        ON M.COUPLE = F.NAME;
        

-- INNER JOIN 예제3
-- 서로 상관이 아예 없는 테이블끼리 조인?
-- 출력은 되지만, 의미 없는 테이블이다!!
-- 하지말것!
SELECT * FROM tbLAddressBook;
SELECT * FROM tblComedian;

SELECT * FROM tblAddressBook A
    INNER JOIN tblComedian C
        ON A.HEIGHT = C.HEIGHT;
        
-- INNER JOIN 예제4
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT 
    E.FIRST_NAME || ' ' || E.LAST_NAME AS NAME,
    D.DEPARTMENT_NAME,
    L.CITY || ' ' || L.STREET_ADDRESS
FROM employees E                
    INNER JOIN DEPARTMENTS D
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
            INNER JOIN LOCATIONS L
                ON D.LOCATION_ID = L.LOCATION_ID;
-- JOIN EMPLOYEES <-> DEPARTMENTS
-- DEPARTMENTS <-> LOCATIONS
-- 총 3개의 테이블을 조인


-- INNER JOIN 예제5
SELECT * FROM tblGenre;
SELECT * FROM tblVideo;
SELECT * FROM tblRent;

-- tblGenre, tblVideo
SELECT 
    *
FROM tblGenre G
    INNER JOIN tblVideo V
        ON G.SEQ = V.GENRE;

-- tblGenre + tblVideo + tblRent         
SELECT 
    *
FROM tblGenre G
    INNER JOIN tblVideo V
        ON G.SEQ = V.GENRE
            INNER JOIN tblRent R
                ON V.SEQ = R.VIDEO;        
                
 -- tblGenre + tblVideo + tblRent + tblMember        
SELECT 
    G.PRICE AS 대여가격,
    G.PERIOD AS 대여기간,
    V.NAME AS 비디오제목,
    M.NAME AS 회원명,
    R.RENTDATE AS 대여날짜,
    R.RENTDATE + G.PERIOD AS 반납마감날짜
FROM tblGenre G
    INNER JOIN tblVideo V
        ON G.SEQ = V.GENRE
            INNER JOIN tblRent R
                ON V.SEQ = R.VIDEO
                    INNER JOIN tblMember M
                        ON M.SEQ = R.MEMBER;      
                        



SELECT * FROM tblStaff; --5명, 부모 테이블
SELECT * FROM tblProject; --4건, 자식 테이블

-- INNER JOIN 예제6
-- : 2개의 테이블에 ON 조건을 만족하는 레코드만 반환
-- : 내부 조인의 결과는 대부분 자식 레코드 수만큼 나온다.
SELECT 
    *
FROM tblStaff S
    INNER JOIN tblProject P
        ON S.SEQ = P.STAFF_SEQ; --4개(자식 테이블의 개수)
        

-- INNER JOIN 예제7
-- 비디오 가게 사장
-- : 출근 > 어떤 회원? > 뭘 대여? > 반납 O, X 
SELECT
    M.NAME AS 이름,
    V.NAME AS 비디오제목,
    R.RETDATE AS 반납여부
FROM tblMember M
    INNER JOIN tblRent R
        ON M.SEQ = R.MEMBER
            INNER JOIN tblVideo V
                ON R.VIDEO = V.SEQ;
                
SELECT * FROM TBLMEMBER; --10
SELECT * FROM TBLVIDEO; --11
SELECT * FROM TBLRENT; --6 
--TBLMEMBER + TBLVIDEO -> TBLRENT


-- INNER JOIN 예제8
SELECT * FROM tblCustomer; --3명
SELECT * FROM tblSales; --9건

-- 신규 가입 회원은 아직 구매 이력이 없다. (*******)
INSERT INTO tblCustomer VALUES (4, '김과장', '010-7455-3594', '서울시');

-- 구매 이력과 구매 이력이 있는 회원 정보를 가져오세요.
-- --> 위에 신규 가입 회원('김과장')은 없다!!
SELECT * FROM tblCustomer C
    INNER JOIN tblSales S
        ON C.SEQ = S.CSEQ;
-- 그렇다면, 신규가입회원의 정보까지 가져오려면 어떻게 해야할까? -> OUTER JOIN



-- 3. 외부 조인, OUTER JOIN (******)

-- 구매 이력과 상관없이 모든 회원 정보를 가져오되, 구매 이력이 있으면 구매이력도 같이 가져오세요.
SELECT * FROM tblCustomer C 
    LEFT OUTER JOIN tblSales S 
        ON C.SEQ = S.CSEQ;
        
        
-- 대여기록 유무 이력과 상관없이 모든 회원 정보 + 대여기록        
SELECT
    M.NAME AS 이름,
    R.RENTDATE,
    R.RETDATE AS 반납여부
FROM tblMember M
    LEFT OUTER JOIN tblRent R
        ON M.SEQ = R.MEMBER;                


SELECT
    DISTINCT M.NAME AS 이름,
    CASE
        WHEN R.RENTDATE IS NOT NULL THEN '우량 회원'
        WHEN R.RENTDATE IS NULL THEN '불량 회원'
    END AS 종류
FROM tblMember M
    LEFT OUTER JOIN tblRent R
        ON M.SEQ = R.MEMBER
            ORDER BY 종류 DESC, NAME ASC;   

-- 어떤 비디오가 몇번 빌려갔는지?            
SELECT
    V.NAME,
    COUNT(R.RENTDATE) AS 대여횟수
FROM tblVideo V
    LEFT OUTER JOIN tblRent R
        ON V.SEQ = R.VIDEO
            GROUP BY V.NAME
                ORDER BY COUNT(R.RENTDATE) DESC, V.NAME ASC;
                

-- 4. 전체 외부 조인, FULL OUTER JOIN
SELECT * FROM tblMen;
SELECT * FROM tblWomen;

-- 커플인 남자와 여자를 가져오시오.
SELECT 
    M.NAME AS 남자, 
    W.NAME AS 여자 
FROM tblMen M
    INNER JOIN tblWomen W
        ON M.COUPLE = W.NAME;
        
-- 모든 남자 중에서 여자친구가 있으면 여자친구 이름도 같이 가져오시오.
SELECT 
    M.NAME AS 남자, 
    W.NAME AS 여자 
FROM tblMen M
    LEFT OUTER JOIN tblWomen W
        ON M.COUPLE = W.NAME;

-- 모든 여자 중에서 남자친구가 있으면 여자친구 이름도 같이 가져오시오.
SELECT 
    M.NAME AS 남자, 
    W.NAME AS 여자 
FROM tblMen M
    RIGHT OUTER JOIN tblWomen W
        ON M.COUPLE = W.NAME;
        
-- 모든 남자, 모든 여자 중에서 커플이 있으면 커플 이름도 같이 가져오시오.
SELECT 
    M.NAME AS 남자, 
    W.NAME AS 여자 
FROM tblMen M
    FULL OUTER JOIN tblWomen W
        ON M.COUPLE = W.NAME;


-- 5. 셀프 조인, SELF JOIN

-- 직원 테이블
CREATE TABLE tblSelf (

    SEQ NUMBER PRIMARY KEY,                                 --직원번호(PK)
    NAME VARCHAR2(30) NOT NULL,                             --직원명
    DEPARTMENT VARCHAR2(50) NULL,                            --부서명
    SUPER NUMBER NULL REFERENCES tblSelf(SEQ)               --상사번호(FK). 자기참조

);

INSERT INTO tblSelf VALUES (1, '홍사장', NULL, NULL);
INSERT INTO tblSelf VALUES (2, '김부장', '영업부', 1);
INSERT INTO tblSelf VALUES (3, '이과장', '영업부', 2);
INSERT INTO tblSelf VALUES (4, '정대리', '영업부', 3);
INSERT INTO tblSelf VALUES (5, '최사원', '영업부', 4);

INSERT INTO tblSelf VALUES (6, '박부장', '개발부', 1);
INSERT INTO tblSelf VALUES (7, '하과장', '개발부', 6);

SELECT * FROM tblSelf;

-- 직원명, 소속부서, 상사명을 가져오시오.
-- 재귀 형태
SELECT 
    S1.NAME AS "직원명",
    S1.DEPARTMENT AS "소속부서",
    S2.NAME AS "상사명"
FROM tblSelf S1 --직원(부하)
    INNER JOIN tblSelf S2 --상사
        ON S1.SUPER = S2.SEQ; --********** 중요
        

-- 사장까지 출력하기
SELECT 
    S1.NAME AS "직원명",
    S1.DEPARTMENT AS "소속부서",
    S2.NAME AS "상사명"
FROM tblSelf S1 --직원(부하)
    LEFT OUTER JOIN tblSelf S2 --상사
        ON S1.SUPER = S2.SEQ; --********** 중요
        