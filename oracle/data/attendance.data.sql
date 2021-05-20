-- 근태
create table tblAttendance
(
	seq number primary key,
	state varchar2(30) not null,
	regdate date not null
);

create sequence attendance_seq;

insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '정상', '2019-10-01');
insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '정상', '2019-10-02');
-- 10-03 : 공휴일
-- 10-04 : 결석
insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '지각', '2019-10-07');
insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '정상', '2019-10-08');
-- 10-09 : 공휴일
insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '정상', '2019-10-10');
insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '조퇴', '2019-10-11');
-- 10-12 : 토요일
-- 10-13 : 일요일
insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '정상', '2019-10-14');
insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '정상', '2019-10-15');
insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '지각', '2019-10-16');
insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '정상', '2019-10-17');
insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '정상', '2019-10-18');
-- 10-19 : 토요일
-- 10-20 : 일요일
insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '정상', '2019-10-21');
insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '지각', '2019-10-22');
-- 10-23 : 결석
insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '조퇴', '2019-10-24');
insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '정상', '2019-10-25');
-- 10-26 : 토요일
-- 10-27 : 일요일
insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '정상', '2019-10-28');
insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '정상', '2019-10-29');
insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '지각', '2019-10-30');
insert into tblAttendance (seq, state, regdate) values (attendance_seq.nextVal, '정상', '2019-10-31');

commit;
rollback;
select * from tblAttendance;







