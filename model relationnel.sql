create table bibliotheque(id_biblio integer, 
                                           primary key(id_biblio));

create table adherent(id_adherent integer , 
                                      nom varchar(20) , 
                                      prenom varchar(20),
                                       date_naiss date, 
                                      id_biblio integer ,
                                      signale integer,
                                      primary key(id_adherent) , 
                                      foreign key(id_biblio) references bibliotheque(id_biblio));

create table document(id_docum integer,
                                        titre varchar(20),
                                        id_biblio integer,
                                         primary key(id_docum), 
                                         foreign key(id_biblio) references bibliotheque(id_biblio)); 

create table journal(id_journal integer,
                                      date_parution date ,
                                      id_docum integer ,
                                      primary key(id_journal) ,
                                      foreign key(id_docum) references document(id_docum));

create table volume(id_volume integer,
                                        auteur varchar(20),
                                        id_docum integer,
                                        primary key(id_volume),
                                        foreign key(id_docum) references document(id_docum));

create table dictionnaire(id_dict integer,
                                        id_volume integer,
                                        primary key(id_dict),
                                        foreign key(id_volume) references volume(id_volume));

create table bd(id_bd integer,
                                dessinateur varchar(20),
                                id_volume integer ,
                                primary key(id_bd),
                                foreign key(id_volume) references volume(id_volume));

create table livre(id_livre integer,
                                  id_volume integer ,
                                  disponible number(1),
                                  primary key(id_livre),
                                  foreign key(id_volume) references volume(id_volume),
                                 CONSTRAINT ck_livre_ischk CHECK (disponible IN (1,0)));

create table emprunte(code_emprunte integer,
                                           date_emprunt date,
                                           date_maxretour date,
                                           id_adherent integer,
                                           id_livre integer,
                                          primary key(code_emprunte),
                                         foreign key(id_adherent) references adherent(id_adherent),
                                         foreign key(id_livre) references livre(id_livre));
 
create table rendementlivre(code_rendement integer,
                                      date_emprunt date,
                                      date_rend date,
                                      id_adherent integer,
                                      id_livre integer,      
                                      primary key (code_rendement),
                                      foreign key(id_adherent) references adherent(id_adherent),
                                      foreign key(id_livre) references livre(id_livre));


create or replace procedure remplir_bibliotheque(id_biblio number) IS
BEGIN
insert into bibliotheque values(id_biblio);
END;
/
call remplir_bibliotheque(10);
desc bibliotheque;
select * from bibliotheque ;

create or replace procedure remplir_adherent(id_adherent number, 
                                                            nom varchar ,
                                                            prenom varchar,
                                                            date_naiss date,
                                                           id_biblio number,
                                                           signale number) IS
BEGIN 
insert into adherent values(id_adherent, nom , prenom , date_naiss , id_biblio, signale);
END;
/
call remplir_adherent(01, 'boucheriba', 'halima' , '21-07-1999' , 10, 0);
call remplir_adherent(02, 'hala', 'benchiheb' , '14-10-2000' , 10, 0);
call remplir_adherent(03, 'jerbouaa', 'sana' , '15-12-1988' , 10, 0);
call remplir_adherent(04, 'chikareli', 'sakina' , '13-08-1978' , 10, 0);
call remplir_adherent(05, 'turkie', 'nosaiba' , '01-10-1966' , 10, 0);
call remplir_adherent(06, 'telghemti', 'dounia' , '13-05-1990' , 10, 0);
call remplir_adherent(07, 'aziz', 'manal' , '18-03-1978' , 10, 0);
call remplir_adherent(08, 'lezreg', 'meriem' , '20-02-1998' , 10, 0);
call remplir_adherent(09, 'ayat', 'rayane' , '19-11-1970' , 10, 0);
call remplir_adherent(10, 'ayadi', 'abir' , '10-06-1972' , 10, 0);
desc adherent;
select * from adherent ;

create or replace procedure remplir_document(id_docum number ,  titre varchar , id_biblio number) IS
BEGIN
insert into document values(id_docum, titre , id_biblio);
END;
/
call remplir_document(01, 'marieb' , 10);
call remplir_document(02, 'scherwoud' , 10);
call remplir_document(03, 'atlas de poche' , 10);
call remplir_document(04, 'GPC', 10);
call remplir_document(05, 'anatomie' , 10);
call remplir_document(06, 'pratique galenique' , 10);
call remplir_document(07, 'oxford' , 10);
call remplir_document(08, 'les mesirable' , 10);
call remplir_document(09, 'lanniversaire' , 10);
call remplir_document(10, 'la batail dalger' , 10);
desc document;
select * from document ;

create or replace procedure remplir_journal(id_journal number, date_parution date ,  id_docum number) IS
BEGIN
insert into journal values(id_journal ,date_parution , id_docum);
END;
/
call remplir_journal(20, '12-02-2022' , 01);
call remplir_journal(21, '05-03-2021' , 02);
call remplir_journal(22, '30-06-2012' , 03);
call remplir_journal(23, '12-05-2019' , 04);
call remplir_journal(24, '21-11-2015' , 06);
call remplir_journal(25, '19-08-2014' , 09);
desc journal;
select * from journal ;

create or replace procedure remplir_volume(id_volume number, auteur varchar , id_docum number) IS
BEGIN
insert into volume values(id_volume,auteur , id_docum);
END;
/
call remplir_volume(30 , 'guillaume musso ' , 01);
call remplir_volume(31 , 'michel bussi' , 02);
call remplir_volume(32 , 'william shekspir' , 03);
call remplir_volume(33 , 'vector hugo' , 04);
call remplir_volume(34 , 'aurelie valognes' , 05);
call remplir_volume(35 , 'valerie perrin' , 06);
call remplir_volume(36 , 'olivier norek' , 04);
call remplir_volume(37 , 'albert camus' , 07);
call remplir_volume(38 , 'michael connelly' , 08);
call remplir_volume(39 , 'miguel ruiz' , 09);
call remplir_volume(40 , 'fiodor dostoievski' , 10);
desc volume;
select * from volume ;

create or replace procedure remplir_bd(id_bd number , dessinateur varchar , id_volume number) IS
BEGIN
insert into bd values(id_bd , dessinateur , id_volume);
END;
/
call remplir_bd(41 , 'alidor', 35);
call remplir_bd(42 , 'altan', 38);
call remplir_bd(43 , 'arno', 37);
call remplir_bd(44 , 'aurel', 30);
call remplir_bd(45 , 'babouse', 31);
desc bd;
select * from bd ;

create or replace procedure remplir_dictionnaire(id_dict number , id_volume number ) IS
BEGIN
insert into dictionnaire values(id_dict , id_volume);
END;
/
call remplir_dictionnaire(55,35);
call remplir_dictionnaire(51,37);
call remplir_dictionnaire(52,32);
call remplir_dictionnaire(53,30);
call remplir_dictionnaire(54,39);
desc dictionnaire;
select * from dictionnaire ;

create or replace procedure remplir_livre(id_livre number , id_volume number , disponible number) IS
BEGIN
insert into livre values(id_livre , id_volume , disponible);
END;
/
call remplir_livre(60,30,1);
call remplir_livre(61,31,1);
call remplir_livre(62,32,1);
call remplir_livre(63,33,1);
call remplir_livre(64,34,1);
call remplir_livre(65,35,1);
call remplir_livre(66,36,1);
call remplir_livre(67,37,1);
call remplir_livre(68,38,1);
call remplir_livre(69,39,1);
call remplir_livre(70,40,1);
desc livre;
select * from livre ;

create or replace procedure ajouter_adherent(id_adh NUMBER, nom varchar, prenom varchar, date_naiss date , id_biblio NUMBER, signale NUMBER) IS
v_count NUMBER;
BEGIN
SELECT COUNT(*) into v_count
from adherent WHERE id_adherent=id_adh ;
if v_count >= 1 then
DBMS_OUTPUT.PUT_LINE('cet adherent s exist deja');
else
remplir_adherent(id_adh, nom , prenom , date_naiss , id_biblio, signale);
DBMS_OUTPUT.PUT_LINE('Adherent ajouté avec succès');
end if ;
END;
/

create or replace Function verif_signal(id_adhr NUMBER) return NUMBER IS
sign NUMBER;
BEGIN
SELECT signale into sign from adherent where(id_adherent=id_adhr);
return sign;
end;
/

create or replace function code_emprunt(id_adh NUMBER) return NUMBER IS
compteur NUMBER;
BEGIN
SELECT COUNT(code_emprunte) into compteur from emprunte where id_adherent= id_adh;
return  compteur;
end;
/

create or replace procedure enlever_adherent(id_adh NUMBER) IS
adh_count NUMBER;
re_count NUMBER;
nbr NUMBER;
signal NUMBER;
BEGIN
nbr := code_emprunt(id_adh);
signal :=verif_signal(id_adh);
SELECT COUNT(*) into adh_count
from adherent WHERE id_adherent=id_adh;
SELECT COUNT(*) into re_count
from rendementlivre WHERE id_adherent=id_adh;
if adh_count > 0 then
  if nbr=0 AND signal = 0 then 
     if re_count >=1 then
       delete from rendementlivre
       where id_adherent = id_adh;
     end if;
     delete from  adherent
     where id_adherent=id_adh;
     DBMS_OUTPUT.PUT_LINE('cet adherent a ete carrement suprimee ');
  else
     DBMS_OUTPUT.PUT_LINE('ladherent soit il est signale soit il est emprunter des livres ');
  end if;
else 
   DBMS_OUTPUT.PUT_LINE('cet adherent n existe pas');
end if;
END;
/

create or replace procedure ajouter_document(id_doc number , titre varchar , id_biblio number) IS
doccount NUMBER;
BEGIN
SELECT COUNT(*) into doccount
from document WHERE id_docum=id_doc ;
if doccount >= 1 then
  DBMS_OUTPUT.PUT_LINE('cet document existe deja');
else
  remplir_document(id_doc , titre , id_biblio);
  DBMS_OUTPUT.PUT_LINE('document ajoute avec succes');
end if ;
END;
/

create or replace function empruntable(id_liv NUMBER) return NUMBER IS
emp_count NUMBER;
BEGIN
SELECT COUNT(*) INTO emp_count
from livre WHERE id_livre = id_liv AND disponible=1;
if emp_count = 0 then
  return 0;
else 
  return 1;
END IF;
END;
/

create or replace procedure emprunter_livre(code_empr NUMBER, id_adh NUMBER, id_livr NUMBER) IS
v_count NUMBER;
c_count NUMBER;
t_count NUMBER;
dispo NUMBER;
dat DATE;
datmax DATE;
sign NUMBER;
BEGIN
dispo:= empruntable(id_livr);
dat := CURRENT_DATE();
datmax:=CURRENT_DATE +15;
select  signale  into sign from adherent  WHERE  id_adherent =id_adh;
if sign =1 then 
  DBMS_OUTPUT.PUT_LINE('tu ne peux pas emprunter un livre car vous etes signle');
else
  SELECT COUNT(*) into c_count
  from adherent WHERE  id_adherent =id_adh;
  SELECT COUNT(*) into v_count
  from emprunte WHERE id_adherent = id_adh;
  if v_count<3  AND c_count >= 1 AND dispo = 1 THEN
    insert into emprunte values (code_empr, dat, datmax , id_adh, id_livr);
    DBMS_OUTPUT.PUT_LINE('adherent emprunte livre avec succes');
    UPDATE livre
    SET disponible = 0
    WHERE id_livre = id_livr;
  else
  DBMS_OUTPUT.PUT_LINE('vous ne pouvez pas emprunter ce livre');
  end if;
end if;
END;
/

create or replace procedure verification(code NUMBER,id_adh NUMBER) IS
day number;
dat_emp date;
date_rendement date;
t_count number;
BEGIN
SELECT COUNT(*) into t_count from rendementlivre
WHERE code_rendement = code;
if t_count >= 1 then
   select date_rend into date_rendement from rendementlivre where code_rendement = code;
   select date_emprunt into dat_emp  from  rendementlivre where code_rendement = code;
   select (date_rendement-dat_emp ) into day from dual;
   if day >15 then
      UPDATE adherent
      SET  signale = 1
      WHERE id_adherent= id_adh;
      DBMS_OUTPUT.PUT_LINE('cet adherent sera signale');
   else
      DBMS_OUTPUT.PUT_LINE('cet adherent ne sera  pas signale');
   end if;
else
   DBMS_OUTPUT.PUT_LINE('jamais emprunter ou jamais rendre un livre');
end if;
end;
/

create or replace procedure rendre_livre(code_rend NUMBER, id_livr NUMBER) IS
z_count number;
dat date;
datrend date;
id_adhr NUMBER;
adhr_count NUMBER;
id_adher NUMBER;
BEGIN
SELECT date_emprunt into dat from emprunte where code_emprunte = code_rend;
datrend:=CURRENT_DATE();
SELECT id_adherent into id_adhr from emprunte where code_emprunte = code_rend;
SELECT COUNT(*) into adhr_count from emprunte
WHERE code_emprunte = code_rend;
if adhr_count = 1 THEN
  insert into rendementlivre values (code_rend, dat, datrend , id_adhr, id_livr);
end if;
SELECT COUNT(*) into z_count from emprunte
WHERE code_emprunte = code_rend;
if z_count = 1 THEN
  DELETE from emprunte
  where id_livre = id_livr;
  DBMS_OUTPUT.PUT_LINE('le livre est rendu ');
  UPDATE livre
  SET disponible =1
  WHERE id_livre = id_livr;
end if;
verification(code_rend,id_adhr);
end;
/



