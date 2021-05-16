# Oracle DATABASE - ERROR_NOTE
오라클 데이터베이스 공부하면서 자주접하는 에러를 정리한 자료입니다.
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
