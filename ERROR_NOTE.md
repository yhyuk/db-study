# Oracle DATABASE - ERROR_NOTE
오라클 데이터베이스 공부하면서 자주 접하는 에러이면서, 머리가 좋지 않아 자꾸 까먹고 엉뚱한 쿼리를 만드는 것을 방지하기 위해 정리한 오류 노트 입니다!!!
___

## 허용값 초과
```SQL
ORA-01438: value larger than specified precision allowed for this column      
INSERT INTO TBLTYPE (NUM) VALUES (9999)
```
- 원인: 테이블의 생성 범위를 초과했다.
- 방법: 테이블 생성 범위를 조절하거나, NUM 값을 테이블 범위에 맞게 수정한다.   

## 오타에러 
```SQL
ORA-00942: table or view does not exist        
SELECT * FROM EMPLOYEE;
```
- 원인: 오타
- 방법: EMPLOYEES 수정    

## 오타에러
```SQL
ORA-00904: "FIRSTNAME": invalid identifier       
SELECT FIRSTNAME FROM EMPLOYEES;
```
- 원인: 오타
- 방법: FIRST_NAME 수정

## 문자열 연산에러    
```SQL
ORA-01722: invalid number     
SELECT LAST + FIRST FROM TBLCOMEDIAN;
```
- 원인: '+'는 상수값에만 할수있다. (문자열 금지)  
- 방법: 문자열에서는 '||'을 이용하자,  LAST || FIRST 수정  

## 집계함수에러1
```SQL
ORA-00937: not a single-group group function    
00937. 00000 -  "not a single-group group function"           
SELECT COUNT(NAME), AREA FROM TBLCOUNTRY;
```
- 원인 : 집계 함수에 여러 컬럼이 작성됨
- 방법 : 집계 함수(COUNT(NAME))와 단일 컬럼(AREA)을 동시에 사용할 수 없다.    

## 집계함수에러2
```SQL
ORA-00934: group function is not allowed here      
SELECT * FROM TBLINSA WHERE BASICPAY > AVG(BASICPAY);      
```
- 원인 : 집계 함수에 여러 컬럼이 작성됨
- 방법 : 집계 함수(AVG(BASICPAY))와 단일 컬럼(BASICPAY)을 동시에 사용할 수 없다.       
      
## 자료형 에러
```SQL
ORA-01722: invalid number    
SELECT SUM(FIRST) FROM TBLCOMEDIAN;         
```
- 원인: SUM은 숫자형만 와야하는데 다른 자료형이 들어옴         
- 방법: 숫자형 데이터를 작성한다.

## 날짜 상수 표기 에러
```SQL
ORA-01861: literal does not match format string
WHERE IBSADATE BETWEEN '2010-01-01 00:00:00' AND '2010-12-31 23:59:59';
```
- 원인: 날짜형은 상수가 아니다.
- 방법: 날짜비교는 TO_CHAR 함수 OR TO_DATE 함수를 이용하면 된다.

## NOT NULL 에러
```SQL
ORA-01400: cannot insert NULL into ("HR"."TBLMEMO"."NAME")
INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (1, NULL, '메모입니다', SYSDATE);
INSERT INTO TBLMEMO (SEQ, MEMO, REGDATE) VALUES (1, '메모입니다', SYSDATE);
```
- 원인: NOT NULL로 지정된 컬럼리스트에 NULL값을 넣었으며, 생략했다.
- 방법: NAME 컬럼리스트를 제약사항을 변경하거나 NULL값이 아닌 데이터 값을 넣는다.

## 기본키, PRIMARY KEY 에러
```SQL
ORA-00001: unique constraint (HR.SYS_C007081) violated
INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (1, '홍길동', '메모입니다', SYSDATE);
INSERT INTO TBLMEMO (SEQ, NAME, MEMO, REGDATE) VALUES (1, '아무개', '테스트용', SYSDATE);
```
- 원인: PRIMARY KEY(PK)로 지정된 컬럼에 중복값을 넣었다.
- 방법: SEQ 컬럼 제약사항을 변경하거나, 중복되지 않은 유일한 데이터 값을 넣는다.

## 컬럼리스트와 값리스트 에러1
```SQL
ORA-00947: not enough values
INSERT INTO tblMemo (SEQ, NAME, MEMO, REGDATE) VALUES (seqMemo.NEXTVAL, '홍길동', SYSDATE);
```
- 원인: 컬럼 리스트가 4개라면, 값 리스트도 4개여야 한다.
- 방법: 값 리스트에 없는 것을 컬럼 리스트에서도 빼거나, 값 리스트에 추가해야한다.

## 컬럼리스트와 값리스트 에러2
```SQL
ORA-00913: too many values
INSERT INTO tblMemo (SEQ, NAME, REGDATE) VALUES (seqMemo.NEXTVAL, '홍길동', '메모입니다', SYSDATE);
```
- 원인: 컬럼 리스트가 4개라면, 값 리스트도 4개여야 한다.
- 방법: 컬럼 리스트에 없는것을 값 리스트에서 빼거나, 컬럼 리스트에 추가해야한다.

## GROUP BY 에러
```SQL
ORA-00979: not a GROUP BY expression
SELECT 
    JIKWI,
    NAME,
    COUNT(*)
FROM TBLINSA
    GROUP BY JIKWI;
```
- 원인: 그룹으로 묶은 곳에 개인(개별)데이터가 들어왔다.
- 방법: 개별 데이터인 NAME컬럼을 지운다.

## FK(Foreign Key) 참조키 에러1
```SQL
ORA-02291: integrity constraint (HR.SYS_C007178) violated - parent key not found
INSERT INTO tblProject (SEQ, PROJECT, STAFF_SEQ) VALUES (6, '고객유치', 5);  
```
- 원인: 참조할 번호가 없다.
- 방법: 데이터 추가 시 참조 번호를 다시 확인하여 추가한다.

## FK(Foreign Key) 참조키 에러2
```SQL
ORA-02292: integrity constraint (HR.SYS_C007178) violated - child record found
DELETE FROM tblStaff WHERE SEQ = 1;
```
- 원인: 참조할 번호가 없어지는건 불가능하다.
- 방법: 현재 테이블에서 PK값 SEQ = 1이 참조하고 있는 값이 있으므로, 삭제 불가

## 두 테이블의 동일 컬럼명 에러
```SQL
ORA-00918: column ambiguously defined, 열의 정의가 애매합니다.
SELECT SEQ FROM tblCustomer    
    INNER JOIN tblSales
        ON tblCustomer.SEQ = tblSales.CSEQ;
```
- 원인: 두 테이블의 각 컬럼명에서 동일 컬럼명이 있다.
- 방법: 식별자를 해당 컬럼명 앞에 붙인다. tblCustomer.SEQ, tblSales.SEQ

## 새로운 테이블 생성 시 NOT NULL 에러
```SQL
ORA-01758: table must be empty to add mandatory (NOT NULL) column
ALTER TABLE TBLEDIT
    ADD (DESCRIPTION VARCHAR2(100) NOT NULL);
```
- 원인: NOT NULL은 데이터가 존재해야한다.
- 방법: 새로운 테이블 NOT NULL 생성 시 DEFAULT 기본값을 넣어준다. 

## PL/SQL SELECT 에러
```SQL
PLS-00428: an INTO clause is expected in this SELECT statement
BEGIN
    SELECT BUSEO FROM TBLINSA WHERE NAME = '홍길동';
END;
```
- 원인: PL/SQL 블럭내부에서는 SELECT의 결과를 반드시 변수에 저장해야 한다.
- 방법: SELECT절을 SELECT 컬럼 INTO 변수명 으로 수정한다.    
   --> SELECT BUSEO INTO 변수명 FROM TBLINSA WHERE NAME = '홍길동';
