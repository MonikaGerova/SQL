use movies;
/*
select ADDRESS
from STUDIO
where name='mgm';

/* ----------------- */

select BIRTHDATE
from MOVIESTAR
where name='sandra bullock';

/* ----------- */

select STARNAME
from STARSIN
where MOVIEYEAR=1980 AND MOVIETITLE like '%empire%';

/* --------------- */

select NAME
from MOVIEEXEC
where NETWORTH>10000000


Select NAME
from MOVIESTAR
where GENDER='M' OR ADDRESS= 'Prefect Rd';
*/

use pc;

/*
select model,speed as MHz,ram as GB
from pc
where price<1200

select distinct maker
from product
where type='laptop'

select model,ram,screen
from laptop
where price>1000

select *
from printer
where color='y' 

select model,speed,hd
from pc
where (cd= '12x' OR cd='16x') AND price<2000
*/

use ships;
/*
select CLASS,COUNTRY
from CLASSES
where NUMGUNS<10

select NAME
from SHIPS
where LAUNCHED<1918

select ship,BATTLE
from OUTCOMES
where RESULT = 'sunk'

select NAME
from SHIPS
where name=CLASS

select name 
from SHIPS
where name like 'R%'
*/
