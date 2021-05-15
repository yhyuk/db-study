# Oracle DATABASE - ERROR_NOTE 

## 허용값 초과
ORA-01438: value larger than specified precision allowed for this column   
insert into tblType (num) values (9999)   
방법: 테이블 생성 범위를 조절하거나, num 값을 테이블 범위에 맞게 수정한다.   

## 오타에러 
ORA-00942: table or view does not exist   
select * from employee;     
방법: 테이블명이 잘못 입력되었으며, 확인 후 수정    

## 오타에러
ORA-00904: "FIRSTNAME": invalid identifier   
select firstname from employees;    
방법: 캘럼 firstname 이름이 맞는지 확인 후 수정  

## 문자열 연산에러    
ORA-01722: invalid number   
select last + first from tblComedian;  
원인: '+'는 오라클에서 상수값에만 할수있다. (문자열 금지)  
방법: 문자열에서는 '||'을 이용하자.  

## 집계함수에러1
ORA-00937: not a single-group group function    
00937. 00000 -  "not a single-group group function"      
select count(name), area from tblCountry;     
원인과방법 : 컬럼 리스트에 COUNT(NAME)(집계 함수)와 AREA(단일 컬럼)을 동시에 사용할 수 없다.    


## 집계함수에러2
ORA-00934: group function is not allowed here      
SELECT AVG(BASICPAY) FROM TBLINSA; --평균값 함수, 결과값:1556526     
SELECT * FROM TBLINSA WHERE BASICPAY > AVG(BASICPAY);      
원인과방법 : 컬럼 리스트에 집계 함수와 단일 컬럼을 동시에 사용할 수 없다.       
개인데이터 BASICPAY 와 집계 데이터 AVG(BASICPAY)가 동시에 왔기때문 에러      

## 자료형 에러
ORA-01722: invalid number    
SELECT SUM(FIRST) FROM TBLCOMEDIAN;         

SUM은 숫자형만 가능하다. FIRST가 숫자형이 아닌 다른 자료형이기때문에 안됨        
