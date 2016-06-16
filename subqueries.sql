/* ------------- ПОДЗАЯВКИ ------------- */

/* ----- Movies ----- */
use movies;

/* зад 1.1: Напишете заявка, която извежда имената на актрисите, които са също и
продуценти с нетни активи над 10 милиона */

select NAME
from MOVIESTAR
where GENDER='f' AND name in (select NAME
				from MOVIEEXEC
				where NETWORTH>10000000);

/* зад 1.2: Напишете заявка, която извежда имената на тези актьори (мъже и жени),
които не са продуценти. */  

select NAME
from MOVIESTAR 
where not Exists (select MOVIEEXEC.NAME
					from MOVIEEXEC
					where MOVIESTAR.NAME=MOVIEEXEC.NAME);

/* зад 1.3: Напишете заявка, която извежда имената на всички филми с дължина,
по-голяма от дължината на филма ‘Star Wars’ */

select m1.TITLE
from MOVIE m1
where m1.LENGTH > (select LENGTH
						from MOVIE m2
						where m2.TITLE='Star wars');

/* зад 1.4: Напишете заявка, която извежда имената на продуцентите и имената
филмите за всички филми, които са продуцирани от продуценти с нетни
активи (networth) по-големи от тези на ‘Merv Griffin’ */

select MOVIE.TITLE,producers.NAME
from MOVIE,(select m2.NAME, m2.CERT#
				from MOVIEEXEC m1, MOVIEEXEC m2
				where m1.NAME='Merv Griffin' AND m2.NETWORTH>m1.NETWORTH) as producers
where movie.PRODUCERC# = producers.CERT#;

/* ----- PC ----- */
use pc;

/* зад 2.1: Напишете заявка, която извежда производителите на персонални
компютри с честота над 500. */

select maker
from product
where product.model in (select pc.model
						from pc
						where pc.speed>500);

/* зад 2.2: Напишете заявка, която извежда принтерите с най-висока цена. */

select code,model,price
from printer
where price >=ALL (select price
					from printer);

/* зад 2.3: Напишете заявка, която извежда лаптопите, чиято честота е по-ниска от
честотата на който и да е персонален компютър. */

select *
from laptop
where speed <All (select pc.speed
				  from pc);

/*  зад 2.4: Напишете заявка, която извежда модела на продукта (PC, лаптоп или
принтер) с най-висока цена. */

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

/* зад 2.5: Напишете заявка, която извежда производителя на цветния принтер с
най-ниска цена. */

select maker
from product
where product.model =( select printer.model
						from printer
						where price <= All (select p2.price
											from printer p2
											where p2.color='y') AND color='y'
					);

/* зад 2.6: Напишете заявка, която извежда производителите на тези персонални
компютри с най-малко RAM памет, които имат най-бързи процесори. */

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

/* зад 3.1: Напишете заявка, която извежда страните, чиито кораби са с най-голям
брой оръдия. */select DISTINCT COUNTRYfrom CLASSES where NUMGUNS >= ALL(select NUMGUNS						from CLASSES);				/* зад 3.2: Напишете заявка, която извежда класовете, за които поне един от
корабите е потънал в битка. */ 

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

/* зад 3.3: Напишете заявка, която извежда името и класа на корабите с 16 инчови
оръдия (bore). */

select NAME,CLASS
from ships 
where SHIPS.CLASS IN(select CLASS
						from CLASSES
						where bore=16);

/* зад 3.4: Напишете заявка, която извежда имената на битките, в които са
участвали кораби от клас ‘Kongo’. */

select BATTLE
from OUTCOMES
where SHIP IN (select NAME
				from SHIPS
				where CLASS='Kongo');

/* zad 3.5: Напишете заявка, която извежда класа и името на корабите, чиито брой
оръдия е по-голям или равен на този на корабите със същия калибър оръдия (bore). */

select DISTINCT ships.CLASS,ships.name
from ships JOIN CLASSES c1 on SHIPS.CLASS=c1.CLASS
where c1.NUMGUNS >= All (select NUMGUNS
						from CLASSES c2
						where c2.BORE = c1.BORE);