-- housekeeping.data.sql
-- 장부 테이블 + 데이터

CREATE TABLE tblHousekeeping
(
	seq number primary key,
	item varchar2(50) not null,
	price number not null,
	qty number not null,
	buydate date not null,
	memo varchar2(1000) null
);

INSERT INTO tblHousekeeping VALUES (1, '양말', 2000, 5, '2018-08-05', null);
INSERT INTO tblHousekeeping VALUES (2, '티셔츠', 5000, 1, '2018-08-06', null);
INSERT INTO tblHousekeeping VALUES (3, '수저세트', 10000, 4, '2018-08-07', null);
INSERT INTO tblHousekeeping VALUES (4, '컵', 3000, 2, '2018-08-08', null);
INSERT INTO tblHousekeeping VALUES (5, '행주', 1000, 10, '2018-08-09', null);
INSERT INTO tblHousekeeping VALUES (6, '도마', 5000, 1, '2018-08-09', null);
INSERT INTO tblHousekeeping VALUES (7, '식칼', 15000, 1, '2018-08-10', null);
INSERT INTO tblHousekeeping VALUES (8, '위생봉투', 1000, 5, '2018-08-10', null);
INSERT INTO tblHousekeeping VALUES (9, '종이컵', 100, 100, '2018-08-10', null);
INSERT INTO tblHousekeeping VALUES (10, '물티슈', 1000, 50, '2018-08-13', null);
INSERT INTO tblHousekeeping VALUES (11, '건전지', 1000, 20, '2018-08-15', null);
INSERT INTO tblHousekeeping VALUES (12, '노트', 1400, 5, '2018-08-18', null);
INSERT INTO tblHousekeeping VALUES (13, '이쑤시개', 10, 3000, '2018-08-18', null);
INSERT INTO tblHousekeeping VALUES (14, '손톱깎이', 3000, 1, '2018-08-19', null);
INSERT INTO tblHousekeeping VALUES (15, '세제', 9000, 2, '2018-08-19', null);
INSERT INTO tblHousekeeping VALUES (16, '냄비받침대', 3000, 2, '2018-08-20', null);
INSERT INTO tblHousekeeping VALUES (17, '슬리퍼', 8000, 3, '2018-08-20', null);
INSERT INTO tblHousekeeping VALUES (18, '치약', 4000, 4, '2018-08-21', null);
INSERT INTO tblHousekeeping VALUES (19, '칫솔', 1700, 9, '2018-08-21', null);
INSERT INTO tblHousekeeping VALUES (20, '비누', 2500, 6, '2018-08-21', null);

COMMIT;

select * from tblHousekeeping;