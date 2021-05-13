--ex05_where.sql

/*

    **** select를 구성하는 모든 절들은 실행 순서가 있다.(불변) -> 무조건 암기(이해)
    1. FROM절
    2. SELECT절

    SELECT column_list
    FROM table_name
    WHERE search_condition;

    SELECT 컬럼리스트
    FROM 테이블명
    WHERE 검색조건;
    ---------------------------------------------------------------------------------
    
    [ WHERE절 ]
    - 가져올 레코드를 지정할 조건을 명시한다.
    - 조건에 만족하는 행은 결과셋에 포함되고, 만족하지 못하는 행은 결과셋에 포함되지 않는다.
    - 행 단위로 걸러낸다.
    - 주로 조건을 비교 연산자 or 논리 연산자를 사용해서 구성한다.
    
*/

--컬럼(열) 선택 가능 + 레코드(행) 선택 불가 > 항상 14개의 레코드 반환
select *
from tblCountry
where capital = '서울';

select *
from tblCountry
where area > 20;

select * from tblInsa where city = '서울'; -- 60명중 20명
select * from tblInsa where buseo = '영업부'; -- 60/16
select * from tblInsa where basicpay >= 2500000; -- 60/6
select name, buseo, jikwi, basicpay from tblInsa where basicpay >= 2500000; -- 원하는 행+열

select * from tblInsa
    where city = '서울'; --같은것
    
select * from tblInsa
    where city <> '서울'; --다른것

-- 논리 연산자
-- - 오라클에서는 알파벳으로 써야함
-- - and(&&), or(||), not(!)
select * from tblInsa
    where city = '서울' or buseo = '영업부';
    
select * from tblInsa
    -- where city <> '서울';
    where not (city = '서울'); --서울이 아닌것을 출력 잘하지만 이런식으로 잘 사용안함 ->이유: <> 쓰면됨


-- tblComedian
-- 몸무게가 60kg 이상이고, 키가 170cm 미만인 사람을 가져오시오.
select * from tblComedian;
select * from tblComedian where weight >= 60 and height < 170;

-- tblInsa
-- 급여(basicpay)와 수당(sudang)을 모두 합한 금액이 200만원 이상인 직원을 적으시요.
select * from tblInsa where (basicpay + sudang) > 2500000;


/*

    between절
    - where절에서 사용 > 조건으로 사용
    - 범위 조건으로 사용
    - 칼럼명 between 최솟값 and 최댓값
    - 연산자 사용보다 가독성 향상(성능 더 느림)
    - 최솟값, 최댓값 -> 포함(inclusive)
*/

-- 몸무게가 60~70kg 사이에 있는 사람?
-- 방법1와 방법2는 똑같다. 가독성차이(between)
select last || first as name, weight from tblComedian;
select last || first as name, weight from tblComedian
    where weight >= 60 and weight <= 70;    --방법1
select last || first as name, weight from tblComedian
    where weight between 64 and 66;         --방법2
    

-- 비교 연산에 사용되는 자료형
-- 1. 숫자형(number)
desc tblInsa; -- sudang이 number(10)으로 되어있는걸 확인
select name, sudang from tblInsa
    where sudang > 150000;

select name, sudang from tblInsa
    where sudang >= 150000 and sudang <= 160000;--방법1
select name, sudang from tblInsa
    where sudang between 150000 and 160000;     --방법2


-- 2. 문자형
-- - 자바: char(O), string(X)
-- -       c > 'a'  "홍길동" > "아무개"
select name from tblInsa
    where name > '박';
select first_name from employees 
    where first_name > 'M';
select first_name from employees 
    where first_name >= 'M' and first_name <= 'O';
select first_name from employees 
    where first_name between 'M' and 'O';


-- 3. 날짜/시간형
-- - 자바: Calendar > Calendar -> tick > tick
desc tblInsa;
select ibsadate from tblInsa 
    where ibsadate > '2010-01-01';
select ibsadate from tblInsa 
    where ibsadate <= '2010-01-01';
select ibsadate from tblInsa 
    where ibsadate >= '2010-01-01' and ibsadate <= '2010-12-31';
select ibsadate from tblInsa 
    where ibsadate between '2010-01-01' and '2010-12-31';    
    
    
    
/*

    in
    - where절에서 사용 > 조건으로 사용
    - 열거형 조건 > 제시된 조중 하나라도 일치하면 만족
    - 칼럼형 in (값, 값, 값, ... 값)
    - 가독성 향상

*/

-- tblInsa 
-- 홍보부 + 개발부  + 총무부
select * from tblInsa;
select * from tblInsa where  buseo = '홍보부';
select * from tblInsa where  buseo = '홍보부' or buseo = '개발부' or buseo = '총무부'; --27명
select * from tblInsa where  buseo in ('홍보부', '개발부', '총무부'); --27명

-- (부장,과장) + (서울,인천) + 급여(250~260만원)
select * from tblInsa 
    where jikwi in ('부장', '과장') and city in ('서울', '인천')
            and basicpay between 2500000 and 2600000;


/*

    like
    - where절에서 사용 > 조건으로 사용
    - 패턴 비교(정규 표현식과 유사)
    - 문자형을 대상으로 동작(숫자형, 날짜형은 적용 불가)
    - 칼럼명 like '패턴 문자열'
    
    패턴 문자열 구성 요소
    1. _ : 임의의 문자 1개 -> "."
    2. % : 임의의 문자 N개(N: 0 ~ 무한대) -> ".*", ".{0,}"
    
*/

--예제1
select name from tblInsa;
select name from tblInsa where name like '홍길동';
select name from tblInsa where name = '홍길동';
select name from tblInsa where name like '홍__'; --홍OO
select name from tblInsa where name like '__신'; --OO신
select name from tblInsa where name like '_길_'; --O길O
select name from tblInsa where name like '김___'; --김OOO
select name from tblInsa where name like '김_'; --김O

--예제2
select first_name from employees;
select first_name from employees where first_name like 'E____'; -- Ellen, Eleni
select first_name from employees where first_name like 'E%'; --E로 시작되는
select first_name from employees where first_name like '%e'; --e로 끝나는
select first_name from employees where first_name like '%e%'; --e가 들어간
select first_name from employees where first_name like '%ea%'; --ea가 들어간
select first_name from employees where first_name like '%e%a%'; --e랑a가 들어간



/*

    RDBMS에서의 NULL
    - 자바의 NULL 개념과 유사
    - 컬럼값이 비어있는 상태(셀)
    - NULL 상수 
    - 대다수의 언어는 NUll을 피연산자로 사용할 수 없다.
    
    NULL 조건
    - WHERE절 사용 > 조건으로 사용
    - 컬럼명 IS NULL
    - 컬럼명 IS NOT NULL

*/

--예제1, 국가별 나라
SELECT * FROM tblCountry;
    
--인구수가 기재되지 않은나라?
SELECT * FROM tblCountry 
    WHERE population = null; --null을 피연산자로 X
SELECT * FROM tblCountry 
    WHERE POPULATION IS NULL;

--인구수가 기재된 나라?
SELECT * FROM tblCountry 
    WHERE POPULATION <> NULL; --null을 피연산자로 X
SELECT * FROM tblCountry 
    WHERE NOT POPULATION IS NULL; --방법1
SELECT * FROM tblCountry 
    WHERE POPULATION IS NOT NULL; --방법2, 더 많이사용됨.


-- 예제2, 할일
SELECT * FROM tblTodo;

-- 아직 실행하지 못한 일은?
SELECT * FROM tblTodo 
    WHERE COMPLETEDATE IS NULL;

-- 실행 완료한 일은?
SELECT * FROM tblTodo 
    WHERE COMPLETEDATE IS NOT NULL;


-- 도서 대여 테이블(대여 날짜, 반납 날짜)
-- 아직 반납이 안된 대여 기록?
SELECT * FROM 도서대여 WHERE 반납날짜 IS NULL;
-- 반납 완료된 대여 기록?
SELECT * FROM 도서대여 WHERE 반납날짜 IS NOT NULL;


-- 남자 중 커플있는 컬럼, 있는 컬럼
SELECT * FROM tblMen WHERE COUPLE IS NULL;
SELECT * FROM tblMen WHERE COUPLE IS NOT NULL;
-- 여자 중 커플있는 컬럼, 있는 컬럼
SELECT * FROM tblWomen WHERE COUPLE IS NULL;
SELECT * FROM tblWomen WHERE COUPLE IS NOT NULL;
