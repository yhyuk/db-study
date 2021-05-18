--ex17_delete.sql

/*

    delete문
    - DML
    - 데이터를 삭제하는 명령어(레코드, 행)
    - DELETE [FROM] 테이블명 [WHERE절]

*/

COMMIT;
ROLLBACK;

SELECT * FROM TBLCOUNTRY;

DELETE FROM TBLCOUNTRY;
DELETE FROM TBLCOUNTRY WHERE CONTINENT = 'AS';
DELETE FROM TBLCOUNTRY WHERE NAME = '대한민국';