--ex02_datatype.sql

/*

    ���ο� �� ���Ҷ�, �ڷ����� ���� �ľ��غ���..
    
    <ANSI-SQL �ڷ���>
    - ����Ŭ �ڷ���
    - �����ͺ��̽� > ������ > �ڷ���
    
    1. ������: ���� + �Ǽ�(����Ŭ�� ���� ������ ����)
        - ǥ�����: number
        - ��ȿ�ڸ�: 38�ڸ� ������ ���ڸ� ǥ���ϴ� �ڷ���
        - ����Ʈ: 5~22byte
        - number(percision, scale)
            1) precision : �Ҽ� ���ϸ� ������ ��ü �ڸ���(1~38)
            2) scale: �Ҽ� ������ �ڸ���(0~127)
            ex) number -> 38�ڸ����� ǥ�� ������ ��� ����(����,�Ǽ� ����)
            ex) number(3) -> 3�ڸ����� ǥ�� ������ ����(����) -> -999 ~ +999
            ex) number(4,2) -> 4�ڸ������� ǥ�� ���� ����(�Ǽ�) -> -99.99 ~ +99.99
            ex) number(10,3) -> -9999999.999 ~ +9999999.999
        - ������ ���(���ͷ�)
            1) ����: 123
            2) �Ǽ�: 3.14
        - ����Ŭ���� byte, int, float���� �ֱ������� ��� XXX
            

*/

--���̺� �����ϱ�
drop table tblType;

--���̺� �����ϱ�
create table tblType (
    -- �÷� ����
    -- �÷��� �ڷ���
    --num number
    --num number(3)
    num number(4,2)
);

--���̺��� ��� ������ �������ÿ�
select * from tblType;

--������ �߰��ϱ�
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

    2. ������: ���� + ���ڿ�(����Ŭ�� ����, ���ڿ� ���о���)
        - �ڹ��� String�� ����
        - ǥ�����
            - ���� �����ϴ¹�
            - n(X) vs n(O)
            - var(X) vs var(O) -> var: ������ ũ�Ⱑ ���Ѵ�.
            1) char (************************)
                - ���� �ڸ��� ���ڿ� -> �������� �����Ͱ� ª�Ƶ� ������ ������ �״�� �����Ѵ�. (��������)
                - char(n): n�ڸ� ���ڿ�, n(����Ʈ)
                    -�ּ� ũ��: 1byte
                    -�ִ� ũ��: 2000byte
                    ex) char -> X
                    ex) char(3) -> �ִ� 3����Ʈ���� ���ڿ��� ���� -> ���ڵ�? -> ����(3����), �ѱ�(1����)
                    ex) char(10) -> �ִ� 10����Ʈ���� ���ڿ��� ���� -> ����(10����), �ѱ�(3����);
                    ex) char(2000) -> ����(2000����), �ѱ�(666����)
            2) nchar
                - n : national > �����ڵ� ���� > UTF-16 ����(��� ���� -> 2byte)
                - nchar(n) : n�ڸ� ���ڿ�, n(���� ��)
                    -�ּ� ũ��: 1����(2byte)
                    -�ִ� ũ��: 1000����(2000byte)
                - ��� �ƴ� ���ڸ� ������ �� ����
            
            3) varchar2 (************************)
                - ���� �ڸ��� ���ڿ� -> ������ ũ�⸸ŭ ������ ũ�Ⱑ �پ���.
                - varchar2(n) : n�ڸ� ���ڿ�, n(����Ʈ)
                    -�ּ� ũ��: 1byte
                    -�ִ� ũ��: 4000byte
                
            4) nvarchar2
            
            lob(Large Object)
            5) clob, nclob
                - ��뷮 �ؽ�Ʈ ���� �ڷ���
                - 128TB
                - �� ��� ����, ������
                

    3. ��¥/�ð���
        - �ڹ� Calendar, Date
        1) date(******)
            - ����Ͻú���
            - ũ��: 7byte
            - ����� 4712�� 1�� 1�� ~ 9999�� 12�� 31��
        2) timestamp
            - ����Ͻú��� + �и���(������)
        3) interval
            - ƽ��
            - �ð�
            - number ���
    
    4. ���� ������ �ڷ���
        - �ؽ�Ʈ�� �ƴ� ������
        - �̹���, ����, ���� ��...
        1) blob
            -128TB
        - �߾Ⱦ��δ�....
            
        <���߿� ���� �Խ��� ���� ��>
        ÷�� ���� -> ÷�� ���ϸ�(+���) -> ���ڿ� -> varchar2




    ���� �ڷ��� ���͵� ������ڸ�.....
    number + varchar2 + date �� 3������ ���� ���� ���δ�.
*/

--char(n), varchar2(n) ����
drop table tblType;

create table tblType (
    --name char(3) --char ����
    --name char(10),
    --nick varchar2(10) --varchar2 ����
    
    name char(10),
    nick nchar(10) --nchar ����
);

select * from tblType;

--char(n)
insert into tblType (name) values ('abc');
insert into tblType (name) values ('abcd'); --value too large for column "HR"."TBLTYPE"."NAME" (actual: 4, maximum: 3)
insert into tblType (name) values ('��');
insert into tblType (name) values ('ȫ�浿'); --(actual: 9, maximum: 3)
insert into tblType (name) values ('123');
insert into tblType (name) values ('&*(');

--varchar2(n)
insert into tblType (name, nick) values ('abc', 'abc');
-- char     -> 'abc       ' -> ������ ���� �߰��Ǽ� �����(���ʿ��� ���� ����)
-- varchar2 -> 'abc'        -> ������ ũ�� ��ŭ �پ��
-- --> char(����), varchar2(����) ������

--nchar(n)
insert into tblType (name, nick) values ('ȫ�浿', 'ȫ�浿');
insert into tblType (name, nick) values ('ȫ�浿��', 'ȫ�浿��');
insert into tblType (name, nick) values ('ȫ�浿', 'ȫ�浿��');
insert into tblType (name, nick) values ('ȫ�浿', 'ȫ�浿�Ծȳ��ϼ���ȣ.');


drop table tblType;

create table tblType (

    name varchar2(30),  --�̸�
    age number(3),      --����
    birthday date       --����

);

insert into tblType (name, age, birthday) values ('ȫ�浿', 20, '1995-11-28');












