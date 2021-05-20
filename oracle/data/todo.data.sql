-- todo.data.sql
-- 할일 테이블 + 데이터

CREATE TABLE tblTodo
(
	seq number primary key,
	title varchar2(200) not null,
	adddate date not null,
	completedate date null
);

INSERT INTO tblTodo VALUES (1, '할일 계획 세우기', to_date('2019-10-01 06:00:00', 'yyyy-mm-dd hh24:mi:ss'), to_date('2019-10-01 18:30:00', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO tblTodo VALUES (2, '마트 장보기', to_date('2019-10-03 13:00:00', 'yyyy-mm-dd hh24:mi:ss'), to_date('2019-10-04 20:28:30', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO tblTodo VALUES (3, '자바 콘솔 프로젝트 에러잡기', to_date('2019-10-11 14:22:24', 'yyyy-mm-dd hh24:mi:ss'), to_date('2019-10-11 17:32:54', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO tblTodo VALUES (4, '내방 청소하기', to_date('2019-10-08 22:00:00', 'yyyy-mm-dd hh24:mi:ss'), NULL);
INSERT INTO tblTodo VALUES (5, '강아지 산책시키기', to_date('2019-10-07 10:11:34', 'yyyy-mm-dd hh24:mi:ss'), NULL);
INSERT INTO tblTodo VALUES (6, '다이어트 시작하기', to_date('2019-10-01 12:53:20', 'yyyy-mm-dd hh24:mi:ss'), NULL);
INSERT INTO tblTodo VALUES (7, '데이터베이스 책 대여하기', to_date('2019-10-02 11:34:52', 'yyyy-mm-dd hh24:mi:ss'), to_date('2019-10-15 12:10:15', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO tblTodo VALUES (8, '노트북 포맷하기', to_date('2019-10-02 19:32:12', 'yyyy-mm-dd hh24:mi:ss'), to_date('2019-10-02 19:50:22', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO tblTodo VALUES (9, '치과 예약하기', to_date('2019-10-04 11:22:33', 'yyyy-mm-dd hh24:mi:ss'), to_date('2019-10-08 12:32:02', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO tblTodo VALUES (10, '아마존에서 키보드 직구하기', to_date('2019-10-08 09:21:11', 'yyyy-mm-dd hh24:mi:ss'), NULL);
INSERT INTO tblTodo VALUES (11, '스타벅스 다이어리 예약하기', to_date('2019-10-02 17:23:43', 'yyyy-mm-dd hh24:mi:ss'), to_date('2019-10-03 15:43:21', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO tblTodo VALUES (12, '헌혈하기', to_date('2019-10-09 23:33:23', 'yyyy-mm-dd hh24:mi:ss'), to_date('2019-10-12 15:48:52', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO tblTodo VALUES (13, '친구에게 전화하기', to_date('2019-10-09 14:42:21', 'yyyy-mm-dd hh24:mi:ss'), to_date('2019-10-09 15:32:34', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO tblTodo VALUES (14, '비행기 티켓 예약하기', to_date('2019-10-06 12:23:53', 'yyyy-mm-dd hh24:mi:ss'), to_date('2019-10-11 09:46:22', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO tblTodo VALUES (15, '아르바이트 계약서 작성하기', to_date('2019-10-12 12:30:23', 'yyyy-mm-dd hh24:mi:ss'), to_date('2019-10-12 15:32:45', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO tblTodo VALUES (16, '과제 제출하기', to_date('2019-10-10 15:03:21', 'yyyy-mm-dd hh24:mi:ss'), NULL);
INSERT INTO tblTodo VALUES (17, 'AS 센터 방문하기', to_date('2019-10-11 22:44:22', 'yyyy-mm-dd hh24:mi:ss'), to_date('2019-10-12 16:30:52', 'yyyy-mm-dd hh24:mi:ss'));
INSERT INTO tblTodo VALUES (18, '스터디 그룹 짜기', to_date('2019-10-03 22:10:20', 'yyyy-mm-dd hh24:mi:ss'), NULL);
INSERT INTO tblTodo VALUES (19, '운전 면허 갱신하기', to_date('2019-10-06 21:21:02', 'yyyy-mm-dd hh24:mi:ss'), NULL);
INSERT INTO tblTodo VALUES (20, '헬스 등록하기', to_date('2019-10-05 19:24:42', 'yyyy-mm-dd hh24:mi:ss'), NULL);

COMMIT;

select * from tblTodo;