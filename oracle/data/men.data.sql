-- men.data.sql
-- 남녀 테이블 + 데이터

drop table tblMen;
drop table tblWomen;

CREATE TABLE tblMen
(
	name varchar2(30) primary key,
	age number not null,
	height number null,
	weight number null,
	couple varchar2(30) null
);

CREATE TABLE tblWomen
(
	name varchar2(30) primary key,
	age number not null,
	height number null,
	weight number null,
	couple varchar2(30) null
);


INSERT INTO tblMen VALUES ('홍길동', 25, 180, 70, '장도연');
INSERT INTO tblMen VALUES ('아무개', 22, 175, NULL, '이세영');
INSERT INTO tblMen VALUES ('하하하', 27, NULL, 80, NULL);
INSERT INTO tblMen VALUES ('무명씨', 21, 177, 72, NULL);
INSERT INTO tblMen VALUES ('유재석', 29, NULL, NULL, '김숙');
INSERT INTO tblMen VALUES ('박명수', 30, 170, NULL, '김지민');
INSERT INTO tblMen VALUES ('정준하', 31, 183, NULL, '신보라');
INSERT INTO tblMen VALUES ('정형돈', 28, NULL, 92, NULL);
INSERT INTO tblMen VALUES ('양세형', 22, 166, 55, '김민경');
INSERT INTO tblMen VALUES ('조세호', 24, 165, 58, '오나미');

INSERT INTO tblWomen VALUES ('박나래', 23, 150, 55, NULL);
INSERT INTO tblWomen VALUES ('장도연', 28, 177, 65, '홍길동');
INSERT INTO tblWomen VALUES ('김지민', 30, 160, NULL, '박명수');
INSERT INTO tblWomen VALUES ('김숙', 34, 158, NULL, '유재석');
INSERT INTO tblWomen VALUES ('오나미', 27, NULL, NULL, '조세호');
INSERT INTO tblWomen VALUES ('김민경', 22, 169, 88, '양세형');
INSERT INTO tblWomen VALUES ('홍현희', 20, 158, 75, NULL);
INSERT INTO tblWomen VALUES ('신보라', 26, 170, 60, '정준하');
INSERT INTO tblWomen VALUES ('이세영', 28, 163, NULL, '아무개');
INSERT INTO tblWomen VALUES ('신봉선', 27, 162, NULL, NULL);


COMMIT;

select * from tblWomen;