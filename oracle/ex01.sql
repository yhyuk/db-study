-- ex01.sql

--  단일라인 주석

/*
    다중라인주석
*/

/*
    오라클, Oracle
    - 회사명, 제품명
    - 데이터베이스(Database) -> 데이터베이스 관리 시스템(Database Management System. DBMS)
        -> 관계형 데이터베이스 관리 시스템(Relational DBMS, RDBMS)
    - 프로젝트 하실때 DBMS 뭐쓰심? -> Oracle 11g
    - 프로젝트 하실때 DB 클라이언트 뭐쓰심 ?  SQL Developer
*/

/*
    다운로드
    
    1.OracleXE112_Win64
    - 데이터베이스 프로그램(DBMS)
    
    2.sqldeveloper-20.4.1.407.0006-x64
    - 데이터베이스 클라이언트 프로그램

    데이터 Data
    - 가공된 정보
    
    데이터베이스, Database
    - 데이터의 집합
    - 데이터의 집합을 지원하는 프로그램
    - 오라클(Oracle)
    
    데이터베이스 관리 시스템, Database Management System
    - 데이터베이스 + 추가작업 -> 통합 시스템
    - 오라클(Oracle)
    
    <관리 시스템의 중요성>
    1. 데이터 무결성  
        - 데이터에 오류가 있으면 안된다.
        - 제약조건(Constraint)를 사용한다.
    
    2. 데이터 독립성
        - 데이터베이스에 변화가 발생하더라도 관계된 응용 프로그램들은 영향을 받지 않는다.
        
    3. 보안
        - 데이터베이스내의 데이터를 함부로 겁근 방지
        - 소유주나 접근권한이 있는 사용자만 접근 가능, 통제 가능
        
    4. 데이터 중복 최소화
        - 동일한 데이터가 여러곳에 여러번 저장되는 것을 방지한다.
        
    5. 데이터 안정성
        - 데이터 백업/복원 기능을 제공한다.
        
    <DBMS 종류>
    1. 계층형 DBMS
    2. 망형 DBMS
    3. 관계형 DBMS > 현재 가장많이 쓰이는 DBMS > 데이터를 '표' 형태로 저장/관리
    4. 객체지향형 DBMS
    5. 객체관계형 DBMS


    관계형 DB 관리 시스템 > 제품 종류
    1. Oracle
        - Oracle
        - 기업용 (개인용으로는 잘 안쓰임 > 비싸서...)
        
    2. MS-SQL
        - Microsoft
        - 기업용
        
    3. MySQL
        - Oracle
        - 개인용 + 기업용
        
    4. MariaDB
        - MySQL 기반
        - 무료
        - 개인용 + 기업용 
        
    5. PostgreSQL
        - 포스트그레스큐엘
        - 무료
        - 개인 + 기업용
        
    6. DB2
        - IBM
        - 메인프레임
    
    7. Access
        - MS
        - 개인용 + 소규모
    
    8. 티베로
        - 티맥스(TMax)
        
    9. SQLite
        - 경량
        - 모바일 등..  
    -------------------------------------------------------------------------------------------    
    Oracle
    - UI가 없는 프로그램(눈에 안보이는 프로그램, 서비스)    
    
    데이터베이스 클라이언트 프로그램
    - UI가 없는 오라클에 접속을 해서 > 조작을 도와주는 툴
      
     1. SQL Developer
        - 무료
        - Oracle
        
    2. Toad
        - 유료
        - 점유율 최상
        
    3. SQLGate
    
    4. DataGrip(JetBrain)
        - 30일 평가판 
        - 대학교 이메일(무료)
    
    5. Eclipse
    
    6. SQL*Plus
    - 오라클을 설치하면 자동으로 같이 설치되는 클라이언트 툴
    - CLI(Command Line Interface)
    ----------------------------------------------------------------------------------------------
    
    오라클 버전
    - Oracle 11g Express Edition
    - Oracle 1.0 ~ 21c
    
    오라클 에디션
    - Express Edition
        - 무료, 상용 가능(개발용), 기능제한
        - 11g XE, 18c XE
    - Enterprise Edition
        -상용
        
        
    오라클 설치
    -> 오라클이 잘 동작하고 있는지?
    -> 시작 or 종료?
    
    1. 실행창 > services.msc
    2. Oracle로시작하는 단어
        - OracleServiceXE 
            - 데이터베이스 프로그램
        - OracleXETNSListener
            - 오라클과 클라이언트 프로그램을 연결시켜 주는 프로그램
        - 위 2가지만 기본적으로 알고있자.
        - 항상 실행중으로 있어야함
        







    열려있는 파일(ex01.sql , localhost.system) 2개
    -> 스크립트 파일(*.sql), 워크 시트 파일(*.sql)
    -> 오라클(데이터베이스 서버)와 대화를 하기위한 작업(자바로 따지면 소스파일(*java))
    -> 문장 단위 실행
    
    스크립트 실행 방법
    -> 실행할 명령어(문장)을 선택한다.
    -> 실행: Ctrl + Enter
    -> 스크립트는 문장 단위로 실행한다.
    
    계정
    1. 관리자 계정 
        - sys.system
        
    2. 일반 사용자 계정
        - 권한이 일부 제한되어 있는 계정
        - 생성(나중에)
        - 학습용 계정 제공 > scott, hr(사용 금지 -> 해제)

*/

--계정이 잠겨있다. > 활성화
--alter user 계정명 account unlock;
alter user hr account unlock; --User HR이(가) 변경되었습니다.

--비밀번호 변경
alter user hr identified by java1234; --User HR이(가) 변경되었습니다.

--위에 계정명, 비밀번호를 합친 한줄로 작성한 코드
alter user hr account unlock identified by java1234;

--내가 지금 system(관리자)인지, hr(일반 사용자)인지 구분하는법?

--방법1 tabs 확인하기
--system -> 154 line 오른쪽 상단 드럼통을 localhost.system을 hr로 변경 후 
--hr -> 7 line
select * from tabs;


--방법2 사용자 확인하기
show user;

--결론: 오른쪽 상단 드럼통을 잘 확인합시다!! 실수 많이함!!



/*

    관계형 DB
    - 데이터를 표형태로 저장/관리 한다.
    - 데이터끼리의 관계를 관리한다.
    - 표(테이블)의 집합
        테이블 
        - 열(컬럼)의 집합 > 테이블의 구조 > 스키마(Schema)
    
        열, Column
        - 컬럼, 필드(Field), 속성(Attribute), 특성(Property)
        - 세부정보
    
        행, Row
        - 행, 로우, 레코드(Record), 튜플(Tuple)
        - 테이블의 실체화된 데이터 1건
        - Object(객체)
    
    SQL, Structured Query Language
    - 구조화된 질의 언어
    - 사용자(클라이언트 툴)가 관계형 데이터베이스와 대화할 때 사용하는 언어
    - 자바에 비해 자연어에 가깝다.
    
    1. DBMS 제작사와 독립적이다.
    - SQL은 모든 DBMS에 공통이다.
    
    2. 표준 SQL(ANSI-SQL)
    - 모든 DBMS는 표준 SQL를 지원하도록 설계되어 있다.
    - SQL-86 ... SQL92... SQL-2011
    
    3. 대화식 언어다.
    - 질문 > 답변 > 질문 > 답변 > 질문...    
        

    SQL(오라클 기준)
    1. ANSI SQL
        - 표준 SQL

    2. PL/SQL
        - 자체 SQL
        - 오라클에서만 동작되는 명령어
        
    
    
    <ANSI SQL 종류>
    - 명령어들을 성격에 따라 분류
    1. DDL(데이터 정의어)
        - Data Definition Language
        - 구조를 만드는 언어
        - 테이블, 뷰, 사용자, 인덱스 등의 객체(DB Object)를 생성, 수정, 삭제 하는 명령어
        - DB 관리자, DB 담당자, 프로그래머(일부)만 사용.. 
        - create(읽기), drop(삭제), alter(수정)
    
    2. DML(데이터 조작어)
        - Data Manipulation Language
        - 데이터베이스의 데이터를 추가, 수정, 삭제, 조회하는 명령어
        - DB 관리자, DB 담당자, 프로그래머(일부)만 사용..
        - select(읽기), insert(추가), update(수정), delete(삭제)
        - select(읽기)가 가장 중요하다 **********************
    
    3. DCL(데이터 제어어)
        - Data Control Language
        - 계정, 보안, 트랜잭션 등을 제어
        - DB 관리자, DB 담당자, 프로그래머(일부)만 사용..
        - commit, rollback, grant, revoke
        
    4. DQL(데이터 질의어)
        - Data Query Language
        - DML 중에 select만을 이렇게 따로 칭한다.
        
    5. TCL
        - Transaction Control Language
        - DCL 중에 commit, rollback만을 이렇게 따로 칭한다.
        
        
    <오라클 기본 인코딩>
    - ~ 8i : EUC-KR
    - 9i ~ : UTF-8

*/

--현재 계정(HR)이 소유하고 있는 테이블 목록을 보여주세요
--SQL은 키워드의 대소문자를 구분하지 않는다.(보통 대문자로 많이쓴다.)
select * from tabs;
SELECT * FROM tabs;

