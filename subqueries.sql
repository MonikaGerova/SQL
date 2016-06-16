/* ------------- ��������� ------------- */

/* ----- Movies ----- */
use movies;

/* ��� 1.1: �������� ������, ����� ������� ������� �� ���������, ����� �� ���� �
���������� � ����� ������ ��� 10 ������� */

select NAME
from MOVIESTAR
where GENDER='f' AND name in (select NAME
				from MOVIEEXEC
				where NETWORTH>10000000);

/* ��� 1.2: �������� ������, ����� ������� ������� �� ���� ������� (���� � ����),
����� �� �� ����������. */  

select NAME
from MOVIESTAR 
where not Exists (select MOVIEEXEC.NAME
					from MOVIEEXEC
					where MOVIESTAR.NAME=MOVIEEXEC.NAME);

/* ��� 1.3: �������� ������, ����� ������� ������� �� ������ ����� � �������,
��-������ �� ��������� �� ����� �Star Wars� */

select m1.TITLE
from MOVIE m1
where m1.LENGTH > (select LENGTH
						from MOVIE m2
						where m2.TITLE='Star wars');

/* ��� 1.4: �������� ������, ����� ������� ������� �� ������������ � �������
������� �� ������ �����, ����� �� ����������� �� ���������� � �����
������ (networth) ��-������ �� ���� �� �Merv Griffin� */

select MOVIE.TITLE,producers.NAME
from MOVIE,(select m2.NAME, m2.CERT#
				from MOVIEEXEC m1, MOVIEEXEC m2
				where m1.NAME='Merv Griffin' AND m2.NETWORTH>m1.NETWORTH) as producers
where movie.PRODUCERC# = producers.CERT#;

/* ----- PC ----- */
use pc;

/* ��� 2.1: �������� ������, ����� ������� ��������������� �� ����������
�������� � ������� ��� 500. */

select maker
from product
where product.model in (select pc.model
						from pc
						where pc.speed>500);

/* ��� 2.2: �������� ������, ����� ������� ���������� � ���-������ ����. */

select code,model,price
from printer
where price >=ALL (select price
					from printer);

/* ��� 2.3: �������� ������, ����� ������� ���������, ����� ������� � ��-����� ��
��������� �� ����� � �� � ���������� ��������. */

select *
from laptop
where speed <All (select pc.speed
				  from pc);

/*  ��� 2.4: �������� ������, ����� ������� ������ �� �������� (PC, ������ ���
�������) � ���-������ ����. */

select *
from (
		(	select model,price
			from pc
			where pc.price >= ALL (select p2.price
									from pc p2)) UNION 
		(	select model,price
			from laptop
			where laptop.price >= ALL (select l2.price
									from laptop l2)) UNION
		(	select model,price
			from printer
			where printer.price >= ALL (select p2.price
									from printer p2))
	) as prices
WHERE prices.price >= All (select prices2.price
						from  (
							(	select model,price
								from pc
								where pc.price >= ALL (select p2.price
														from pc p2)) UNION 
							(	select model,price
								from laptop
								where laptop.price >= ALL (select l2.price
														from laptop l2)) UNION
							(	select model,price
								from printer
								where printer.price >= ALL (select p2.price
														from printer p2))
						) as prices2 );


/* 
(SELECT DISTINCT L.model,L.price
FROM laptop L
WHERE L.price > ALL (SELECT pc.price
					 FROM pc) AND L.price >ALL (SELECT printer.price
												FROM printer) AND L.price >= ALL (SELECT laptop.price
																	  			  FROM laptop))
UNION
(SELECT P2.model,P2.price
FROM PRINTER P2
WHERE P2.price > ALL (SELECT pc.price
						FROM pc) AND P2.price > ALL(SELECT laptop.price
													FROM laptop) AND  P2.price > ALL (SELECT pc.price
																						FROM pc))
UNION
(SELECT DISTINCT P3.model,P3.price
FROM pc P3 
WHERE P3.price > ALL (SELECT laptop.price
						FROM laptop) AND P3.price >ALL (SELECT printer.price
														FROM printer) AND  P3.price > ALL (SELECT pc.price
																							FROM pc) ) 
*/

/* ��� 2.5: �������� ������, ����� ������� ������������� �� ������� ������� �
���-����� ����. */

select maker
from product
where product.model =( select printer.model
						from printer
						where price <= All (select p2.price
											from printer p2
											where p2.color='y') AND color='y'
					);

/* ��� 2.6: �������� ������, ����� ������� ��������������� �� ���� ����������
�������� � ���-����� RAM �����, ����� ���� ���-����� ���������. */

select maker
from product
where product.model IN (select p1.model
					 from pc p1
					 where EXISTS (select p2.ram
									from pc p2
									where p1.ram<p2.ram and p1.speed>p2.speed
								  )	 
					 );

/* SELECT P.maker
FROM product P JOIN pc P1 ON P.model = P1.model,pc P2
WHERE P1.speed > ALL (SELECT P2.speed) AND P1.ram <ALL (SELECT P2.ram)  */


/* ----- SHIPS ------ */
use ships;

/* ��� 3.1: �������� ������, ����� ������� ��������, ����� ������ �� � ���-�����
���� ������. */select DISTINCT COUNTRYfrom CLASSES where NUMGUNS >= ALL(select NUMGUNS						from CLASSES);				/* ��� 3.2: �������� ������, ����� ������� ���������, �� ����� ���� ���� ��
�������� � ������� � �����. */ 

select DISTINCT SHIPS.CLASS
from SHIPS JOIN (select SHIP
				from OUTCOMES
				where RESULT = 'sunk') as sunkt on sunkt.SHIP = SHIPS.NAME;

/*
select SHIPS.CLASS
from SHIPS,OUTCOMES
where SHIPS.NAME IN (select SHIP
					from OUTCOMES
					where result = 'sunk')
*/

/* ��� 3.3: �������� ������, ����� ������� ����� � ����� �� �������� � 16 ������
������ (bore). */

select NAME,CLASS
from ships 
where SHIPS.CLASS IN(select CLASS
						from CLASSES
						where bore=16);

/* ��� 3.4: �������� ������, ����� ������� ������� �� �������, � ����� ��
��������� ������ �� ���� �Kongo�. */

select BATTLE
from OUTCOMES
where SHIP IN (select NAME
				from SHIPS
				where CLASS='Kongo');

/* zad 3.5: �������� ������, ����� ������� ����� � ����� �� ��������, ����� ����
������ � ��-����� ��� ����� �� ���� �� �������� ��� ����� ������� ������ (bore). */

select DISTINCT ships.CLASS,ships.name
from ships JOIN CLASSES c1 on SHIPS.CLASS=c1.CLASS
where c1.NUMGUNS >= All (select NUMGUNS
						from CLASSES c2
						where c2.BORE = c1.BORE);