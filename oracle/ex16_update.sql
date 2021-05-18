--ex16_update.sql

/*

    UPDATE문
    - DML(SELECT, INSERT, UPDATE, DELETE)
    - 원하는 행의 원하는 컬럼값을 수정하는 명령어
    - UPDATE 테이블명 SET 컬럼명 = 수정할 값 [, 컬럼명 = 수정할 값] x N [WHERE절]
    - WHERE절 !! 중요함 -> 데이터 다 날라갈 수 있음

*/

-- 나중에 배울 트랜잭션 처리
COMMIT;
ROLLBACK;

SELECT * FROM TBLCOUNTRY;

-- 대한민국 수도 > 서울 > 세종시 이전
UPDATE TBLCOUNTRY SET
    CAPITAL = '세종시'
        WHERE NAME = '대한민국'; -- PK 컬럼을 조건으로 지정을 하면 유일한 행을 검색할 수 있다. *****

-- 1년 후 > 인구증가 > 10% 증가
UPDATE TBLCOUNTRY SET
    POPULATION = POPULATION * 1.1;

-- 'AS'에 속한 나라만 인구수 증가
UPDATE TBLCOUNTRY SET
    POPULATION = POPULATION * 1.1
        WHERE CONTINENT = 'AS';
        
UPDATE TBLCOUNTRY SET
    CAPITAL = '제주시',
    AREA = AREA + 10,
    POPULATION = POPULATION * 1.2
        WHERE NAME = '대한민국';
        
-- 절대 하면 안되는 행동!!!! > PK는 절대로 수정하면 안된다.
SELECT * FROM TBLINSA;

UPDATE TBLINSA SET
    NUM = 2000
        WHERE NUM = 1001;



