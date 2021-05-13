--ex03_select.sql

/*

    select문
    - DML, DQL
    - 데이터베이스로부터 원하는 데이터를 가져오는 명령어(읽기)
    
    select
    
    [WITH <Sub Query>]
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING serach_condition]
    [ORDER BY order_expression [ASC|DESC]];
    
    SELECT column_list
    FROM table_name;
    
    **** select를 구성하는 모든 절들은 실행 순서가 있다.(불변) -> 무조건 암기(이해)
    1. FROM절
    2. SELECT절
    
    SELECT 컬럼리스트 -- 데이터를 가져올 컬럼을 지정한다.
    FROM 테이블명; --데이터를 가져올 테이블을 지정한다.
        

*/

--hr -> 샘플(테이블+데이터) 제공
--현재 계정이 소유하고 있는 테이블 목록 가져오기
select * from tabs;

--select문 작성 -> 실행 -> 서버 전달 -> 처리 -> 결과값 반환 -> 클라이언트 반환 -> 결과값 -> ResultSet

--full select(모든 정보 선택)
select * --2. 어떤 컬럼을 가져올거냐? -> *(wildcard) 모든 컬럼
from employees; --1. employees테이블로부터 데이터를 가져오겠다.


--만약 원하는 정보만 가져오고자 할때는 이름 입력
select first_name
from employees;

--여러개의 정보를 가져올땐 콤마로 구분하기
select first_name, last_name, salary, department_id, email
from employees;


--자주나는 오타에러 ORA-00942: table or view does not exist
select *
from employee;

--자주나는 오타에러 ORA-00904: "FIRSTNAME": invalid identifier
select firstname
from employees;

-- 만약 tblCountry을 처음봤음 -> tblCountry 구조? -> 구조(칼럼 구성) 확인
select *
from tblCountry; --방법1

desc tblCountry; --방법2, 표준SQL은아님.. > Sql*plus(전용명령어) > SQL Developer(SQLplus명령어 지원)

--방법3, 오른쪽 접속 버튼에 테이블 > tblCountry > 구조확인.



--동일한 컬럼을 여러번 반복해도 된다. but. 쓸일이있을까..? 이유는 밑 ㄱㄱ
select name, name
from tblCountry;

--동일한 컬럼을 여러번 가져오는 경우.. 가공을한다
select name, '나라명: ' || name -- '||' (문자열 더하기 연산자 -> concat 연산자)
from tblCountry;





select *
from tblCountry; --A 와일드카드(*) 전체선택

select name, capital, population, continent, area
from tblCountry; --B 칼럼구성명 직접 전부 작성
--A와 B의 결과는 동일 > B 권장 > 가독성




desc tblCountry;

--원본 테이블의 컬럼 순서와 select절의 컬럼 순서는 전혀 무관하다.
-->보통 지키는 경우가 많다. > 가독성
select capital, population, continent, area, name
from tblCountry;