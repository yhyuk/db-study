--ex04_operator.sql

/*

    연산자, Operator
    
    1. 산술 연산자
        - +, -, *, /
        - %(없음) -> 함수로 제공(mod() 함수)
    
    2. 문자열 연산자
        - concat
        - '문자열' + '문자열' (X)
        - '문자열' || '문자열' (O)

    3. 비교 연산자
        - >, >=, <, <=
        - =(같다), <>(다르다) --> ==(X), != (X)
        - 논리값을 반환 > boolean 반환 > ANSI SQL은 논리형이 없다. > 표현이 불가능 > 결과셋에 담을 수 없다.
        - 조건에만 사용

*/

--산술 연산자 + 문자열 연산자 + 상수 컬럼

-- 1.weight+2를 하고 확인하면 증가된걸 확인 할 수 있다.
-- -->그렇다고 테이블이 수정된 것이 아니다!!(주의)

-- 2.컬럼에 없는 상수 컬럼(10+1, '자바')을 추가해도 상관없다(종종 쓰임)
select first, last, last || first, weight+2, 10+1, '자바'
from tblComedian;

select 10, '자바'
from tblComedian;

-- 3. '+'는 오라클에서 상수값에만 할수있다. (문자열 금지)
select last || first from tblComedian;
select concat(last, first) from tblComedian; --concat을 이용해서 '||'와 동일한 값을 가질 수도 있다.
select last + first from tblComedian; --ORA-01722: invalid number


--비교 연산자
-- 1.비교 연산의 결과는 논리형 > 논리형이 없어서 결과셋에 담지를 못한다.(표현을 못한다)
---> 비교 연산은 컬럼 리스트에 작성할 수 없다.(select절에 넣지 말것!)
select first, weight > 65 from tblComedian; --ERROR

-- 2.where절에는 조건가능(where는 추후 배울 예정..)
select first, weight from tblComedian where weight > 65;


--NAME(이름), WEIGHT(몸무게), WEIGHT-5(목표몸무게)
--컬럼명 -> 식별자 -> weight or weight-5 > weight-5로 나오는건 불편하다.(쓰면안된다.)
select name, weight, weight-5 from tblMen;

--컬럼의 별칭(Alias) 만들기
-- 1. 중복된 컬럼명을 구분하기 위해서
-- 2. 가공된 컬럼명을 유효하기 위해서
-- 3. 사용 불가능한 문자를 사용할 수 있게 > 사용하지 말것!!!!
-- 4. 예약어를 사용할 수 있게 > 절대 사용하지 말것 !!!
-- 별칭: 영어 + 숫자 + '_' --> 조합

select name, name as nick from tblMen; --1. 중복된 컬럼명
select last || first as name, weight-5 as weight from tblComedian; --2. 가공된 컬럼명을 유효하기 위해서
select name as 사용자이름 from tblMen;
select name as "사용자 이름" from tblMen; --3. 사용 불가능한 문자(사용하지 말것!!!)
select name as "select" from tblMen; --4. 예약어를 사용(절대 사용하지 말것 !!!)