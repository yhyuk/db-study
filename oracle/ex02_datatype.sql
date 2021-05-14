--ex02_datatype.sql

/*

    새로운 언어를 접할때, 자료형을 먼저 파악해보자..
    
    <ANSI-SQL 자료형>
    - 오라클 자료형
    - 데이터베이스 > 데이터 > 자료형
    
    1. 숫자형: 정수 + 실수(오라클은 숫자 구분이 없음)
        - 표현방법: number
        - 유효자리: 38자리 이하의 숫자를 표현하는 자료형
        - 바이트: 5~22byte
        - number(percision, scale)
            1) precision : 소수 이하를 포함한 전체 자릿수(1~38)
            2) scale: 소수 이하의 자릿수(0~127)
            ex) number -> 38자리까지 표현 가능한 모든 숫자(정수,실수 포함)
            ex) number(3) -> 3자리까지 표현 가능한 숫자(정수) -> -999 ~ +999
            ex) number(4,2) -> 4자리수까지 표현 가능 숫자(실수) -> -99.99 ~ +99.99
            ex) number(10,3) -> -9999999.999 ~ +9999999.999
        - 숫자형 상수(리터럴)
            1) 정수: 123
            2) 실수: 3.14
        - 오라클에도 byte, int, float형이 있긴있지만 사용 XXX
            

*/

--테이블 삭제하기
drop table tblType;

--테이블 생성하기
create table tblType (
    -- 컬럼 구성
    -- 컬럼명 자료형
    --num number
    --num number(3)
    num number(4,2)
);

--테이블의 모든 내용을 가져오시오
select * from tblType;

--데이터 추가하기
insert into tblType (num) values (100);
insert into tblType (num) values (200);
insert into tblType (num) values (300);
insert into tblType (num) values (99.99);
insert into tblType (num) values (3.14);
insert into tblType (num) values (9999); --ORA-01438: value larger than specified precision allowed for this column
insert into tblType (num) values (1234567.891233);
insert into tblType (num) values (135135243231234567902891232132133);
insert into tblType (num) values (-135135243231234567902891232132133);
insert into tblType (num) values (135135243231234567902891232132131231232132133);


/*

    2. 문자형: 문자 + 문자열(오라클은 문자, 문자열 구분안함)
        - 자바의 String과 유사
        - 표현방법
            - 쉽게 구분하는법
            - n(X) vs n(O)
            - var(X) vs var(O) -> var: 공간의 크기가 변한다.
            1) char (************************)
                - 고정 자릿수 문자열 -> 공간보다 데이터가 짧아도 나머지 공간은 그대로 차지한다. (공백으로)
                - char(n): n자리 문자열, n(바이트)
                    -최소 크기: 1byte
                    -최대 크기: 2000byte
                    ex) char -> X
                    ex) char(3) -> 최대 3바이트까지 문자열을 저장 -> 인코딩? -> 영어(3글자), 한글(1글자)
                    ex) char(10) -> 최대 10바이트까지 문자열을 저장 -> 영어(10글자), 한글(3글자);
                    ex) char(2000) -> 영어(2000글자), 한글(666글자)
            2) nchar
                - n : national > 유니코드 지원 > UTF-16 동작(모든 문자 -> 2byte)
                - nchar(n) : n자리 문자열, n(문자 수)
                    -최소 크기: 1글자(2byte)
                    -최대 크기: 1000글자(2000byte)
                - 영어가 아닌 문자를 저장할 때 용이
            
            3) varchar2 (************************)
                - 가변 자릿수 문자열 -> 데이터 크기만큼 공간의 크기가 줄어든다.
                - varchar2(n) : n자리 문자열, n(바이트)
                    -최소 크기: 1byte
                    -최대 크기: 4000byte
                
            4) nvarchar2
            
            lob(Large Object)
            5) clob, nclob
                - 대용량 텍스트 저장 자료형
                - 128TB
                - 잘 사용 안함, 참조형
                

    3. 날짜/시간형
        - 자바 Calendar, Date
        1) date(******)
            - 년월일시분초
            - 크기: 7byte
            - 기원전 4712년 1월 1일 ~ 9999년 12월 31일
        2) timestamp
            - 년월일시분초 + 밀리초(나노초)
        3) interval
            - 틱값
            - 시간
            - number 대신
    
    4. 이진 데이터 자료형
        - 텍스트가 아닌 데이터
        - 이미지, 영상, 음악 등...
        1) blob
            -128TB
        - 잘안쓰인다....
            
        <나중에 실제 게시판 만들 때>
        첨부 파일 -> 첨부 파일명(+경로) -> 문자열 -> varchar2




    오늘 자료형 배운것들 요약하자면.....
    number + varchar2 + date 이 3가지가 가장 많이 쓰인다.
*/

--char(n), varchar2(n) 예제
drop table tblType;

create table tblType (
    --name char(3) --char 예제
    --name char(10),
    --nick varchar2(10) --varchar2 예제
    
    name char(10),
    nick nchar(10) --nchar 예제
);

select * from tblType;

--char(n)
insert into tblType (name) values ('abc');
insert into tblType (name) values ('abcd'); --value too large for column "HR"."TBLTYPE"."NAME" (actual: 4, maximum: 3)
insert into tblType (name) values ('김');
insert into tblType (name) values ('홍길동'); --(actual: 9, maximum: 3)
insert into tblType (name) values ('123');
insert into tblType (name) values ('&*(');

--varchar2(n)
insert into tblType (name, nick) values ('abc', 'abc');
-- char     -> 'abc       ' -> 나머지 공간 추가되서 저장됨(불필요한 공간 생성)
-- varchar2 -> 'abc'        -> 데이터 크기 만큼 줄어듬
-- --> char(고정), varchar2(가변) 차이점

--nchar(n)
insert into tblType (name, nick) values ('홍길동', '홍길동');
insert into tblType (name, nick) values ('홍길동님', '홍길동님');
insert into tblType (name, nick) values ('홍길동', '홍길동님');
insert into tblType (name, nick) values ('홍길동', '홍길동님안녕하세요호.');


drop table tblType;

create table tblType (

    name varchar2(30),  --이름
    age number(3),      --나이
    birthday date       --생일

);

insert into tblType (name, age, birthday) values ('홍길동', 20, '1995-11-28');

select * from tblType;











