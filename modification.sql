use movies;

/* �� �� ������ ���������� �� ��������� Nicole Kidman. �� ��� ����� ����, �� � ������ ��
20.06.1967. */

/* select * from MOVIESTAR */

INSERT INTO MOVIESTAR(name,gender,BIRTHDATE)
VALUES('Nicole Kidman','f','1967-06-20');

/*select * from MOVIESTAR; */


/* �� �� ������� ������ ���������� � ����� ������ (networth) ��� 30 �������. */

/* select * from MOVIEEXEC */

Delete from MOVIEEXEC
where NETWORTH<30000000

/* select * from MOVIEEXEC */

/* . �� �� ������ ������������ �� ������ ������� ������, �� ����� �� �� ���� ������. */

/* select * from MOVIESTAR */

delete from MOVIESTAR 
where ADDRESS is null

/* select * from MOVIESTAR */

use pc;

/* ����������� ��� INSERT ������. ��������� � ������ ����� �����, �� ���������� ��������
����� 1100 � �������� �� ������������� C, ��� �������� 2400 MHz, RAM 2048 MB, ����� ����
500 GB, 52x ������� ������� ���������� � ������ $299. ���� ������ �������� ��� ��� 12.
���������: ����� � CD �� �� ��� ��� */


 INSERT INTO product(maker,model,type)
values('C','1100','pc');

Insert INTO PC(code,MODEL,speed,ram,hd,cd,PRICE) 
values(12,'1100',2400,2048,500,'52x',299)

/* select * from product 
select * from pc */

/* �� �� ������ ��������� ���������� �� �������� ����� 1100. */

delete from product 
where model='1100'

delete from pc
where model='1100'


/* �� �� ������� ������ �������, ��������� �� ������������, ����� �� ���������� �������� */


/* select * from laptop
select * from product */

DELETE FROM laptop
where model in (
				select model
				from product
				where type='laptop' AND maker NOT IN (  select DISTINCT p1.maker
													from product p1 join product p2 on p1.maker=p2.maker
													where p1.type='laptop' AND p2.type='printer'
												)
				); 

 DELETE FROM product
where model in (
				select model
				from product
				where type='laptop' AND maker NOT IN (  select DISTINCT p1.maker
													from product p1 join product p2 on p1.maker=p2.maker
													where p1.type='laptop' AND p2.type='printer'
												)
				)

/* select * from laptop 
select * from product */


/* ������������ � ������ ������������ B. �� ������ �������� �� � ��������� ������������� �� ���� �. */

/*select * from product; */

/*UPDATE product
set maker='A'
where maker='B' */

/*select * from product;*/
 

 /* �� �� ������ ��� ���� ������ �� ����� �������� � �� �� ������� �� 20 GB ��� ����� ����� ����. */

 /*select * from pc */

 UPDATE pc
 set price=price/2 , hd=hd+20;

 /*select * from pc; */ 

 /* �� ����� ������ �� ������������ B �������� �� ���� ��� ��� ��������� �� ������. */

 UPDATE laptop
 set screen=screen+1
 where model in ( select model from product where maker='B' and type='laptop') 


/* select * from laptop */


use ships;

/* 0. ��� ��������� ����� ������ �� ����� Nelson - Nelson � Rodney - �� ���� ������� �� ����
������������ ���� 1927 �. ����� �� ����� 16-������ ������ (bore) � ��������������� �� 34000
���� (displacement). �������� ���� ����� ��� ������ �� �����. */

insert into CLASSES(CLASS,bore,DISPLACEMENT,COUNTRY,NUMGUNS,TYPE)
values('Nelson',16,34000,'Britain',9,'bb')

insert into CLASSES(CLASS,bore,DISPLACEMENT,COUNTRY,NUMGUNS,TYPE)
values('Rodney',16,34000,'Britain',9,'bb')


INSERT INTO SHIPS(CLASS,NAME,LAUNCHED)
values('Nelson','Nelson',1927)

INSERT INTO SHIPS(CLASS,NAME,LAUNCHED)
values('Rodney','Rodney',1927)

/* �������� �� Ships ������ ������, ����� �� �������� � ����� */

delete from SHIPS
where NAME in ( select SHIP from OUTCOMES where result='sunk')

/* ��������� ������� � ��������� Classes ����, �� ��������� (bore) �� �� ������� � ���������� (�
������� � � ������, 1 ��� ~ 2.5 ��) � ����������������� �� �� ������� � �������� ������ (1 �.�.
= 1.1 �.) */

update CLASSES
set bore=bore*2.5, DISPLACEMENT=DISPLACEMENT/1.1


















