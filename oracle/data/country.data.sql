-- country.data.sql
-- 국가 테이블 + 데이터


DROP TABLE tblCountry;

CREATE TABLE tblCountry
(
	name VARCHAR2(30) NOT NULL PRIMARY KEY, -- 국가명
	capital VARCHAR2(30) NULL, -- 수도
	population NUMBER NULL, -- 인구수
	continent VARCHAR2(2) NULL, -- 대륙(AS, NA, SA..)
	area NUMBER NULL -- 면적
);

INSERT INTO tblCountry VALUES ('대한민국','서울',4405,'AS',10);
INSERT INTO tblCountry VALUES ('중국','베이징',120660,'AS',959);
INSERT INTO tblCountry VALUES ('일본','도쿄',12461,'AS',37);
INSERT INTO tblCountry VALUES ('미국','워싱턴',24963,'SA',936);
INSERT INTO tblCountry VALUES ('영국','London',5741,'EU',24);
INSERT INTO tblCountry VALUES ('이집트','카이로',5969,'AF',99);
INSERT INTO tblCountry VALUES ('오스트레일리아','Canberra',1787,'AU',768);
INSERT INTO tblCountry VALUES ('칠레','산티아고',1339,'SA',75);
INSERT INTO tblCountry VALUES ('우루과이','몬테비디오',317,'SA',17);
INSERT INTO tblCountry VALUES ('아르헨티나','부에노스아이레스',3388,'SA',278);
INSERT INTO tblCountry VALUES ('인도네시아','자카르타',19134,'AS',191);
INSERT INTO tblCountry VALUES ('네덜란드','암스테르담',1476,'EU',4);
INSERT INTO tblCountry VALUES ('케냐','나이로비',NULL,'AF',58);
INSERT INTO tblCountry VALUES ('벨기에','브뤼셀',1012,'EU',3);

COMMIT;

select * from tblCountry;