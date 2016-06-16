/* ---- PC ---- */
use PC;

/* ��� 1.1: �������� ������, ����� ������� �������� ������� �� ����������  */

select AVG (speed)
from PC

/* ��� 1.2: �������� ������, ����� ������� ������� ������ �� �������� �� ��������� �� ����� ������������  */

select product.maker , AVG(laptop.screen)
from product JOIN laptop ON product.model=laptop.model
GROUP BY product.maker

/* ��� 1.3: �������� ������, ����� ������� �������� ������� �� ��������� � ���� ��� 1000 */

select AVG(speed)
from laptop
where price>=1000;

/* ��� 1.4: �������� ������, ����� ������� �������� ���� �� ���������� ����������� �� ������������ �A�  */

select product.maker, AVG(price) as 'Average Price'
from product JOIN pc ON product.model=pc.model
where product.maker='A'
group by product.maker;


/* ��� 1.5: �������� ������, ����� ������� �������� ���� �� ���������� � ��������� �� ������������ �B�  */

select AVG(price)
from (
	(select maker,price,code
	from product JOIN laptop ON product.model=laptop.model) UNION
	(select maker,price,code
	from product JOIN pc ON product.model=pc.model) 
	) as products
where products.maker='B';

/* ��� 1.6: �������� ������, ����� ������� �������� ���� �� ���������� ������ ���������� �� �������  */

select speed,AVG(price) as 'Average Price'
from PC
GROUP BY speed;

/* ��� 1.7: �������� ������, ����� ������� ���������������, ����� �� ��������� ���� �� 3 �������� ������ ��������� */

/* --------- GRESHNO ----------- 2111 and 2112 are not for sale */
select MAKER, COUNT(model)
from product
WHERE TYPE='pc'
group BY maker
HAVING COUNT(model)>=3;

/* ------------- VQRNO ------------- */

select MAKER, COUNT(DISTINCT product.model)
from product JOIN pc on product.model=pc.model
group BY maker
HAVING COUNT(DISTINCT product.model)>=3;

 
/* ��� 1.8:  �������� ������, ����� ������� ��������������� �� ���������� � ���-������ ���� */

select product.maker, pc.price
from product JOIN pc ON product.model=pc.model
where pc.price = ( 
					select MAX(pc.price)
					from pc
				 );

/* ��� 1.9: �������� ������, ����� ������� �������� ���� �� ���������� �� ����� ������� ��-������ �� 800 */
	
select speed,AVG(price)
from pc
where speed>=500
group by speed;

/* ��� 1.10: �������� ������, ����� ������� ������� ������ �� ����� �� ���� ��������,
 ����������� �� �������������, ����� ����������� � �������� */

 /* ---- GRESHNO  Izkarva nqkolko PC-ta po nqkolko puti------ */

select  AVG(pc.hd) as 'Average hd', COUNT (pc.model)
from (product p1 JOIN pc ON p1.model=pc.model) 
		JOIN (product p2 JOIN printer ON p2.model=printer.model) ON p1.maker=p2.maker


/* --- VqRNO ---- */

select AVG(pc.hd)
from pc join product p on p.model=pc.model
where maker in
		(select distinct maker
		from product
		where type='Printer');


/* ��� 1.11: �������� ������, ����� �� ����� ������ �� ������ ������ ��������� � ������
 �� ���-������ � ���-������� ������ ��� ����� ������ */

 select screen, (MAX(price)-Min(price) ) as 'MaxPrice - MinPrice', COUNT (*) as 'Broi laptopi s tozi razmer'
 from laptop
 group by screen;


/* ---- SHIPS ---- */
use ships;

/* ��� 2.1:  �������� ������, ����� ������� ���� �� ��������� ������ */

select COUNT(*) as 'Count of classes'
from CLASSES;

/* ��� 2.2: �������� ������, ����� ������� ������� ���� �� ������ �� ������ ������, ������� �� ���� */

select AVG(CLASSES.NUMGUNS) as ' average NUMGUNS'
from SHIPS JOIN CLASSES ON SHIPS.CLASS=CLASSES.CLASS
where LAUNCHED is NOT NULL


/* ��� 2.3:  �������� ������, ����� ������� �� ����� ���� ������� � ���������� ������,
 � ����� ����� �� ���������� ���� � ������ �� ���� */

select class, MIN(LAUNCHED) as 'First Launched ship', MAX(LAUNCHED) as 'Last launched ship'
from SHIPS
group by CLASS


/* ��� 2.4: �������� ������, ����� ������� ���� �� �������� �������� � ����� ������ ����� */

select CLASS,COUNT(*) as 'sunk ships'
from SHIPS JOIN OUTCOMES ON SHIPS.NAME=OUTCOMES.SHIP
where OUTCOMES.RESULT='sunk'
group by SHIPS.CLASS

/* ��� 2.5: �������� ������, ����� ������� ���� �� �������� �������� � ����� ������ �����,
 �� ���� ������� � ������ �� 4 ������� �� ���� ������  */


select  CLASS, count(RESULT) as 'SUNK SHIPS'
from OUTCOMES JOIN SHIPS ON OUTCOMES.SHIP=SHIPS.NAME
where OUTCOMES.RESULT='sunk' AND ships.CLASS IN (
												select CLASS
												from SHIPS
												group by CLASS
												having COUNT(SHIPS.LAUNCHED)>4
											)
group by CLASS

/* ��� 2.6:  �������� ������, ����� ������� �������� ����� �� ��������, �� ����� ������.  */


/* ---greshnoo zashtoto germaniq nqma korabi ---- */
select COUNTRY, AVG(DISPLACEMENT) as 'Average Displacement'
from CLASSES
group by COUNTRY

/* ---- vqrnoo --- */

select country,avg(displacement) as avg_displacement
from classes join ships on CLASSES.class=SHIPS.class
group by country;









