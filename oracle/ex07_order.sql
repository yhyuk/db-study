--EX07_ORDER.sql

/*

    [WITH <Sub Query>]
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING serach_condition]
    [ORDER BY order_expression [ASC|DESC]];
    
    정렬, Sort
    - ORDER BY절
    - 레코드 순서 정렬
    - 원본 테이블의 레코드 정렬(XXX) - RDBMS에 있는 테이블 내의 레코드 순서는 우리가 손댈 수 없다(절대!!)
    - 원본 테이블 -> SELECT -> 결과 테이블(결과셋)의 정렬(**********)
    - 오름차순, 내리차순
    - 특정 컬럼값을 기준으로 레코드를 정렬한다.
    
    SELECT 컬럼리스트
    FROM 테이블명
    WHERE 조건
    ORDER BY 정렬기준;

    정렬의 기준이 될 수 있는 자료형(컬럼의 자료형)
    1. 숫자형
        - 10 -> 20 -> 30
        - 30 -> 20 -> 10
    2. 문자형
        -'가' -> '나' -> '다'
        - 다' -> '나' -> '가'
    3.날짜시간형
        - '2019' -> '2020' -> '2021'
        - '2021' -> '2020' -> '2019'
        
        
    ********select를 구성하는 모든 절들은 실행 순서가 있다.(불변) -> 무조건 암기(이해)
    1. FROM
    2. WHERE
    3. SELECT
    4. ORDER BY

*/


SELECT
    LAST || FIRST AS NAME,
    WEIGHT
FROM TBLCOMEDIAN
ORDER BY WEIGHT DESC; --'ASC'ENDING, 'DESC'ENDING


--ORDER BY 대상 컬럼이 결과셋에 포함되지 않아도 상관X
SELECT
    LAST || FIRST AS NAME
FROM TBLCOMEDIAN
ORDER BY WEIGHT DESC; --ASCENDING, DESCENDING


SELECT                          --3. 원하는 컬럼만 선별
    LAST || FIRST AS NAME,
    WEIGHT,
    GENDER                    
FROM TBLCOMEDIAN                --1. 테이블 지정(전체 데이터)
WHERE GENDER = 'm'              --2. 원하는 레코드만 선별
ORDER BY WEIGHT DESC;           --4. 결과셋의 정렬    


--다중 정렬 예제
SELECT
    NAME, BUSEO, JIKWI, CITY
FROM TBLINSA
    --ORDER BY BUSEO ASC;                       --1차 정렬(기준 1개)
    --ORDER BY BUSEO ASC, JIKWI ASC;            --2차 정렬(기준 2개)
    ORDER BY BUSEO ASC, JIKWI ASC, CITY ASC;    --3차 정렬(기준 3개)
    --ORDER BY 2 ASC, 3, ASC, 4 ASC;            --첨자로 컬럼 지정 > 사용금지!! > 가독성 낮음

-------- 고정된 컬럼을 정렬 기준으로 사용

-------- 계산된 값을 정렬 기준으로 사용

--예제1.

SELECT
    NAME, BASICPAY, SUDANG, BASICPAY + SUDANG
FROM TBLINSA
    ORDER BY BASICPAY + SUDANG DESC; --***까먹기 쉬우니 짚고넘어가자, 이런 활용을 잘해야함
    
    
--예제2
SELECT
    NAME, SUDANG, JIKWI,
    CASE
        WHEN JIKWI IN ('부장', '과장') THEN SUDANG * 2
        WHEN JIKWI IN ('사원', '대리')  THEN SUDANG * 1.5
    END AS SUDANG2
FROM TBLINSA
    --ORDER BY SUDANG2 DESC;
    ORDER BY CASE
        WHEN JIKWI IN ('부장', '과장') THEN SUDANG * 2
        WHEN JIKWI IN ('사원', '대리')  THEN SUDANG * 1.5
    END DESC;


-- 꿀팁***********
-- 직위를 정렬(부장, 과장, 대리, 사원) --> 정렬안됨
SELECT 
    NAME, BUSEO, JIKWI
FROM TBLINSA
    ORDER BY JIKWI DESC;
    
--직위를 정렬(부장, 과장, 대리, 사원)
SELECT 
    NAME, BUSEO, JIKWI
--    CASE
--        WHEN JIKWI = '부장' THEN 1
--        WHEN JIKWI = '과장' THEN 2
--        WHEN JIKWI = '대리' THEN 3
--        WHEN JIKWI = '사원' THEN 4
--    END AS NO
FROM TBLINSA
    ORDER BY CASE
        WHEN JIKWI = '부장' THEN 1
        WHEN JIKWI = '과장' THEN 2
        WHEN JIKWI = '대리' THEN 3
        WHEN JIKWI = '사원' THEN 4
    END ASC;
