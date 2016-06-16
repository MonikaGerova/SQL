/* ---- PC ---- */
use PC;

/* зад 1.1: Напишете заявка, която извежда средната честота на компютрите  */

select AVG (speed)
from PC

/* зад 1.2: Напишете заявка, която извежда средния размер на екраните на лаптопите за всеки производител  */

select product.maker , AVG(laptop.screen)
from product JOIN laptop ON product.model=laptop.model
GROUP BY product.maker

/* зад 1.3: Напишете заявка, която извежда средната честота на лаптопите с цена над 1000 */

select AVG(speed)
from laptop
where price>=1000;

/* зад 1.4: Напишете заявка, която извежда средната цена на компютрите произведени от производител ‘A’  */

select product.maker, AVG(price) as 'Average Price'
from product JOIN pc ON product.model=pc.model
where product.maker='A'
group by product.maker;


/* зад 1.5: Напишете заявка, която извежда средната цена на компютрите и лаптопите за производител ‘B’  */

select AVG(price)
from (
	(select maker,price,code
	from product JOIN laptop ON product.model=laptop.model) UNION
	(select maker,price,code
	from product JOIN pc ON product.model=pc.model) 
	) as products
where products.maker='B';

/* зад 1.6: Напишете заявка, която извежда средната цена на компютрите според различните им честоти  */

select speed,AVG(price) as 'Average Price'
from PC
GROUP BY speed;

/* зад 1.7: Напишете заявка, която извежда производителите, които са произвели поне по 3 различни модела компютъра */

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

 
/* зад 1.8:  Напишете заявка, която извежда производителите на компютрите с най-висока цена */

select product.maker, pc.price
from product JOIN pc ON product.model=pc.model
where pc.price = ( 
					select MAX(pc.price)
					from pc
				 );

/* зад 1.9: Напишете заявка, която извежда средната цена на компютрите за всяка честота по-голяма от 800 */
	
select speed,AVG(price)
from pc
where speed>=500
group by speed;

/* зад 1.10: Напишете заявка, която извежда средния размер на диска на тези компютри,
 произведени от производители, които произвеждат и принтери */

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


/* зад 1.11: Напишете заявка, която за всеки размер на лаптоп намира разликата в цената
 на най-скъпия и най-евтиния лаптоп със същия размер */

 select screen, (MAX(price)-Min(price) ) as 'MaxPrice - MinPrice', COUNT (*) as 'Broi laptopi s tozi razmer'
 from laptop
 group by screen;


/* ---- SHIPS ---- */
use ships;

/* зад 2.1:  Напишете заявка, която извежда броя на класовете кораби */

select COUNT(*) as 'Count of classes'
from CLASSES;

/* зад 2.2: Напишете заявка, която извежда средния брой на оръжия за всички кораби, пуснати на вода */

select AVG(CLASSES.NUMGUNS) as ' average NUMGUNS'
from SHIPS JOIN CLASSES ON SHIPS.CLASS=CLASSES.CLASS
where LAUNCHED is NOT NULL


/* зад 2.3:  Напишете заявка, която извежда за всеки клас първата и последната година,
 в която кораб от съответния клас е пуснат на вода */

select class, MIN(LAUNCHED) as 'First Launched ship', MAX(LAUNCHED) as 'Last launched ship'
from SHIPS
group by CLASS


/* зад 2.4: Напишете заявка, която извежда броя на корабите потънали в битка според класа */

select CLASS,COUNT(*) as 'sunk ships'
from SHIPS JOIN OUTCOMES ON SHIPS.NAME=OUTCOMES.SHIP
where OUTCOMES.RESULT='sunk'
group by SHIPS.CLASS

/* зад 2.5: Напишете заявка, която извежда броя на корабите потънали в битка според класа,
 за тези класове с повече от 4 пуснати на вода кораба  */


select  CLASS, count(RESULT) as 'SUNK SHIPS'
from OUTCOMES JOIN SHIPS ON OUTCOMES.SHIP=SHIPS.NAME
where OUTCOMES.RESULT='sunk' AND ships.CLASS IN (
												select CLASS
												from SHIPS
												group by CLASS
												having COUNT(SHIPS.LAUNCHED)>4
											)
group by CLASS

/* зад 2.6:  Напишете заявка, която извежда средното тегло на корабите, за всяка страна.  */


/* ---greshnoo zashtoto germaniq nqma korabi ---- */
select COUNTRY, AVG(DISPLACEMENT) as 'Average Displacement'
from CLASSES
group by COUNTRY

/* ---- vqrnoo --- */

select country,avg(displacement) as avg_displacement
from classes join ships on CLASSES.class=SHIPS.class
group by country;









