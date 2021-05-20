create table tblZoo (
	seq number primary key,
	name varchar2(100) not null, --이름
	family varchar2(100) not null, --종류(어류, 양서류, 파충류, 조류, 포유류)
	leg number(2) not null, --다리수
	wing varchar2(1) check(wing in ('y', 'n')) not null, --날개(y,n)
	fly varchar2(1) check(fly in ('y', 'n')) not null, --날다(y,n)
	born varchar2(20) check(born in ('egg', 'young')) not null, --태생(알,새끼)
	breath varchar2(20) check(breath in ('gill', 'lung', 'skin')) not null, --호흡(아가미,폐,피부)
	thermo varchar2(20) check(thermo in ('constant', 'variable')) not null, --체온(항온,변온)
	sizeof varchar2(20) check(sizeof in ('small', 'medium', 'large')) not null --크기(소,중,대)
);

create sequence zoo_seq;


insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '대구', '어류', 0, 'n', 'n', 'egg', 'gill', 'variable', 'medium');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '송사리', '어류', 0, 'n', 'n', 'egg', 'gill', 'variable', 'small');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '고등어', '어류', 0, 'n', 'n', 'egg', 'gill', 'variable', 'medium');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '연어', '어류', 0, 'n', 'n', 'egg', 'gill', 'variable', 'medium');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '날치', '어류', 0, 'y', 'y', 'egg', 'gill', 'variable', 'medium');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '돔', '어류', 0, 'n', 'n', 'egg', 'gill', 'variable', 'medium');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '가다랑어', '어류', 0, 'n', 'n', 'egg', 'gill', 'variable', 'large');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '개복치', '어류', 0, 'n', 'n', 'egg', 'gill', 'variable', 'large');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '멸치', '어류', 0, 'n', 'n', 'egg', 'gill', 'variable', 'small');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '청새치', '어류', 0, 'n', 'n', 'egg', 'gill', 'variable', 'large');
	

insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '두꺼비', '양서류', 4, 'n', 'n', 'egg', 'lung', 'variable', 'small');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '개구리', '양서류', 4, 'n', 'n', 'egg', 'lung', 'variable', 'small');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '도룡뇽', '양서류', 4, 'n', 'n', 'egg', 'lung', 'variable', 'medium');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '청개구리', '양서류', 4, 'n', 'n', 'egg', 'lung', 'variable', 'small');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '영원', '양서류', 4, 'n', 'n', 'egg', 'lung', 'variable', 'small');
	
	
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '엘리게이터', '파충류', 4, 'n', 'n', 'egg', 'lung', 'variable', 'large');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '보아뱀', '파충류', 0, 'n', 'n', 'egg', 'lung', 'variable', 'large');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '도마뱀', '파충류', 4, 'n', 'n', 'egg', 'lung', 'variable', 'small');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '카멜레온', '파충류', 4, 'n', 'n', 'egg', 'lung', 'variable', 'medium');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '코브라', '파충류', 0, 'n', 'n', 'egg', 'lung', 'variable', 'medium');	
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '거북이', '파충류', 4, 'n', 'n', 'egg', 'lung', 'variable', 'medium');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '남생이', '파충류', 4, 'n', 'n', 'egg', 'lung', 'variable', 'small');



insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '벌새', '조류', 2, 'y', 'y', 'egg', 'lung', 'constant', 'small');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '제비', '조류', 2, 'y', 'y', 'egg', 'lung', 'constant', 'small');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '딱따구리', '조류', 2, 'y', 'y', 'egg', 'lung', 'constant', 'small');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '펭귄', '조류', 2, 'y', 'n', 'egg', 'lung', 'constant', 'medium');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '독수리', '조류', 2, 'y', 'y', 'egg', 'lung', 'constant', 'large');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '닭', '조류', 2, 'y', 'n', 'egg', 'lung', 'constant', 'medium');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '참새', '조류', 2, 'y', 'y', 'egg', 'lung', 'constant', 'small');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '신천옹', '조류', 2, 'y', 'y', 'egg', 'lung', 'constant', 'large');


insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '돼지', '포유류', 4, 'n', 'n', 'young', 'lung', 'constant', 'medium');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '양', '포유류', 4, 'n', 'n', 'young', 'lung', 'constant', 'medium');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '말', '포유류', 4, 'n', 'n', 'young', 'lung', 'constant', 'large');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '코끼리', '포유류', 4, 'n', 'n', 'young', 'lung', 'constant', 'large');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '원숭이', '포유류', 2, 'n', 'n', 'young', 'lung', 'constant', 'medium');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '고래', '포유류', 0, 'n', 'n', 'young', 'lung', 'constant', 'large');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '고슴도치', '포유류', 4, 'n', 'n', 'young', 'lung', 'constant', 'small');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '호랑이', '포유류', 4, 'n', 'n', 'young', 'lung', 'constant', 'large');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '바다표범', '포유류', 0, 'n', 'n', 'young', 'lung', 'constant', 'large');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '돌고래', '포유류', 0, 'n', 'n', 'young', 'lung', 'constant', 'medium');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '햄스터', '포유류', 4, 'n', 'n', 'young', 'lung', 'constant', 'small');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '토끼', '포유류', 4, 'n', 'n', 'young', 'lung', 'constant', 'small');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '캥거루', '포유류', 4, 'n', 'n', 'young', 'lung', 'constant', 'large');
insert into tblZoo (seq, name, family, leg, wing, fly, born, breath, thermo, sizeof)
	values (zoo_seq.nextval, '돼지', '포유류', 4, 'n', 'n', 'young', 'lung', 'constant', 'medium');

commit;

select * from tblZoo;
