
/* ----- Movies ----- */
use movies;

/* зад 1: Напишете заявка, която извежда имената на актьорите мъже, участвали в
			‘Terms of Endearment’. */

select NAME
from MOVIESTAR join STARSIN on STARSIN.STARNAME = MOVIESTAR.NAME
where MOVIESTAR.GENDER='M' AND STARSIN.MOVIETITLE='Terms of Endearment';

/* зад 2: Напишете заявка, която извежда имената на актьорите, участвали във филми,
			продуцирани от студио ‘MGM’ през 1995 г. */

select STARNAME
from STARSIN,STUDIO
where MOVIEYEAR=1995 and STUDIO.NAME='MGM';

/* зад 3: Напишете заявка, която извежда имената на продуцентите, които са
			продуцирали филми на студио ‘MGM’ */

select DISTINCT name
from movie JOIN MOVIEEXEC on PRODUCERC#=CERT# 
where STUDIONAME='MGM';

/* зад 4: Напишете заявка, която извежда имената на всички филми с дължина, по-
			голяма от дължината на филма ‘Star Wars’ */

select m2.TITLE
from movie m1,movie m2
where m1.TITLE='Star wars' AND m1.LENGTH<m2.LENGTH;

/* зад 5: Напишете заявка, която извежда имената на продуцентите с нетни активи
			(networth) по-големи от тези на ‘Merv Griffin’. */

select m2.NAME
from MOVIEEXEC m1, MOVIEEXEC m2
where m1.NAME = 'Merv Griffin' and m1.NETWORTH<m2.NETWORTH;

/* зад 6: Напишете заявка, която извежда имената на всички филми, които са
			продуцирани от продуценти с нетни активи (networth) по-големи от тези на ‘Merv Griffin’. */

select TITLE
from MOVIE,MOVIEEXEC m1,MOVIEEXEC m2
where movie.PRODUCERC# = m2.CERT# AND m1.NAME = 'Merv Griffin' and m1.NETWORTH<m2.NETWORTH;


/* ----- PC ----- */
use pc;

/* зад 1: Напишете заявка, която извежда производителя и честотата (speed) на тези
			лаптопи с размер на диска поне 9 GB. */

select product.maker,laptop.speed
from laptop JOIN product on laptop.model = product.model
where hd>=9;

/* зад 2: Напишете заявка, която извежда номер на модел и цена на всички продукти,
			произведени от производител с име ‘B’. */

(Select product.model, pc.price
from product JOIN pc on product.model=pc.model
where maker='B') UNION
(Select product.model, laptop.price
from product JOIN laptop on product.model=laptop.model
where maker='B')UNION
(Select product.model, printer.price
from product JOIN printer on product.model=printer.model
where maker='B');

/* зад 3: Напишете заявка, която извежда размерите на тези дискове, които се предлагат
			в поне два различни компютъра (два компютъра с различен код). */

select DISTINCT p1.hd
from pc p1 JOIN pc p2 on p1.code!=p2.code
where p1.hd=p2.hd;
 
/* зад 4: Напишете заявка, която извежда всички двойки модели на компютри, които имат
			еднаква честота и памет. Двойките трябва да се показват само по веднъж,
			например само (i, j), но не и (j, i). */

select DISTINCT p1.model,p2.model
from pc p1 JOIN pc p2 on p1.model!=p2.model
where p1.speed=p2.speed AND p1.ram=p2.ram and p1.model<p2.model;


/* зад 5: Напишете заявка, която извежда производителите на поне два различни
			компютъра с честота поне 400. */

select DISTINCT p1.maker
from product p1 join pc pc1 on pc1.model=p1.model,product p2 join pc pc2 on pc2.model=p2.model
where pc1.code!=pc2.code AND pc1.speed>=400  AND p1.maker=p2.maker;


/* ----- SHIPS ----- */
use ships;

/* зад 1: Напишете заявка, която извежда името на корабите с водоизместимост над 50000. */

select SHIPS.NAME
from CLASSES JOIN SHIPS on SHIPS.CLASS=CLASSES.CLASS
where DISPLACEMENT>50000;

/* зад 2: Напишете заявка, която извежда имената, водоизместимостта и броя оръдия на
			всички кораби, участвали в битката при ‘Guadalcanal’. */

select SHIPS.NAME,DISPLACEMENT,NUMGUNS
from CLASSES JOIN SHIPS on SHIPS.CLASS = CLASSES.CLASS JOIN OUTCOMES on SHIPS.NAME=OUTCOMES.SHIP
where battle = 'Guadalcanal';

/* зад 3: Напишете заявка, която извежда имената на тези държави, които имат кораби
			от тип ‘bb’ и ‘bc’ едновременно. */

select DISTINCT c1.COUNTRY
from CLASSES c1, CLASSES c2 
where c1.TYPE !=c2.TYPE AND c1.COUNTRY=c2.COUNTRY;

/* зад 4: Напишете заявка, която извежда имената на тези кораби, които са били
			повредени в една битка, но по-късно са участвали в друга битка. */

select distinct o1.SHIP
from OUTCOMES o1 JOIN OUTCOMES o2 on o1.SHIP=o2.SHIP
where o1.RESULT!=o2.RESULT;










