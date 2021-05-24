-- ex26_account.sql

/*

    계정
    - DCL
    - 계정 생성
    - 리소스 접근 권한 제어
    
    사용자 계정 생성하기
    - 시스템 권한을 가지고 있는 계정만 할 수 있다.
        - 관리자만 가능(SYS, SYSTEM, 관리자 권한을 부여받은 계정 등)
        - 계정 생성 권한을 가지는 일반 계정
        
    CREATE USER 계정명 IDENTIFIED BY 암호;
    ALTER USER 계정명 IDENTIFIED BY 암호;
    ALTER USER 계정명 ACCOUNT LOCK;
    ALTER USER 계정명 ACCOUNT UNLOCK;
    DROP USER 계정명;

*/

SHOW USER;

-- ORA-01031: insufficient privileges
CREATE USER HYUK IDENTIFIED BY JAVA1234; -- UNLOCK

-- 계정 권한 조작
-- 1. GRANT 권한 TO 계정
-- 2. REVOKE 권한 FROM 계정

-- 권한
-- 1. 권한
-- 2. 롤(ROLE) : 권한의 집합

--GRANT CREATE SESSION TO HYUK;       -- 단일 권한 부여
GRANT CONNECT, RESOURCE TO HYUK;    -- 롤(수많은 권한 집합)
GRANT CREATE VIEW TO HYUK;

SHOW USER;
SELECT * FROM TABS;