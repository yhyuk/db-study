-- insa.data.sql

CREATE TABLE tblInsa(
        num NUMBER(5) NOT NULL CONSTRAINT tblInsa_pk PRIMARY KEY
       ,name VARCHAR2(20) NOT NULL
       ,ssn  VARCHAR2(14) NOT NULL
       ,ibsaDate DATE     NOT NULL
       ,city  VARCHAR2(10)
       ,tel   VARCHAR2(15)
       ,buseo VARCHAR2(15) NOT NULL
       ,jikwi VARCHAR2(15) NOT NULL
       ,basicPay NUMBER(10) NOT NULL
       ,sudang NUMBER(10) NOT NULL
);

INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1001, '홍길동', '871212-1022432', '2008-10-11', '서울', '011-2356-4528', '기획부',
   '부장', 2610000, 200000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1002, '이순신', '901007-1544236', '2010-11-29', '경기', '010-4758-6532', '총무부',
   '사원', 1320000, 200000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1003, '이순애', '870922-2312547', '2009-02-25', '인천', '010-4231-1236', '개발부',
   '부장', 2550000, 160000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1004, '김정훈', '890304-1788896', '2010-10-01', '전북', '019-5236-4221', '영업부',
   '대리', 1954200, 170000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1005, '한석봉', '911112-1566789', '2014-08-13', '서울', '018-5211-3542', '총무부',
   '사원', 1420000, 160000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1006, '이기자', '880505-2978541', '2012-02-11', '인천', '010-3214-5357', '개발부',
   '과장', 2265000, 150000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1007, '장인철', '880506-1625148', '2008-03-16', '제주', '011-2345-2525', '개발부',
   '대리', 1250000, 150000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1008, '김영년', '921011-2362514', '2012-04-30', '서울', '016-2222-4444', '홍보부',
'사원', 950000 , 145000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1009, '나윤균', '910810-1552147', '2013-10-10', '경기', '019-1111-2222', '인사부',
   '사원', 840000 , 220400);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1010, '김종서', '851010-1122233', '2007-08-08', '부산', '011-3214-5555', '영업부',
   '부장', 2540000, 130000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1011, '유관순', '901010-2987897', '2010-07-07', '서울', '010-8888-4422', '영업부',
   '사원', 1020000, 140000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1012, '정한국', '860909-1333333', '2009-10-16', '강원', '018-2222-4242', '홍보부',
   '사원', 880000 , 114000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1013, '조미숙', '890102-2777777', '2008-06-07', '경기', '019-6666-4444', '홍보부',
   '대리', 1601000, 103000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1014, '황진이', '910707-2574812', '2012-02-15', '인천', '010-3214-5467', '개발부',
   '사원', 1100000, 130000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1015, '이현숙', '900606-2954687', '2009-07-26', '경기', '016-2548-3365', '총무부',
   '사원', 1050000, 104000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1016, '이상헌', '881010-1666678', '2011-11-29', '경기', '010-4526-1234', '개발부',
   '과장', 2350000, 150000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1017, '엄용수', '920507-1452365', '2010-08-28', '인천', '010-3254-2542', '개발부',
   '사원', 950000 , 210000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1018, '이성길', '901028-1849534', '2014-08-08', '전북', '018-1333-3333', '개발부',
   '사원', 880000 , 123000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1019, '박문수', '880710-1985632', '2009-12-10', '서울', '017-4747-4848', '인사부',
   '과장', 2300000, 165000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1020, '유영희', '900304-2741258', '2013-10-10', '전남', '011-9595-8585', '자재부',
   '사원', 880000 , 140000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1021, '홍길남', '901010-1111111', '2011-09-07', '경기', '011-9999-7575', '개발부',
   '사원', 875000 , 120000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1022, '이영숙', '900501-2312456', '2013-02-25', '전남', '017-5214-5282', '기획부',
   '대리', 1960000, 180000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1023, '김인수', '831211-1214576', '2005-02-23', '서울', NULL           , '영업부',
   '부장', 2500000, 170000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1024, '김말자', '930225-2633334', '2009-08-28', '서울', '011-5248-7789', '기획부',
   '대리', 1900000, 170000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1025, '우재옥', '901103-1654442', '2010-10-01', '서울', '010-4563-2587', '영업부',
   '사원', 1100000, 160000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1026, '김숙남', '910907-2015457', '2012-08-28', '경기', '010-2112-5225', '영업부',
   '사원', 1050000, 150000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1027, '김영길', '901216-1898752', '2010-10-18', '서울', '019-8523-1478', '총무부',
   '과장', 2340000, 170000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1028, '이남신', '910101-1010101', '2011-09-07', '제주', '016-1818-4848', '인사부',
   '사원', 892000 , 110000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1029, '김말숙', '900301-2020202', '2010-09-08', '서울', '016-3535-3636', '총무부',
   '사원', 920000 , 124000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1030, '정정해', '890210-2101010', '2009-10-17', '부산', '019-6564-6752', '총무부',
   '과장', 2304000, 124000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1031, '지재환', '871115-1687988', '2011-01-21', '서울', '019-5552-7511', '기획부',
   '부장', 2450000, 160000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1032, '심심해', '910206-2222222', '2010-05-05', '전북', '016-8888-7474', '자재부',
   '사원', 880000 , 108000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1033, '김미나', '880505-2999999', '2008-06-07', '서울', '011-2444-4444', '영업부',
   '사원', 1020000, 104000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1034, '이정석', '920505-1325468', '2015-09-26', '경기', '011-3697-7412', '기획부',
   '사원', 1100000, 160000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1035, '정영희', '931010-2153252', '2012-05-16', '인천', NULL           , '개발부',
   '사원', 1050000, 140000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1036, '이재영', '801126-2852147', '2013-08-10', '서울', '011-9999-9999', '자재부',
   '사원', 960400 , 190000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1037, '최석규', '870129-1456987', '2008-10-15', '인천', '011-7777-7777', '홍보부',
   '과장', 2350000, 187000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1038, '손인수', '891009-2321456', '2009-11-15', '부산', '010-6542-7412', '영업부',
   '대리', 2000000, 150000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1039, '고순정', '900504-2000032', '2013-12-28', '경기', '010-2587-7895', '영업부',
   '대리', 2010000, 160000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1040, '박세열', '890509-1635214', '2010-09-10', '경북', '016-4444-7777', '인사부',
   '대리', 2100000, 130000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1041, '문길수', '821217-1951357', '2011-12-10', '충남', '016-4444-5555', '자재부',
   '과장', 2300000, 150000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1042, '채정희', '910709-2000054', '2013-10-17', '경기', '011-5125-5511', '개발부',
   '사원', 1020000, 200000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1043, '양미옥', '930504-2471523', '2013-09-24', '서울', '016-8548-6547', '영업부',
   '사원', 1100000, 210000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1044, '지수환', '920305-1475286', '2014-01-21', '서울', '011-5555-7548', '영업부',
   '사원', 1060000, 220000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1045, '홍원신', '690906-1985214', '2013-03-16', '전북', '011-7777-7777', '영업부',
   '사원', 960000 , 152000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1046, '허경운', '860105-1458752', '2009-05-04', '경남', '017-3333-3333', '총무부',
   '부장', 2650000, 150000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1047, '산마루', '880505-1234567', '2011-07-15', '서울', '018-0505-0505', '영업부',
   '대리', 2100000, 112000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1048, '이기상', '890604-1415141', '2011-06-07', '전남', NULL           , '개발부',
   '대리', 2050000, 106000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1049, '이미성', '930908-2456548', '2010-04-07', '인천', '010-6654-8854', '개발부',
   '사원', 1300000, 130000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1050, '이미인', '910403-2828287', '2013-06-07', '경기', '011-8585-5252', '홍보부',
   '대리', 1950000, 103000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1051, '권영미', '890303-2155554', '2010-06-04', '서울', '011-5555-7548', '영업부',
   '과장', 2260000, 104000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1052, '권옥경', '920406-2000456', '2010-10-10', '경기', '010-3644-5577', '기획부',
   '사원', 1020000, 105000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1053, '김싱식', '900715-1313131', '2009-12-12', '전북', '011-7585-7474', '자재부',
   '사원', 960000 , 108000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1054, '정상호', '910705-1212141', '2009-10-16', '강원', '016-1919-4242', '홍보부',
   '사원', 980000 , 114000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1055, '정한나', '920506-2425153', '2014-06-07', '서울', '016-2424-4242', '영업부',
   '사원', 1000000, 104000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1056, '전용재', '900605-1456987', '2014-08-13', '인천', '010-7549-8654', '영업부',
   '대리', 1950000, 200000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1057, '이미경', '880406-2003214', '2008-02-11', '경기', '016-6542-7546', '자재부',
   '부장', 2520000, 160000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1058, '김신제', '900709-1321456', '2013-08-08', '인천', '010-2415-5444', '기획부',
   '대리', 1950000, 180000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1059, '임수봉', '910809-2121244', '2011-10-10', '서울', '011-4151-4154', '개발부',
   '사원', 890000 , 102000);
INSERT INTO tblInsa (num, name, ssn, ibsaDate, city, tel, buseo, jikwi, basicPay, sudang) VALUES
  (1060, '김신애', '910809-2111111', '2011-10-10', '서울', '011-4151-4444', '개발부',
   '사원', 900000 , 102000);

COMMIT;

SELECT * FROM tblInsa;