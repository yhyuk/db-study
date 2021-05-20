-- diary.data.sql
-- 다이어리 테이블 + 데이터

CREATE TABLE tblDiary
(
	seq number primary key,
	subject varchar2(500) not null,
	weather varchar2(10) not null,
	regdate date not null
);

INSERT INTO tblDiary VALUES (1, '오라클을 처음으로 설치했다', '맑음', '2109-10-18');
INSERT INTO tblDiary VALUES (2, '자바 스터디 하는 날. 저녁에 카페에서 모임', '맑음', '2109-10-19');
INSERT INTO tblDiary VALUES (3, '에러가 나는데 어디서 나는지 모르겠다;;', '흐림', '2109-10-20');
INSERT INTO tblDiary VALUES (4, '영화보러 갔다가 자다왔다.', '흐림', '2109-10-22');
INSERT INTO tblDiary VALUES (5, '버거킹에 가서 와퍼 먹었다.', '맑음', '2109-10-18');
INSERT INTO tblDiary VALUES (6, '본체랑 마우스랑 키보드 바꾼날~', '비', '2109-10-18');
INSERT INTO tblDiary VALUES (7, '처음으로 코딩하며 잠들다!!', '맑음', '2109-10-20');
INSERT INTO tblDiary VALUES (8, '지각 안하고 가까스로 세이프..', '맑음', '2109-10-25');
INSERT INTO tblDiary VALUES (9, '손끝에 굳은살이 베기기 시작했다.', '비', '2109-10-26');
INSERT INTO tblDiary VALUES (10, '왜 에러는 내 눈에만 안보일까?', '흐림', '2109-10-28');

COMMIT;

select * from tblDiary;