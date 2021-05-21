--ex24_hierarchical.sql

/*

    Hierarchical Query, 계층형 쿼리
    - 오라클 전용
    - 레코드간의 관계가 서로 상하 수직 구조인 경우 적당한 구조의 결과셋을 만들어 주는 역할
    - 한 테이블에 부모, 자식 레코드가 동시에 있는 경우 > 자기 참조 테이블
    - 조직도, 답변형 게시판, BOM
    
    컴퓨터
        - 본체
            - 메인모드
            - 그래픽카드
            - 랜카드
            - CPU
            - 메모리
        - 모니터
            - 보호필름
        - 프린터
            - 잉크카트리지
            - A4용지
*/

CREATE TABLE TBLCOMPUTER (
    SEQ NUMBER PRIMARY KEY,                     --식별자(PK)
    NAME VARCHAR2(50) NOT NULL,                 --요소명
    QTY NUMBER NOT NULL,                        --수량
    PSEQ NUMBER NULL REFERENCES TBLCOMPUTER(SEQ)--부모부품(FK)
);

INSERT INTO TBLCOMPUTER VALUES (1, '컴퓨터', 1, NULL); -- 루트(ROOT)

INSERT INTO TBLCOMPUTER VALUES (2, '본체', 1, 1);
INSERT INTO TBLCOMPUTER VALUES (3, '모니터', 1, 1);
INSERT INTO TBLCOMPUTER VALUES (4, '프린터', 1, 1);

INSERT INTO TBLCOMPUTER VALUES (5, '메인보드', 1, 2);
INSERT INTO TBLCOMPUTER VALUES (6, '그래픽카드', 1, 2);
INSERT INTO TBLCOMPUTER VALUES (7, '랜카드', 1, 2);
INSERT INTO TBLCOMPUTER VALUES (8, 'CPU', 1, 2);
INSERT INTO TBLCOMPUTER VALUES (9, '메모리', 2, 2);

INSERT INTO TBLCOMPUTER VALUES (10, '보호필름', 1, 3);
INSERT INTO TBLCOMPUTER VALUES (11, '잉크카트리지', 1, 4);
INSERT INTO TBLCOMPUTER VALUES (12, 'A4용지', 100, 4);

SELECT * FROM TBLCOMPUTER;

-- 셀프조인: 부품 + 부모부품

SELECT 
    C1.NAME AS "부품",
    C2.NAME AS "부모부품"
FROM TBLCOMPUTER C1
    LEFT OUTER JOIN TBLCOMPUTER C2
        ON C1.PSEQ = C2.SEQ;
        

-- 계층형 쿼리
-- START WITH절 + CONNECT BY절
-- 계층형 커리에서만 사용 가능한 사사 컬럼을 제공



SELECT
    NAME,
    PRIOR NAME
FROM TBLCOMPUTER 
    START WITH SEQ = 1
        CONNECT BY PRIOR SEQ = PSEQ;

--예제
SELECT 
    LPAD(' ', (LEVEL - 1) * 2) || NAME AS 직원명,
    --PRIOR NAME AS 상사명
    DEPARTMENT
FROM TBLSELF S
    START WITH SUPER IS NULL
        CONNECT BY SUPER = PRIOR SEQ;
        
        

--예제
SELECT 
    LPAD(' ', (LEVEL - 1) * 5) || NAME AS 직원명,
    PRIOR NAME,
    LEVEL,
    CONNECT_BY_ROOT NAME AS "루트부품명",
    CONNECT_BY_ISLEAF AS "리프노드",
    SYS_CONNECT_BY_PATH(NAME, '-')
FROM TBLCOMPUTER
    START WITH PSEQ IS NULL
        CONNECT BY PRIOR SEQ = PSEQ
            ORDER SIBLINGS BY NAME ASC; --형제끼리만 정렬
            --ORDER BY NAME ASC;
        
        