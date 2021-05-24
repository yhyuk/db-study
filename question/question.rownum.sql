--1. tblInsa. 남자 급여(기본급+수당)을 (내림차순)순위대로 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
SELECT M.*, ROWNUM FROM 
(SELECT 
    NAME, BUSEO, JIKWI, BASICPAY+SUDANG
FROM TBLINSA 
    WHERE SUBSTR(SSN, 8, 1)=1 
        ORDER BY BASICPAY+SUDANG DESC) M;

--2. tblInsa. 여자 급여(기본급+수당)을 (오름차순)순위대로 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
SELECT W.*, ROWNUM FROM 
(SELECT
    NAME, BUSEO, JIKWI, BASICPAY+SUDANG
FROM TBLINSA
    WHERE SUBSTR(SSN, 8, 1) = 2 
        ORDER BY BASICPAY+SUDANG ASC) W;
    
--3. tblInsa. 여자 인원수가 가장 많은 부서 및 인원수 가져오시오.
--로우넘 3번 문제에서 가장 많은 부서가 2개 나오는데 그 중 아무거나 가져와도 됩니다~
SELECT 
    *
FROM (SELECT BUSEO, COUNT(*) FROM TBLINSA WHERE SUBSTR(SSN, 8, 1) = '2' GROUP BY BUSEO ORDER BY COUNT(*) DESC)
    WHERE ROWNUM = 1;

--4. tblInsa. 지역별 인원수 (내림차순)순위를 가져오시오.(city, 인원수)
SELECT C.*, ROWNUM FROM (SELECT CITY, COUNT(*)
FROM TBLINSA
    GROUP BY CITY
        ORDER BY COUNT(*) DESC) C;

--5. tblInsa. 부서별 인원수가 가장 많은 부서 및 인원수 출력.
SELECT
    *
FROM (SELECT BUSEO, COUNT(*) FROM TBLINSA GROUP BY BUSEO ORDER BY COUNT(*) DESC)
    WHERE ROWNUM=1;

--6. tblInsa. 남자 급여(기본급+수당)을 (내림차순) 3~5등까지 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
SELECT * FROM 
(SELECT S.*, ROWNUM AS RNUM FROM 
(SELECT 
    NAME, BUSEO, JIKWI, BASICPAY+SUDANG 
FROM TBLINSA
    WHERE SUBSTR(SSN, 8, 1) = 1 
        ORDER BY BASICPAY+SUDANG DESC) S) WHERE RNUM BETWEEN 3 AND 5;

--7. tblInsa. 입사일이 빠른 순서로 5순위까지만 가져오시오.

SELECT * FROM 
(SELECT 
    *
FROM TBLINSA 
    ORDER BY IBSADATE ASC) S
    WHERE ROWNUM <= 5;

--8. tblhousekeeping. 지출 내역(가격 * 수량) 중 가장 많은 금액을 지출한 내역 3가지를 가져오시오.
SELECT S.* FROM
(SELECT 
    ITEM, PRICE*QTY AS SPENDING
FROM TBLHOUSEKEEPING
    ORDER BY SPENDING DESC) S
    WHERE ROWNUM <=3;


--9. tblinsa. 평균 급여 2위인 부서에 속한 직원들을 가져오시오.
SELECT *
FROM TBLINSA
    WHERE BUSEO = 
        (SELECT BUSEO FROM 
        (SELECT S.BUSEO, ROWNUM AS RNUM FROM 
        (SELECT
            BUSEO,
            ROUND(AVG(BASICPAY)) AS RESULT
        FROM TBLINSA
            GROUP BY BUSEO
                ORDER BY RESULT DESC) S)
                    WHERE RNUM = 2);

--10. tbltodo. 등록 후 가장 빠르게 완료한 할일을 순서대로 5개 가져오시오.
SELECT * FROM 
(SELECT *
FROM TBLTODO
    ORDER BY COMPLETEDATE ASC) WHERE ROWNUM <=5;


--32. tblInsa. 남자 직원 중에서 급여를 3번째로 많이 받는 직원과 9번째로 많이 받는 직원의 급여 차액은 얼마?
SELECT 
    BASICPAY - 
    (SELECT BASICPAY FROM
    (SELECT BASICPAY, ROWNUM AS RNUM FROM
    (SELECT BASICPAY
     FROM TBLINSA
         WHERE SUBSTR(SSN, 8, 1) = 1
             ORDER BY BASICPAY DESC)) WHERE RNUM = 9) AS "차액"
FROM TBLINSA
    WHERE BASICPAY = 
    (SELECT BASICPAY FROM
    (SELECT BASICPAY, ROWNUM AS RNUM FROM
    (SELECT BASICPAY
    FROM TBLINSA
        WHERE SUBSTR(SSN, 8, 1) = 1
            ORDER BY BASICPAY DESC)) WHERE RNUM = 3);
--2540000
--2300000

--70. employees, departments. 커미션(commission_pct)을 가장 많이 받은 상위 4명의 
-- 부서명(department_name), 사원명 (first_name), 급여(salary), 커미션(commission_pct) 정보를 가져오시오. 
-- 결과는 커미션 을 많이 받는 순서로 가져오되 동일한 커미션에 대해서는 급여가 높은 사원을 먼저 정렬하시오.
SELECT C.* FROM (
(SELECT 
    E.FIRST_NAME,
    E.SALARY,
    E.COMMISSION_PCT,
    S.DEPARTMENT_NAME
FROM EMPLOYEES E
    INNER JOIN DEPARTMENTS S
        ON E.DEPARTMENT_ID = S.DEPARTMENT_ID
    WHERE COMMISSION_PCT IS NOT NULL
        ORDER BY COMMISSION_PCT DESC, SALARY DESC) C) WHERE ROWNUM <= 4;
