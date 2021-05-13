--EX06_COLUMN.sql

/*

    distinct , DISITINCT
    - 컬럼 리스트에 사용
    - 중복값을 제거한다.
    - DISTINCT 컬럼명

*/

SELECT * FROM tblCountry;

-- tblCountry. 어떤 대륙? -> 분류 질문
SELECT CONTINENT FROM tblCountry;           --각 나라들의 대륙이 여러번(중복)으로 나옴
SELECT DISTINCT CONTINENT FROM tblCountry;  --중복제거

SELECT * FROM tblInsa;

-- tblInsa. 어떤 부서?
SELECT BUSEO FROM tblInsa;          --여러번..
SELECT DISTINCT BUSEO FROM tblInsa; --중복제거

--중복값이 단 1개도 없어도 동작된다.
--중복값이 없는 컬럼에 DISTINCT를 적용하는건 의미없다.
SELECT DISTINCT NAME FROM tblInsa; 


-- 1개의 캘럼 중복값 검사와 다른 하나의 캘럼을 출력하려면?
-- EX) DISTINCT BUSEO, NAME 한다면 BUSEO만 검사하는게 아니라 NAME까지 같이한다.
-- --> 출력 행 전체가 중복값이 있다는 가정하에 2개의 캘럼을 묶어서 봐야한다.
-- --> BUSEO, NAME이 아니라, BUSEO + NAME 이라고 생각하자..

-- tblInsa. 어떤 부서 + 이름 ?
SELECT DISTINCT BUSEO, NAME FROM tblInsa; --60명 그대로 출력

-- tblInsa. 어떤 부서 + 직위 ?
SELECT BUSEO, JIKWI FROM tblInsa; --60명 그대로 출력
SELECT DISTINCT BUSEO, JIKWI FROM tblInsa; --23명
