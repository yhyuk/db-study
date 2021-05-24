--question.join.sql


-- 5. tblMen. tblWomen. 서로 짝이 있는 사람 중 남자와 여자의 정보를 모두 가져오시오.
--    [남자]        [남자키]   [남자몸무게]     [여자]    [여자키]   [여자몸무게]
--    홍길동         180       70            장도연     177        65
--    아무개         175       null          이세영     163        null
--    ..
SELECT 
    M.NAME,
    M.HEIGHT,
    M.WEIGHT,
    W.NAME,
    W.HEIGHT,
    W.WEIGHT
FROM TBLMEN M
    INNER JOIN TBLWOMEN W
        ON M.COUPLE = W.NAME;

-- 23. tblStaff, tblProject. 현재 재직중인 모든 직원의 이름, 주소, 월급, 담당프로젝트명을 가져오시오.
SELECT
    S.NAME,
    S.ADDRESS,
    S.SALARY,
    P.PROJECT
FROM TBLSTAFF S
    FULL OUTER JOIN TBLPROJECT P
        ON S.SEQ = P.STAFF_SEQ;

-- 24. tblVideo, tblRent, tblMember. '뽀뽀할까요' 라는 비디오를 빌려간 회원의 이름은?
SELECT 
    M.NAME
FROM TBLVIDEO V
    INNER JOIN TBLRENT R
        ON V.SEQ = R.VIDEO AND V.NAME = '뽀뽀할까요'
            INNER JOIN TBLMEMBER M
                ON R.MEMBER = M.SEQ;

-- 25. tblStaff, tblProejct. '노조협상'을 담당한 직원의 월급은 얼마인가?
SELECT
    S.NAME,
    S.SALARY
FROM TBLSTAFF S
    INNER JOIN TBLPROJECT P
        ON S.SEQ = P.STAFF_SEQ AND P.PROJECT = '노조협상';

-- 26. tblVideo, tblRent, tblMember. '털미네이터' 비디오를 한번이라도 빌려갔던 회원들의 이름은?
SELECT
    M.NAME
FROM TBLVIDEO V
    INNER JOIN TBLRENT R
        ON V.SEQ = R.VIDEO AND V.NAME = '털미네이터'
            INNER JOIN TBLMEMBER M
                ON R.MEMBER = M.SEQ;

-- 27. tblStaff, tblProject. 서울시에 사는 직원을 제외한 나머지 직원들의 이름, 월급, 담당프로젝트명을 가져오시오.
SELECT
    S.NAME,
    S.SALARY,
    P.PROJECT
FROM TBLSTAFF S
    INNER JOIN TBLPROJECT P
        ON S.SEQ = P.STAFF_SEQ AND S.ADDRESS <> '서울시';

-- 28. tblCustomer, tblSales. 상품을 2개(단일상품) 이상 구매한 회원의 연락처, 이름, 구매상품명, 수량을 가져오시오.
SELECT
    C.TEL,
    C.NAME,
    S.ITEM,
    S.QTY
FROM TBLCUSTOMER C
    INNER JOIN TBLSALES S
        ON C.SEQ = S.CSEQ;

SELECT * FROM TBLCUSTOMER;
SELECT * FROM TBLSALES;

-- 29. tblVideo, tblRent, tblGenre. 모든 비디오 제목, 보유수량, 대여가격을 가져오시오.
SELECT 
    V.NAME,
    V.QTY,
    G.PRICE
FROM TBLVIDEO V
    FULL OUTER JOIN TBLRENT R
        ON V.SEQ = R.VIDEO
            INNER JOIN TBLGENRE G
                ON V.GENRE = G.SEQ;
                
-- 30. tblVideo, tblRent, tblMember, tblGenre. 2007년 2월에 대여된 구매내역을 가져오시오. 회원명, 비디오명, 언제, 대여가격
SELECT
    M.NAME,
    V.NAME,
    R.RENTDATE,
    G.PRICE
FROM TBLVIDEO V
    INNER JOIN TBLRENT R
        ON V.SEQ = R.VIDEO AND TO_CHAR(RENTDATE, 'YY/MM') = '07/02'  
            INNER JOIN TBLMEMBER M
                ON R.MEMBER = M.SEQ 
                    INNER JOIN TBLGENRE G
                        ON V.GENRE = G.SEQ;

-- 31. tblVideo, tblRent, tblMember. 현재 반납을 안한 회원명과 비디오명, 대여날짜를 가져오시오.
SELECT
    M.NAME,
    V.NAME,
    R.RENTDATE
FROM TBLVIDEO V
    INNER JOIN TBLRENT R
        ON V.SEQ = R.VIDEO AND R.RETDATE IS NULL  
            INNER JOIN TBLMEMBER M
                ON R.MEMBER = M.SEQ 
                    INNER JOIN TBLGENRE G
                        ON V.GENRE = G.SEQ;
                        

-- 33. employees, departments. 
-- 사원들의 이름, 부서번호, 부서명을 가져오시오.

-- 34. employees, jobs. 
-- 사원들의 정보와 직위명을 가져오시오.

-- 35. employees, jobs. 
-- 직무(job_id)별 최고급여(max_salary) 받는 사원 정보를 가져오시오.

-- 36. departments, locations. 모든 부서와 각 부서가 위치하고 있는 도시의 이름을 가져오시오.

-- 37. locations, countries. location_id 가 2900인 도시가 속한 국가 이름을 가져오시오.

-- 38. employees. 급여를 12000 이상 받는 사원과 같은 부서에서 근무하는 사원들의 이름, 급여, 부서번호를 가져오시오.

-- 39. employees, departments. locations.  'Seattle'에서(LOC) 근무하는 사원의 이름, 직위, 부서번호, 부서이름을 가져오시오.

-- 40. employees, departments. first_name이 'Jonathon'인 직원과 같은 부서에 근무하는 직원들 정보를 가져오시오.

-- 41. employees, departments. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을 출력하는데 월급이 3000이상인 사원을 가져오시오.

-- 42. employees, departments. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름, 월급을 가져오시오.

-- 43. employees, departments. 모든 부서의 정보를 가져오되 부서장이 있는 부서는 부서장의 정보도 같이 가져오시오.

-- 44. departments, job_history. 퇴사한 사원의 입사일, 퇴사일, 근무했던 부서 이름을 가져오시오.

-- 45. employees. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호', '사원이름', '관리자번호', '관리자이름'으로 하여 가져오시오.

-- 46. employees, jobs. 직책(Job Title)이 Sales Manager인 사원들의 입사년도와 입사년도(hire_date)별 평균 급여를 가져오시오. 년도를 기준으로 오름차순 정렬.

-- 47. employees, departments. locations. 각 도시(city)에 있는 모든 부서 사원들의 평균급여가 가장 낮은 도시부터 도시명(city)과 평균연봉, 해당 도시의 사원수를 가져오시오. 단, 도시에 근 무하는 사원이 10명 이상인 곳은 제외하고 가져오시오.

-- 48. employees, jobs, job_history. ‘Public  Accountant’의 직책(job_title)으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 가져오시오. 현재 ‘Public Accountant’의 직책(job_title)으로 근무하는 사원은 고려 하지 말것

-- 49. employees, departments, locations. 커미션을 받는 모든 사람들의 first_name, last_name, 부서명, 지역 id, 도시명을 가져오시오.

-- 50. employees. 자신의 매니저보다 먼저 고용된 사원들의 first_name, last_name, 고용일을 가져오시오.

-- 51. employees. 매니저로 근무하는 사원이 총 몇명인가?

-- 52. employees. 자신의 매니저보다 
-- 연봉(salary)를 많이 받는 사원들의 
-- 성(last_name)과 연봉(salary)를 가져오시오.

-- 53. employees. 
-- 총 사원 수 및 2003, 2004, 2005, 2006 년도 별 
-- 고용된 사원들의 총 수를 가져오시오.




-- 54. employees, departments. 
-- 2007년에 입사(hire_date)한 사원들의 
-- 사번(employee_id), 이름(first_name), 성(last_name), 부서명(department_name)을 가져오시오. 
-- 단, 부서에 배치되지 않은 사원은 'Not Assigned'로 가져오시오.
SELECT 
    EMPLOYEE_ID,
    FIRST_NAME || ' ' || E.LAST_NAME AS NAME,
    CASE
        WHEN DEPARTMENT_NAME IS NULL THEN 'Not Assigned'
        WHEN DEPARTMENT_NAME IS NOT NULL THEN DEPARTMENT_NAME
    END AS "부서명"
FROM EMPLOYEES E 
    LEFT OUTER JOIN DEPARTMENTS D
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
            WHERE TO_CHAR(HIRE_DATE, 'YY') = 7;

-- 55. employees. 직업이 
-- 'AD_PRESS' 인 사람은 A 등급을, 
-- 'ST_MAN' 인 사람은 B 등급을, 
-- 'IT_PROG' 인 사람은 C 등급을, 
-- 'SA_REP' 인 사람은 D 등급을, 
-- 'ST_CLERK' 인 사람은 E 등급을 기타는 0 을 부여하여 가져오시오.
SELECT
    FIRST_NAME,
    JOB_ID,
    CASE
        WHEN JOB_ID = 'AD_PRES' THEN 'A'
        WHEN JOB_ID = 'ST_MAN' THEN 'B'
        WHEN JOB_ID = 'IT_PROG' THEN 'C'
        WHEN JOB_ID = 'SA_REP' THEN 'D'
        WHEN JOB_ID = 'ST_CLERK' THEN 'E'
        ELSE '0'
    END AS "등급"
FROM EMPLOYEES;

-- 56. employees, jobs. 
-- 업무명(job_title)이 ‘Sales Representative’인 사원 중에서 
-- 연봉(salary)이 9,000이상, 10,000 이하인 사원들의 
-- 이름(first_name), 성(last_name)과 연봉(salary)를 가져오시오.
SELECT 
    E.FIRST_NAME,
    E.LAST_NAME,
    E.SALARY
FROM EMPLOYEES E
    INNER JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID 
        AND J.JOB_TITLE = 'Sales Representative' 
        AND E.SALARY BETWEEN 9000 AND 10000;

-- 57. employees, departments. 
-- 부서별로 가장 적은 급여를 받고 있는 사원의 
-- 이름, 부서이름, 급여를 가져오시오. 
-- 이름은 last_name만 가져오고, 
-- 부서이름으로 오름차순 정렬하고, 
-- 부서가 같은 경우 이름을 기준 으로 오름차순 정렬하여 가져오시오. 
SELECT 
    E.LAST_NAME, 
    ED.DEPARTMENT_NAME, 
    ED.MS
FROM EMPLOYEES E 
    INNER JOIN (SELECT 
                    E.DEPARTMENT_ID, D.DEPARTMENT_NAME, MIN(SALARY) AS MS 
                FROM EMPLOYEES E 
                    INNER JOIN DEPARTMENTS D
                        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                GROUP BY E.DEPARTMENT_ID, D.DEPARTMENT_NAME) ED 
        ON E.DEPARTMENT_ID = ED.DEPARTMENT_ID
    WHERE E.SALARY = ED.MS
        ORDER BY ED.DEPARTMENT_NAME ASC, E.LAST_NAME ASC;


-- 58. employees, departments, locations. 
-- 사원의 부서가 속한 도시(city)가 ‘Seattle’인 사원의 
-- 이름, 해당 사원의 매니저 이름, 사원의 부서이름을 가져오시오. 
-- 이때 사원의 매니저가 없을 경우 ‘없음’이라고 가져오시오. 
-- 이름은 last_name만 가져오고, 사원의 이름을 오름차순으로 정렬하시오.
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT 
    E.LAST_NAME, 
    CASE
        WHEN M.LAST_NAME IS NULL THEN '없음'
        WHEN M.LAST_NAME IS NOT NULL THEN M.LAST_NAME
    END,
    D.DEPARTMENT_NAME
FROM EMPLOYEES E 
    INNER JOIN DEPARTMENTS D
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    INNER JOIN LOCATIONS L
        ON D.LOCATION_ID = L.LOCATION_ID AND L.CITY = 'Seattle'
    LEFT OUTER JOIN EMPLOYEES M
        ON E.MANAGER_ID = M.EMPLOYEE_ID
    ORDER BY E.LAST_NAME;
 
-- 59. employees, jobs. 
-- 각 업무(job) 별로 연봉(salary)의 총합을 구하고자 한다. 
-- 연봉 총합이 가장 높은 업무부터 
-- 업무명(job_title)과 연봉 총합을 가져오시오. 
-- 단 연봉총합이 30,000보다 큰 업무만 가져오시오.
SELECT 
    JOB_TITLE AS "업무명",
    SUM(SALARY) AS "연봉 총합"
FROM EMPLOYEES E
    INNER JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID
GROUP BY JOB_TITLE -- 각 업무(job) 별로
    HAVING SUM(SALARY) > 30000 -- 단 연봉총합이 30,000보다 큰 업무
        ORDER BY SUM(SALARY) DESC; -- 연봉 총합이 가장 높은 업무부터

-- 60. employees, departments, locations, jobs. 
-- 각 사원(employee)에 대해서 
-- 사번(employee_id), 이름(first_name), 업무명(job_title), 부서 명(department_name)을 가져오시오. 
-- 단 도시명(city)이 ‘Seattle’인 지역(location)의 부서 (department)에 근무하는 사원을 
-- 사원번호 오름차순으로 가져오시오.
SELECT
    E.EMPLOYEE_ID,
    E.FIRST_NAME,
    J.JOB_TITLE,
    D.DEPARTMENT_NAME
FROM EMPLOYEES E
    INNER JOIN DEPARTMENTS D
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    INNER JOIN LOCATIONS L
        ON D.LOCATION_ID = L.LOCATION_ID AND L.CITY = 'Seattle'
    INNER JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID
                        --WHERE L.CITY = 'Seattle'
ORDER BY E.EMPLOYEE_ID ASC;

-- 61. employees. 2001~20003년사이에 입사한 사원의 
-- 이름(first_name), 입사일(hire_date), 관리자사번 (employee_id), 관리자 이름(fist_name)을 가져오시오. 
-- 단, 관리자가 없는 사원정보도 결과에 포함시켜 가져오시오.
SELECT 
    E.FIRST_NAME,
    E.HIRE_DATE,
    E.MANAGER_ID,
    M.FIRST_NAME
FROM EMPLOYEES E
    LEFT OUTER JOIN EMPLOYEES M
        ON E.MANAGER_ID = M.EMPLOYEE_ID 
    WHERE TO_CHAR(E.HIRE_DATE, 'YYYY') BETWEEN 2001 AND 2003;
            --where e1.hire_date between '2001-01-01' and '2003-12-31'
-- 62. employees, departments. 
-- ‘Sales’ 부서에 속한 사원의 이름(first_name), 급여(salary), 부서이름(department_name)을 가져오시오. 
-- 단, 급여는 100번 부서의 평균보다 적게 받는 사원 정보만 가져오시오.
SELECT 
    E.FIRST_NAME,
    E.SALARY,
    D.DEPARTMENT_NAME
FROM EMPLOYEES E
    INNER JOIN DEPARTMENTS D
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID AND D.DEPARTMENT_NAME = 'Sales'
            WHERE E.SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID = 100);

-- 63. employees. 
-- last_name 에 'u' 가 포함되는 사원들과 동일 부서에 근무하는 사원들의 
-- 사번 및 last_name을 가져오시오.
SELECT
    E.EMPLOYEE_ID,
    E.LAST_NAME
FROM EMPLOYEES E
    WHERE DEPARTMENT_ID IN (SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME LIKE '%u%');

-- 64. employees, departments. 부서별 사원들의 
-- 최대, 최소, 평균급여를 조회하되, 
-- 평균급여가 ‘IT’ 부서의 평균급여보다 많고, ‘Sales’ 부서의 평균보다 적은 부서 정보만 가져오시오. 

SELECT 
    D.DEPARTMENT_NAME, MAX(E.SALARY), MIN(E.SALARY), ROUND(AVG(E.SALARY))
FROM EMPLOYEES E
    INNER JOIN DEPARTMENTS D
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    GROUP BY D.DEPARTMENT_NAME
        HAVING  ROUND(AVG(E.SALARY)) > (
                                            SELECT 
                                                ROUND(AVG(E.SALARY))
                                            FROM EMPLOYEES E, DEPARTMENTS D
                                                WHERE D.DEPARTMENT_NAME = 'IT' AND D.DEPARTMENT_ID = E.DEPARTMENT_ID)
            AND  ROUND(AVG(E.SALARY)) < (
                                           SELECT 
                                                  ROUND(AVG(E.SALARY))
                                           FROM EMPLOYEES E, DEPARTMENTS D
                                               WHERE D.DEPARTMENT_NAME = 'Sales' AND D.DEPARTMENT_ID = E.DEPARTMENT_ID);

-- 65. employees, departments. 각 부서별로 
-- 사원이 한명만 있는 부서만 가져오시오. 
-- 단, 사원이 없는 부서에 대해서는 ‘신생부서’라는 문자열을 가져오고,  
-- 결과는 부서명이 내림차순으로 정렬되게 하시오.
SELECT
    CASE
        WHEN COUNT(E.EMPLOYEE_ID) = 1 THEN D.DEPARTMENT_NAME
        WHEN COUNT(E.EMPLOYEE_ID) = 0 THEN '신생부서'
    END AS "부서명", 
    COUNT(E.EMPLOYEE_ID)
FROM DEPARTMENTS D
    LEFT OUTER JOIN EMPLOYEES E
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    GROUP BY D.DEPARTMENT_NAME
        HAVING COUNT(*) = 1 OR COUNT(*) = 0
    ORDER BY D.DEPARTMENT_NAME DESC;
--10	1
--40	1
--70	1

-- 66. employees, departments. 부서별, 입사월별 사원수를 가져오시오. 
-- 단, 사원수가 5명 이상인 부서만 가져오고,  
-- 결과는 부서이름 순으로 하시오.
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT 
    D.DEPARTMENT_NAME "부서명",
    TO_CHAR(HIRE_DATE, 'MON') "입사월",
    COUNT(*) AS "사원수"
FROM DEPARTMENTS D
    LEFT OUTER JOIN EMPLOYEES E
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    GROUP BY D.DEPARTMENT_NAME, TO_CHAR(HIRE_DATE, 'MON')
        HAVING COUNT(*) >= 5
    ORDER BY D.DEPARTMENT_NAME ASC;
    
-- 67. employees, departments, locations, countries. 
-- 국가(country_name) 별 도시(city)별 사원수를 가져오시오.  
-- 부서정보가 없는 사원은 국가명과 도시명 대신에 ‘부서없음’을 넣어서 가져오시오.
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;
SELECT * FROM COUNTRIES;

SELECT
    CASE
        WHEN C.COUNTRY_NAME IS NULL THEN '부서없음'
        WHEN C.COUNTRY_NAME IS NOT NULL THEN C.COUNTRY_NAME 
    END AS "국가명",
    CASE
        WHEN L.CITY IS NULL THEN '부서없음'
        WHEN L.CITY IS NOT NULL THEN L.CITY
    END AS "도시명",
    COUNT(*)
FROM EMPLOYEES E
    LEFT OUTER JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
    LEFT OUTER JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
    LEFT OUTER JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
    GROUP BY C.COUNTRY_NAME, L.CITY
    ORDER BY COUNTRY_NAME ASC, CITY ASC;

-- 68. employees, departments. 
-- 각 부서별 최대 급여자의 
-- 아이디(employee_id), 이름(first_name), 급여(salary)를 가져오시오.
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

SELECT 
    E.EMPLOYEE_ID,
    E.FIRST_NAME,
    E.SALARY,
    D.DEPARTMENT_NAME
FROM EMPLOYEES E 
    LEFT OUTER JOIN DEPARTMENTS D
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE (E.DEPARTMENT_ID, E.SALARY) IN 
                                            (SELECT 
                                                E.DEPARTMENT_ID,
                                                MAX(E.SALARY) AS SALARY
                                            FROM EMPLOYEES E
                                            INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                                            GROUP BY E.DEPARTMENT_ID)
    ORDER BY E.EMPLOYEE_ID ASC;
    
-- 69. employees. 커미션(commission_pct)별 사원수를 가져오시오. 
-- 커미션은 0.2, 0.25는 모두 0.2로, 
-- 0.3, 0.35는 0.3 형태로 바꾸시오. 
-- 단, 커미션 정보가 없는 사원들도 있는 데 커미션이 없는 사원 그룹은 
-- ‘커미션 없음’으로 바꿔 가져오시오.  

SELECT
    CASE
        WHEN '0' ||SUBSTR(COMMISSION_PCT, 1, 2) = '0' THEN '커미션 없음'
        ELSE '0' ||SUBSTR(COMMISSION_PCT, 1, 2)
    END AS "커미션명",
    COUNT(*)
FROM EMPLOYEES
    GROUP BY SUBSTR(COMMISSION_PCT, 1, 2);