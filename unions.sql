
/* ---- Movies ----- */
use movies;

/* зад 1.1: Напишете заявка, която извежда името на продуцента и имената на
филмите, продуцирани от продуцента на ‘Star Wars’. */

select TITLE,NAME
from MOVIEEXEC JOIN MOVIE on PRODUCERC# = CERT#
where PRODUCERC# in ( select PRODUCERC#
						from MOVIE
						where title='Star Wars'
					);

/* зад 1.2: Напишете заявка, която извежда имената на продуцентите на филмите
на ‘Harrison Ford’. */

select NAME
from MOVIEEXEC 
where cert# in (select PRODUCERC#
				from MOVIE JOIN STARSIN on MOVIETITLE=TITLE
				where STARNAME='Harrison Ford'
				);

/* зад 1.3: Напишете заявка, която извежда името на студиото и имената на
актьорите, участвали във филми произведени от това студио, подредени
по име на студио. */

select DISTINCT STUDIONAME,STARNAME
from MOVIE JOIN STARSIN on TITLE=MOVIETITLE
order by STUDIONAME asc;


/* зад 1.4: Напишете заявка, която извежда имената на актьора (актьорите),
участвали във филми на най-голяма стойност (networth). */

select STARNAME,MOVIETITLE,NETWORTH
from  STARSIN JOIN Movie ON TITLE=MOVIETITLE JOIN MOVIEEXEC ON PRODUCERC# = CERT# 
where NETWORTH >= All (select NETWORTH
						from MOVIEEXEC);


/* зад 1.5: Напишете заявка, която извежда имената на актьорите, които не са
участвали в нито един филм. */

select NAME,MOVIETITLE
from MOVIESTAR LEFT JOIN STARSIN on NAME=STARNAME
where MOVIETITLE is NULL

/* ---- PC ---- */
use pc;
/* зад 2.1: Напишете заявка, която извежда производител, модел и тип на продукт
за тези производители, за които съответния продукт не се продава 
(няма го в таблиците PC, Laptop или Printer) */


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


/* зад 2.2: Намерете всички производители, които правят както лаптопи, така и
принтери. */
 
 select DISTINCT p1.maker
 from product p1 JOIN product p2 ON p1.maker=p2.maker  
 where p1.type='laptop' AND p2.type='printer';

 /* зад 2.3: Намерете размерите на тези твърди дискове, които се появяват в два
или повече модела лаптопи. */

select DISTINCT l1.hd
from laptop l1 JOIN laptop l2 ON l1.hd=l2.hd AND l1.code!=l2.code

/* зад 2.4: Намерете всички модели персонални компютри, които нямат регистриран
производител. */

select pc.model
from pc LEFT JOIN product ON pc.model = product.model
where product.maker is NULL

/* ---- SHIPS ---- */
use ships;

/* зад 3.1: Напишете заявка, която извежда цялата налична информация за всеки
кораб, включително и данните за неговия клас. В резултата не трябва да
се включват тези класове, които нямат кораби */

select *
from SHIPS LEFT JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS
where CLASSES.CLASS IS NOT NULL;


/* зад 3.2: Повторете горната заявка, като този път включите в резултата и
класовете, които нямат кораби, но съществуват кораби със същото име
като тяхното. */

select *
from SHIPS FULL JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS;

/* зад 3.3: За всяка страна изведете имената на корабите, които никога не са
участвали в битка. */

select CLASSES.COUNTRY,SHIPS.NAME
from CLASSES JOIN SHIPS ON SHIPS.CLASS=CLASSES.CLASS LEFT JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
where OUTCOMES.BATTLE is NULL;
					
/* зад 3.4: Намерете имената на всички кораби с поне 7 оръдия, пуснати на вода
през 1916, но наречете резултатната колона Ship Name. */

select SHIPS.NAME
from SHIPS JOIN CLASSES on SHIPS.CLASS = CLASSES.CLASS 
where SHIPS.LAUNCHED=1916 AND CLASSES.NUMGUNS>=7 

/* зад 3.5: Имената на всички потънали в битка кораби, името и дата на провеждане
на битките, в които те са  */

select OUTCOMES.SHIP,BATTLES.NAME, BATTLES.DATE
from OUTCOMES JOIN BATTLES ON BATTLES.NAME=OUTCOMES.BATTLE
where OUTCOMES.RESULT='sunk';

/* зад 3.6: Намерете теглото и годината на пускане на вода на всички кораби, които
имат същото име като техния клас. */


select SHIPS.NAME,CLASSES.DISPLACEMENT,SHIPS.LAUNCHED
from SHIPS JOIN CLASSES ON SHIPS.CLASS= CLASSES.CLASS AND SHIPS.NAME = CLASSES.CLASS;

/* зад 3.7: Намерете всички класове кораби, от които няма пуснат на вода нито един
кораб. */

select *
from CLASSES LEFT JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
where SHIPS.LAUNCHED is NULL;

/* ------------------------------------------------------------------------- */

select *
from CLASSES
where CLASSES.CLASS IN (select CLASSES.CLASS
						from CLASSES LEFT JOIN SHIPS ON CLASSES.CLASS = SHIPS.CLASS
						where SHIPS.LAUNCHED is NULL);



/* зад 3.8: Изведете имената, тежината и броя оръдия на корабите, участвали в
битката ‘North Atlantic’, а също и резултата от битката */


select SHIPS.NAME,CLASSES.DISPLACEMENT,CLASSES.NUMGUNS,OUTCOMES.RESULT
from SHIPS JOIN CLASSES ON SHIPS.CLASS = CLASSES.CLASS 
		JOIN OUTCOMES ON SHIPS.NAME = OUTCOMES.SHIP
where OUTCOMES.BATTLE='North Atlantic' 


