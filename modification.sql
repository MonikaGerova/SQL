use movies;

/* Да се добави информация за актрисата Nicole Kidman. За нея знаем само, че е родена на
20.06.1967. */

/* select * from MOVIESTAR */

INSERT INTO MOVIESTAR(name,gender,BIRTHDATE)
VALUES('Nicole Kidman','f','1967-06-20');

/*select * from MOVIESTAR; */


/* Да се изтрият всички продуценти с нетни активи (networth) под 30 милиона. */

/* select * from MOVIEEXEC */

Delete from MOVIEEXEC
where NETWORTH<30000000

/* select * from MOVIEEXEC */

/* . Да се изтрие информацията за всички филмови звезди, за които не се знае адреса. */

/* select * from MOVIESTAR */

delete from MOVIESTAR 
where ADDRESS is null

/* select * from MOVIESTAR */

use pc;

/* Използвайте две INSERT заявки. Съхранете в базата данни факта, че персонален компютър
модел 1100 е направен от производителя C, има процесор 2400 MHz, RAM 2048 MB, твърд диск
500 GB, 52x оптично дисково устройство и струва $299. Нека новият компютър има код 12.
Забележка: модел и CD са от тип низ */


 INSERT INTO product(maker,model,type)
values('C','1100','pc');

Insert INTO PC(code,MODEL,speed,ram,hd,cd,PRICE) 
values(12,'1100',2400,2048,500,'52x',299)

/* select * from product 
select * from pc */

/* Да се изтрие наличната информация за компютри модел 1100. */

delete from product 
where model='1100'

delete from pc
where model='1100'


/* Да се изтрият всички лаптопи, направени от производител, който не произвежда принтери */


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


/* Производител А купува производител B. На всички продукти на В променете производителя да бъде А. */

/*select * from product; */

/*UPDATE product
set maker='A'
where maker='B' */

/*select * from product;*/
 

 /* Да се намали два пъти цената на всеки компютър и да се добавят по 20 GB към всеки твърд диск. */

 /*select * from pc */

 UPDATE pc
 set price=price/2 , hd=hd+20;

 /*select * from pc; */ 

 /* За всеки лаптоп от производител B добавете по един инч към диагонала на екрана. */

 UPDATE laptop
 set screen=screen+1
 where model in ( select model from product where maker='B' and type='laptop') 


/* select * from laptop */


use ships;

/* 0. Два британски бойни кораба от класа Nelson - Nelson и Rodney - са били пуснати на вода
едновременно през 1927 г. Имали са девет 16-инчови оръдия (bore) и водоизместимост от 34000
тона (displacement). Добавете тези факти към базата от данни. */

insert into CLASSES(CLASS,bore,DISPLACEMENT,COUNTRY,NUMGUNS,TYPE)
values('Nelson',16,34000,'Britain',9,'bb')

insert into CLASSES(CLASS,bore,DISPLACEMENT,COUNTRY,NUMGUNS,TYPE)
values('Rodney',16,34000,'Britain',9,'bb')


INSERT INTO SHIPS(CLASS,NAME,LAUNCHED)
values('Nelson','Nelson',1927)

INSERT INTO SHIPS(CLASS,NAME,LAUNCHED)
values('Rodney','Rodney',1927)

/* Изтрийте от Ships всички кораби, които са потънали в битка */

delete from SHIPS
where NAME in ( select SHIP from OUTCOMES where result='sunk')

/* Променете данните в релацията Classes така, че калибърът (bore) да се измерва в сантиметри (в
момента е в инчове, 1 инч ~ 2.5 см) и водоизместимостта да се измерва в метрични тонове (1 м.т.
= 1.1 т.) */

update CLASSES
set bore=bore*2.5, DISPLACEMENT=DISPLACEMENT/1.1


















