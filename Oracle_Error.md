ORA-01438: value larger than specified precision allowed for this column
insert into tblType (num) values (9999)

####오타에러    
ORA-00942: table or view does not exist     
select * from employee;      
방법: 
 
###오타에러
ORA-00904: "FIRSTNAME": invalid identifier
select firstname from employees;
방법: firstname가 맞는지 확인 후 수정


ORA-01722: invalid number
select last + first from tblComedian;
원인: '+'는 오라클에서 상수값에만 할수있다. (문자열 금지)
방법: 문자열에서는 '||'을 이용하자.
