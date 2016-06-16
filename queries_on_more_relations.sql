
/* ----- Movies ----- */
use movies;

/* ��� 1: �������� ������, ����� ������� ������� �� ��������� ����, ��������� �
			�Terms of Endearment�. */

select NAME
from MOVIESTAR join STARSIN on STARSIN.STARNAME = MOVIESTAR.NAME
where MOVIESTAR.GENDER='M' AND STARSIN.MOVIETITLE='Terms of Endearment';

/* ��� 2: �������� ������, ����� ������� ������� �� ���������, ��������� ��� �����,
			����������� �� ������ �MGM� ���� 1995 �. */

select STARNAME
from STARSIN,STUDIO
where MOVIEYEAR=1995 and STUDIO.NAME='MGM';

/* ��� 3: �������� ������, ����� ������� ������� �� ������������, ����� ��
			����������� ����� �� ������ �MGM� */

select DISTINCT name
from movie JOIN MOVIEEXEC on PRODUCERC#=CERT# 
where STUDIONAME='MGM';

/* ��� 4: �������� ������, ����� ������� ������� �� ������ ����� � �������, ��-
			������ �� ��������� �� ����� �Star Wars� */

select m2.TITLE
from movie m1,movie m2
where m1.TITLE='Star wars' AND m1.LENGTH<m2.LENGTH;

/* ��� 5: �������� ������, ����� ������� ������� �� ������������ � ����� ������
			(networth) ��-������ �� ���� �� �Merv Griffin�. */

select m2.NAME
from MOVIEEXEC m1, MOVIEEXEC m2
where m1.NAME = 'Merv Griffin' and m1.NETWORTH<m2.NETWORTH;

/* ��� 6: �������� ������, ����� ������� ������� �� ������ �����, ����� ��
			����������� �� ���������� � ����� ������ (networth) ��-������ �� ���� �� �Merv Griffin�. */

select TITLE
from MOVIE,MOVIEEXEC m1,MOVIEEXEC m2
where movie.PRODUCERC# = m2.CERT# AND m1.NAME = 'Merv Griffin' and m1.NETWORTH<m2.NETWORTH;


/* ----- PC ----- */
use pc;

/* ��� 1: �������� ������, ����� ������� ������������� � ��������� (speed) �� ����
			������� � ������ �� ����� ���� 9 GB. */

select product.maker,laptop.speed
from laptop JOIN product on laptop.model = product.model
where hd>=9;

/* ��� 2: �������� ������, ����� ������� ����� �� ����� � ���� �� ������ ��������,
			����������� �� ������������ � ��� �B�. */

(Select product.model, pc.price
from product JOIN pc on product.model=pc.model
where maker='B') UNION
(Select product.model, laptop.price
from product JOIN laptop on product.model=laptop.model
where maker='B')UNION
(Select product.model, printer.price
from product JOIN printer on product.model=printer.model
where maker='B');

/* ��� 3: �������� ������, ����� ������� ��������� �� ���� �������, ����� �� ���������
			� ���� ��� �������� ��������� (��� ��������� � �������� ���). */

select DISTINCT p1.hd
from pc p1 JOIN pc p2 on p1.code!=p2.code
where p1.hd=p2.hd;
 
/* ��� 4: �������� ������, ����� ������� ������ ������ ������ �� ��������, ����� ����
			������� ������� � �����. �������� ������ �� �� �������� ���� �� ������,
			�������� ���� (i, j), �� �� � (j, i). */

select DISTINCT p1.model,p2.model
from pc p1 JOIN pc p2 on p1.model!=p2.model
where p1.speed=p2.speed AND p1.ram=p2.ram and p1.model<p2.model;


/* ��� 5: �������� ������, ����� ������� ��������������� �� ���� ��� ��������
			��������� � ������� ���� 400. */

select DISTINCT p1.maker
from product p1 join pc pc1 on pc1.model=p1.model,product p2 join pc pc2 on pc2.model=p2.model
where pc1.code!=pc2.code AND pc1.speed>=400  AND p1.maker=p2.maker;


/* ----- SHIPS ----- */
use ships;

/* ��� 1: �������� ������, ����� ������� ����� �� �������� � ��������������� ��� 50000. */

select SHIPS.NAME
from CLASSES JOIN SHIPS on SHIPS.CLASS=CLASSES.CLASS
where DISPLACEMENT>50000;

/* ��� 2: �������� ������, ����� ������� �������, ����������������� � ���� ������ ��
			������ ������, ��������� � ������� ��� �Guadalcanal�. */

select SHIPS.NAME,DISPLACEMENT,NUMGUNS
from CLASSES JOIN SHIPS on SHIPS.CLASS = CLASSES.CLASS JOIN OUTCOMES on SHIPS.NAME=OUTCOMES.SHIP
where battle = 'Guadalcanal';

/* ��� 3: �������� ������, ����� ������� ������� �� ���� �������, ����� ���� ������
			�� ��� �bb� � �bc� ������������. */

select DISTINCT c1.COUNTRY
from CLASSES c1, CLASSES c2 
where c1.TYPE !=c2.TYPE AND c1.COUNTRY=c2.COUNTRY;

/* ��� 4: �������� ������, ����� ������� ������� �� ���� ������, ����� �� ����
			��������� � ���� �����, �� ��-����� �� ��������� � ����� �����. */

select distinct o1.SHIP
from OUTCOMES o1 JOIN OUTCOMES o2 on o1.SHIP=o2.SHIP
where o1.RESULT!=o2.RESULT;










