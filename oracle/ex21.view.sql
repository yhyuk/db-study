--ex21.view.sql

/*

    뷰, View
    - DB Object 중 하나(테이블, 시퀀스, 제약사항, 뷰) -> 데이터베이스 영구 저장
    - 가상 테이블, 뷰 테이블
    - 일종의 테이블 복사본
    - 뷰는 테이블처럼 취급한다.
    - 자주 사용하는 SELECT의 결과를 저장하는 객체(*********)
    - 테이블을 직접 사용하는 것에 비해 간편함(구문 단축)
    - 뷰는 읽기 전용이다 (******)
    
    - 뷰는 SELECT의 결과를 저장하는 객체가 아니다!!
    - --> SELECT문을 저장하는 객체이다!!
    
    CREATE VIEW 뷰이름
    AS
    SELECT문
    
    뷰의 종류
    1. 단순 뷰
    - 하나의 기본 테이블을 사용해서 만든 뷰
    - CRUD 가능 -> BUT. 무조건 읽기는 용도로만 쓸 것!!
    
    2. 복합 뷰
    - 두개 이상의 기본 테이블을 사용해서 만든 뷰 (SUBQUERY, JOIN, UNION...)
    - 애초에 안된다. 읽기만 가능

*/


--ORA-00955: name is already used by an existing object
--한번 생성한 VWINSA는 재생성 불가
CREATE VIEW VWINSA
AS
SELECT * FROM TBLINSA;

SELECT * FROM TBLINSA WHERE BUSEO = '기획부';
SELECT * FROM VWINSA WHERE BUSEO = '개발부';

DROP VIEW VWINSA;

-- 없으면 만들고, 있으면 수정(대체)
CREATE OR REPLACE VIEW VWINSA
AS
SELECT * FROM TBLINSA WHERE BUSEO = '기획부';

--VWINSA : 기획부 직원 테이블
SELECT * FROM VWINSA;


CREATE OR REPLACE VIEW vwInsaMaleSeoul
AS 
SELECT * FROM TBLINSA WHERE SUBSTR(SSN, 8, 1) = '1' AND CITY = '서울';

SELECT * FROM vwInsaMaleSeoul;

-- 로컬호스트를 HR에서 SYSTEM으로 변경하게 되면....
-- ORA-00942: table or view does not exist
SELECT * FROM TBLINSA;
-- HR에서 테이블 가져오려면 앞에 식별자를 붙여준다.
SELECT * FROM HR.vwInsaMaleSeoul;

--뷰는 자주 쓰이면서, 복잡한것을 많이 쓸때 적극 활용해서 코드 재사용성을 높인다!
CREATE OR REPLACE VIEW VWVIDEO
AS
SELECT 
    M.NAME AS "회원명",
    V.NAME AS "비디오제목",
    R.RENTDATE AS "대여날짜",
    CASE
        WHEN R.RETDATE IS NULL THEN '반납안함'
        WHEN R.RETDATE IS NOT NULL THEN '반납완료'
    END AS "반납상태"
FROM TBLGENRE G
    INNER JOIN TBLVIDEO V
        ON G.SEQ = V.GENRE
            INNER JOIN TBLRENT R
                ON V.SEQ = R.VIDEO
                    INNER JOIN TBLMEMBER M
                        ON M.SEQ = R.MEMBER;
                        
SELECT * FROM VWVIDEO;




-- 서울 직원 뷰
CREATE OR REPLACE VIEW VWSEOUL
AS
SELECT * FROM TBLINSA WHERE CITY = '서울';

SELECT * FROM VWSEOUL;

COMMIT;
ROLLBACK;

SELECT * FROM TBLINSA;

UPDATE TBLINSA SET CITY = '제주' WHERE NUM = 1001;
DELETE FROM TBLINSA WHERE CITY = '서울';


-- 뷰 사용시 주의할 점(하지말 것!!)
-- : 뷰는 무조건 읽기 전용으로 사용한다.
-- : 뷰로 INSERT, UPDATE, DELETE 작업은 금지한다. --> 테이블로 할 것 !!
COMMIT;
ROLLBACK;

CREATE OR REPLACE VIEW VWMEN
AS
SELECT * FROM TBLMEN;

-- 1. SELECT
SELECT * FROM VWMEN;

-- 2. INSERT
INSERT INTO VWMEN (NAME, AGE, HEIGHT, WEIGHT, COUPLE) VALUES ('테스트', 27, 175, 68, NULL);

-- 3. UPDATE
UPDATE VWMEN SET AGE = 25 WHERE NAME = '테스트';

-- 4. DELETE
DELETE FROM VWMEN WHERE NAME = '테스트';




-- 인라인 뷰 , Inline View 
CREATE OR REPLACE VIEW VWSEOUL
AS
SELECT * FROM TBLINSA WHERE CITY = '서울';

SELECT * FROM VWSEOUL; -- 재사용가능

-- 서브 쿼리 => 인라인 뷰
SELECT * FROM (SELECT * FROM TBLINSA WHERE CITY = '서울'); -- 1회성