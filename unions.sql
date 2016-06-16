
/* ---- Movies ----- */
use movies;

/* ��� 1.1: �������� ������, ����� ������� ����� �� ���������� � ������� ��
�������, ����������� �� ���������� �� �Star Wars�. */

select TITLE,NAME
from MOVIEEXEC JOIN MOVIE on PRODUCERC# = CERT#
where PRODUCERC# in ( select PRODUCERC#
						from MOVIE
						where title='Star Wars'
					);

/* ��� 1.2: �������� ������, ����� ������� ������� �� ������������ �� �������
�� �Harrison Ford�. */

select NAME
from MOVIEEXEC 
where cert# in (select PRODUCERC#
				from MOVIE JOIN STARSIN on MOVIETITLE=TITLE
				where STARNAME='Harrison Ford'
				);

/* ��� 1.3: �������� ������, ����� ������� ����� �� �������� � ������� ��
���������, ��������� ��� ����� ����������� �� ���� ������, ���������
�� ��� �� ������. */

select DISTINCT STUDIONAME,STARNAME
from MOVIE JOIN STARSIN on TITLE=MOVIETITLE
order by STUDIONAME asc;


/* ��� 1.4: �������� ������, ����� ������� ������� �� ������� (���������),
��������� ��� ����� �� ���-������ �������� (networth). */

select STARNAME,MOVIETITLE,NETWORTH
from  STARSIN JOIN Movie ON TITLE=MOVIETITLE JOIN MOVIEEXEC ON PRODUCERC# = CERT# 
where NETWORTH >= All (select NETWORTH
						from MOVIEEXEC);


/* ��� 1.5: �������� ������, ����� ������� ������� �� ���������, ����� �� ��
��������� � ���� ���� ����. */

select NAME,MOVIETITLE
from MOVIESTAR LEFT JOIN STARSIN on NAME=STARNAME
where MOVIETITLE is NULL

/* ---- PC ---- */
use pc;
/* ��� 2.1: �������� ������, ����� ������� ������������, ����� � ��� �� �������
�� ���� �������������, �� ����� ���������� ������� �� �� ������� 
(���� �� � ��������� PC, Laptop ��� Printer) */


select product.maker,product.model,product.type
from product LEFT JOIN (
					(select model
					from pc ) UNION
					(select model
					from printer ) UNION
					(select model
					from laptop )
				) as Models on Models.model = product.model
where Models.model is NULL;


/* ��� 2.2: �������� ������ �������������, ����� ������ ����� �������, ���� �
��������. */
 
 select DISTINCT p1.maker
 from product p1 JOIN product p2 ON p1.maker=p2.maker  
 where p1.type='laptop' AND p2.type='printer';

 /* ��� 2.3: �������� ��������� �� ���� ������ �������, ����� �� �������� � ���
��� ������ ������ �������. */

select DISTINCT l1.hd
from laptop l1 JOIN laptop l2 ON l1.hd=l2.hd AND l1.code!=l2.code

/* ��� 2.4: �������� ������ ������ ���������� ��������, ����� ����� �����������
������������. */

select pc.model
from pc LEFT JOIN product ON pc.model = product.model
where product.maker is NULL

/* ---- SHIPS ---- */
use ships;

/* ��� 3.1: �������� ������, ����� ������� ������ ������� ���������� �� �����
�����, ����������� � ������� �� ������� ����. � ��������� �� ������ ��
�� �������� ���� �������, ����� ����� ������ */

select *
from SHIPS LEFT JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
where CLASSES.CLASS IS NOT NULL;


/* ��� 3.2: ��������� ������� ������, ���� ���� ��� �������� � ��������� �
���������, ����� ����� ������, �� ����������� ������ ��� ������ ���
���� �������. */

select *
from SHIPS FULL JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS;

/* ��� 3.3: �� ����� ������ �������� ������� �� ��������, ����� ������ �� ��
��������� � �����. */

select CLASSES.COUNTRY,SHIPS.NAME
from CLASSES JOIN SHIPS ON SHIPS.CLASS=CLASSES.CLASS LEFT JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
where OUTCOMES.BATTLE is NULL;
					
/* ��� 3.4: �������� ������� �� ������ ������ � ���� 7 ������, ������� �� ����
���� 1916, �� �������� ������������ ������ Ship Name. */

select SHIPS.NAME
from SHIPS JOIN CLASSES on SHIPS.CLASS = CLASSES.CLASS 
where SHIPS.LAUNCHED=1916 AND CLASSES.NUMGUNS>=7 

/* ��� 3.5: ������� �� ������ �������� � ����� ������, ����� � ���� �� ����������
�� �������, � ����� �� ��  */

select OUTCOMES.SHIP,BATTLES.NAME, BATTLES.DATE
from OUTCOMES JOIN BATTLES ON BATTLES.NAME=OUTCOMES.BATTLE
where OUTCOMES.RESULT='sunk';

/* ��� 3.6: �������� ������� � �������� �� ������� �� ���� �� ������ ������, �����
���� ������ ��� ���� ������ ����. */


select SHIPS.NAME,CLASSES.DISPLACEMENT,SHIPS.LAUNCHED
from SHIPS JOIN CLASSES ON SHIPS.CLASS= CLASSES.CLASS AND SHIPS.NAME = CLASSES.CLASS;

/* ��� 3.7: �������� ������ ������� ������, �� ����� ���� ������ �� ���� ���� ����
�����. */

select *
from CLASSES LEFT JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
where SHIPS.LAUNCHED is NULL;

/* ------------------------------------------------------------------------- */

select *
from CLASSES
where CLASSES.CLASS IN (select CLASSES.CLASS
						from CLASSES LEFT JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
						where SHIPS.LAUNCHED is NULL);



/* ��� 3.8: �������� �������, �������� � ���� ������ �� ��������, ��������� �
������� �North Atlantic�, � ���� � ��������� �� ������� */


select SHIPS.NAME,CLASSES.DISPLACEMENT,CLASSES.NUMGUNS,OUTCOMES.RESULT
from SHIPS JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS 
		JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
where OUTCOMES.BATTLE='North Atlantic' 


