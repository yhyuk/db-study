--ex11_datetime_function.sql

/*

    날짜시간 함수
    
    sysdate
    - 현재 시스템의 시각을 반환
    - date sysdate
    - 자바의 Calendar.getInstance(), new Date()

*/

SELECT SYSDATE FROM DUAL;

/*

    날짜 연산(+, -)
    1. 시각 - 시각 = 시간(단위: 일)
    2. 시각 + 시간 = 시각
    3. 시각 - 시간 = 시각

*/

-- 1.시각 - 시각
SELECT
    NAME, 
    IBSADATE AS 입사일,
    SYSDATE AS 현재,
    ROUND(SYSDATE - IBSADATE) AS "근무기간(일)", -- 홍길동 08/10/11  -  21/05/17   = 4601
    ROUND((SYSDATE - IBSADATE) * 24) AS "근무기간(시)",
    ROUND((SYSDATE - IBSADATE) * 24 * 60) AS "근무기간(분)",
    ROUND((SYSDATE - IBSADATE) * 24 * 60 * 60) AS "근무기간(초)",
    ROUND((SYSDATE - IBSADATE) / 365 ) AS "근무기간(년)" -- 근사치...
FROM TBLINSA;

-- 2. 시각 + 시간(단위: 일) = 시각
-- 3. 시각 - 시간(단위: 일) = 시각
SELECT
    SYSDATE,
    SYSDATE + 100,
    SYSDATE - 100,
    SYSDATE + (2 / 24) -- 2시간 뒤?
FROM DUAL;


/*

    LAST_DAY()
    - 해당 시각이 포함된 달의 마지막 날짜
    - DATE LAST_DAY(DATE)

*/
SELECT
    SYSDATE, -- 21/05/17
    LAST_DAY(SYSDATE), -- 21/05/31
    NEXT_DAY(SYSDATE, '수요일')
FROM DUAL;


/*

    MONTHS_BETWEEN()
    - 시각 - 시각 = 시간(단위: 일) --> 위에서 했는데..?
    - 시각 - 시각 = 시간(단위: 월) --> 이 함수는 월을 알려준다.
    - NUMBER MONTHS_BETWEEN(DATE, DATE)

*/
SELECT
    NAME,
    IBSADATE AS 입사일,
    SYSDATE - IBSADATE AS "근무시간(일)",
    (SYSDATE - IBSADATE) / 30.4 AS "근무시간(월)",      -- 방법1
    MONTHS_BETWEEN(SYSDATE, IBSADATE) AS "근무시간(월)", -- 방법2, 정확한 값을 반환하므로, 이 방법을 써야한다.
    (SYSDATE - IBSADATE) / 365 AS "근무시간(년)", -- 방법1
    MONTHS_BETWEEN(SYSDATE, IBSADATE) / 12 AS "근무시간(년)" -- 방법2, 이 방법을 써야한다.
FROM TBLINSA;

/*

    ADD_MONTHS()
    - NUMBER ADD_MONTHS(DATE, NUMBER)

*/
SELECT
    SYSDATE,
    SYSDATE+31, --사용금지
    ADD_MONTHS(SYSDATE, 1), --1월달 추가 
    SYSDATE + 100, -- 100일 뒤
    ADD_MONTHS(SYSDATE, 12) -- 첫돌
FROM DUAL;

/*

    날짜시간 총 정리!

    시각 - 시각 = 일(시, 분, 초)
    시각 - 시각 = 월(년) -> (MONTHS_BETWEEN)
    
    시각 + 시각(일) = 시각
    시각 - 시각(일) = 시각
    시각 + 시간(월) = 시각 --> ADD_MONTHS()
    시각 + 시간(월) = 시각 --> ADD_MONTHS()
    
*/

-- 컬럼 리스트에서 사용
-- 조건절에서 사용
-- 정렬에서 사용
SELECT
    NAME,
    IBSADATE,
    CEIL(MONTHS_BETWEEN(SYSDATE, IBSADATE) / 12) AS 근무년차
FROM TBLINSA
    WHERE MONTHS_BETWEEN(SYSDATE, IBSADATE) < (12*10); -- 10년차 근무자?