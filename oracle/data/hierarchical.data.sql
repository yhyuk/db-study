drop table tblComment;
drop table tblBoard;

-- 계층형 게시판
create table tblBoard
(
    seq number primary key,
    subject varchar2(1000) not null,
    pseq number null --부모 글번호
);


INSERT INTO tblboard VALUES (1, '1번 글입니다.', NULL);
INSERT INTO tblboard VALUES (2, '2번 글입니다.', NULL);
INSERT INTO tblboard VALUES (3, '3번 글입니다.', NULL);

INSERT INTO tblboard VALUES (4, '1번의 첫번째 답변글입니다.', 1);
INSERT INTO tblboard VALUES (5, '1번의 두번째 답변글입니다.', 1);
INSERT INTO tblboard VALUES (6, '1번의 세번째 답변글입니다.', 1);

INSERT INTO tblboard VALUES (7, '2번의 첫번째 답변글입니다.', 2);
INSERT INTO tblboard VALUES (8, '2번의 두번째 답변글입니다.', 2);

INSERT INTO tblboard VALUES (9, '3번의 첫번째 답변글입니다.', 3);
INSERT INTO tblboard VALUES (10, '3번의 두번째 답변글입니다.', 3);
INSERT INTO tblboard VALUES (11, '3번의 세번째 답변글입니다.', 3);

INSERT INTO tblboard VALUES (12, '1번의 첫번째 답변의 첫번째 답변글입니다.', 4);
INSERT INTO tblboard VALUES (13, '1번의 첫번째 답변의 두번째 답변글입니다.', 4);

INSERT INTO tblboard VALUES (14, '2번의 첫번째 답변의 첫번째 답변글입니다.', 7);
INSERT INTO tblboard VALUES (15, '3번의 두번째 답변의 첫번째 답변글입니다.', 10);








-- 카테고리 테이블
create table tblCategory
(
    seq number primary key,
    name varchar2(100) not null,
    pseq number null --부모 카테고리
);



INSERT INTO tblcategory VALUES (1, '패션의류/잡화', NULL);
INSERT INTO tblcategory VALUES (2, '뷰티', NULL);
INSERT INTO tblcategory VALUES (3, '주방용품', NULL);
INSERT INTO tblcategory VALUES (4, '남성패션', 1);
INSERT INTO tblcategory VALUES (5, '여성패션', 1);
INSERT INTO tblcategory VALUES (6, '베이비패션', 1);
INSERT INTO tblcategory VALUES (7, '티셔츠', 4);
INSERT INTO tblcategory VALUES (8, '셔츠', 4);
INSERT INTO tblcategory VALUES (9, '블라우스', 5);
INSERT INTO tblcategory VALUES (10, '원피스', 5);
INSERT INTO tblcategory VALUES (11, '스커트', 5);
INSERT INTO tblcategory VALUES (12, '베이비 여아', 6);
INSERT INTO tblcategory VALUES (13, '베이비 남아', 6);
INSERT INTO tblcategory VALUES (14, '베이비 공용', 6);
INSERT INTO tblcategory VALUES (15, '스킨케어', 2);
INSERT INTO tblcategory VALUES (16, '향수', 2);
INSERT INTO tblcategory VALUES (17, '기초 화장품', 15);
INSERT INTO tblcategory VALUES (18, '클렌징', 15);
INSERT INTO tblcategory VALUES (19, '마스크', 15);
INSERT INTO tblcategory VALUES (20, '여성 향수', 16);
INSERT INTO tblcategory VALUES (21, '남성 향수', 16);
INSERT INTO tblcategory VALUES (22, '그릇', 3);
INSERT INTO tblcategory VALUES (23, '컵', 3);
INSERT INTO tblcategory VALUES (24, '일회용품', 3);
INSERT INTO tblcategory VALUES (25, '식기', 22);
INSERT INTO tblcategory VALUES (26, '유아식기', 22);
INSERT INTO tblcategory VALUES (27, '머그', 23);
INSERT INTO tblcategory VALUES (28, '와인잔', 23);
INSERT INTO tblcategory VALUES (29, '텀블러', 23);
INSERT INTO tblcategory VALUES (30, '위생백', 24);


commit;
