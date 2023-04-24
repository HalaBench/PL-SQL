CREATE TYPE biblio_type AS OBJECT(
    numbiblio CHAR(4),
    MEMBER procedure ajouterAdherent(nomAdh IN varchar, prenomAdh IN varchar, numAdh IN char),
    MEMBER procedure enleverAdherent(nomAdh IN varchar, prenomAdh IN varchar, numAdh IN char),
    MEMBER procedure ajouterDocument(numdocument IN CHAR,Titre IN VARCHAR)
    );
    /


CREATE TYPE doc_type AS OBJECT(
    numdoc CHAR(4),
    titre VARCHAR(20),
    refBiblio REF biblio_type
    ) NOT FINAL;
    /





CREATE TYPE Journal_type UNDER doc_type(
    numjour CHAR(4),
    dateParution date
    ) NOT FINAL;
    /




CREATE TYPE volume_type UNDER doc_type(
    numvol CHAR(4),
    auteur varchar(20)
    ) NOT FINAL;
    /



CREATE TYPE dic_type UNDER volume_type(
    numdic CHAR(4)
    ) NOT FINAL;
    /




CREATE TYPE BD_type UNDER volume_type(
    numbd CHAR(4),
    dessinateur VARCHAR(20)
    ) NOT FINAL;
    /


CREATE TYPE livre_type UNDER volume_type(
    numlivre CHAR(4),
    disponible CHAR(1),
    MEMBER FUNCTION empruntable(id_livre in char) RETURN char
    ) NOT FINAL;
    /



CREATE TYPE Adherent_type AS OBJECT(
    numAD CHAR(4),
    nom VARCHAR(20),
    prenom VARCHAR(20),
    warnings number,
    refBiblio REF biblio_type,
    MEMBER procedure emprunterLivre(id_livre IN Number,DateEmp IN date,DateRetour IN date),
    MEMBER procedure rendreLivre(id_livre IN Number,DateRetour IN date)
    );
    /



create type collLivre_type AS OBJECT(refLivre REF livre_type);
/


create type collLivre AS TABLE OF collLivre_type;
/


CREATE TYPE Emprunte_type AS OBJECT(
   numemp CHAR(4),
   DateEmpmprunt date,
   DateRetouretour date,
   refAD REF Adherent_type,
   livreEmprunter collLivre
	);
	/





CREATE TABLE bibliotheque OF biblio_type(CONSTRAINT pk_biblio PRIMARY KEY(numbiblio));


CREATE TABLE document OF doc_type(
    CONSTRAINT pk_doc PRIMARY KEY(numdoc),
    CONSTRAINT fk_refBiblio refBiblio REFERENCES bibliotheque);

CREATE TABLE Journal OF Journal_type(CONSTRAINT pk_jour PRIMARY KEY(numjour));


CREATE TABLE volume OF volume_type(CONSTRAINT pk_vol PRIMARY KEY(numvol));



CREATE TABLE dictionnaire OF dic_type(CONSTRAINT pk_dic PRIMARY KEY(numdic));



CREATE TABLE BD OF BD_type(CONSTRAINT pk_bd PRIMARY KEY(numbd));


CREATE TABLE livre OF livre_type(
    CONSTRAINT pk_livre PRIMARY KEY(numlivre),
    CHECK (disponible IN ('0','1'))
    );



CREATE TABLE Adherent OF Adherent_type(
    CONSTRAINT pk_ad PRIMARY KEY(numAD),
    CONSTRAINT fk_refbiblio refBiblio REFERENCES bibliotheque
    );

    ALTER TABLE Adherent MODIFY warnings DEFAULT 0;



create table Emprunte of Emprunte_type(
	constraint pk_empr PRIMARY KEY(numemp),
    constraint fk_refAD refAD REFERENCES Adherent)
    NESTED TABLE livreEmprunter STORE AS temporary;
    /
		
































insert into bibliotheque values('1111');
insert into bibliotheque values('2222');
insert into bibliotheque values('3333');



DECLARE
    refBIBLIO REF biblio_type;
 begin 
    select REF(i) into refBIBLIO
    FROM bibliotheque i
    WHERE numbiblio='1111';
 insert into document(NUMDOC, TITRE, REFBIBLIO) values('4563', 'firstdocument', refBIBLIO);
 end;
  /



DECLARE
    refBIBLIO REF biblio_type;
 begin 
    select REF(i) into refBIBLIO
    FROM bibliotheque i
    WHERE numbiblio='2222';
 insert into document(NUMDOC, TITRE, REFBIBLIO) values('4896', 'seconddocument', refBIBLIO);
 end;
  /



DECLARE
    refBIBLIO REF biblio_type;
 begin 
    select REF(i) into refBIBLIO
    FROM bibliotheque i
    WHERE numbiblio='3333';
 insert into document(NUMDOC, TITRE, REFBIBLIO) values('4756', 'thirddocument', refBIBLIO);
 end;
  /






DECLARE
 refBIBLIO REF biblio_type;
 
 begin
select REF(i) into refBIBLIO
 FROM bibliotheque i
 WHERE numbiblio='1111';
 insert into Journal( NUMDOC, TITRE,NUMJOUR, DATEPARUTION, REFBIBLIO ) values('2365','premierJour',10,'15-2-2022',refBIBLIO);
 end;
  /



DECLARE
 refBIBLIO REF Biblio_Type;
 
 begin
select REF(i) into refBIBLIO
 FROM bibliotheque i
 WHERE numbiblio='1111';
 insert into volume(numvol, auteur,NUMDOC, TITRE, REFBIBLIO) values(3985,'Vicro Hugo','4756','Les Miserables',refBIBLIO);
 end;
  /


DECLARE
 refBIBLIO REF Biblio_Type;
 
 begin
select REF(i) into refBIBLIO
 FROM bibliotheque i
 WHERE numbiblio='1111';
 insert into dictionnaire(numdic,numvol, auteur,NUMDOC, TITRE, REFBIBLIO) values('5648',3985,'Pierre Larousse','2365','Larousse',refBIBLIO);
 end;
  /



DECLARE
 refBIBLIO REF Biblio_Type;
 
 begin
select REF(i) into refBIBLIO
 FROM bibliotheque i
 WHERE numbiblio='1111';
 insert into bd( NUMBD,DESSINATEUR,numvol, auteur,NUMDOC, TITRE, REFBIBLIO) values('8975','someone',3985,'someonelse','4756','titrebd',refBIBLIO);
 end;
  /




DECLARE
 refBIBLIO REF biblio_type;
 
 begin
select REF(i) into refBIBLIO
 FROM bibliotheque i
 WHERE numbiblio='1111';
 insert into livre( numlivre,disponible,numvol, auteur,NUMDOC, TITRE, REFBIBLIO) values('9860','0','3985','first author','4756','first book',refBIBLIO);
 end;
  /


DECLARE
 refBIBLIO REF biblio_type;
 
 begin
select REF(i) into refBIBLIO
 FROM bibliotheque i
 WHERE numbiblio='1111';
 insert into livre( numlivre,disponible,numvol, auteur,NUMDOC, TITRE, REFBIBLIO) values('9861','0','3985','second author','4756','second book',refBIBLIO);
 end;
  /


DECLARE
 refBIBLIO REF biblio_type;
 
 begin
select REF(i) into refBIBLIO
 FROM bibliotheque i
 WHERE numbiblio='1111';
 insert into livre( numlivre,disponible,numvol, auteur,NUMDOC, TITRE, REFBIBLIO) values('9862','0','3985','third author','4756','third book',refBIBLIO);
 end;
  /



  DECLARE
 refBIBLIO REF biblio_type;
 
 begin
select REF(i) into refBIBLIO
 FROM bibliotheque i
 WHERE numbiblio='1111';
 insert into livre( numlivre,disponible,numvol, auteur,NUMDOC, TITRE, REFBIBLIO) values('9863','0','3985','third author','4756','third book',refBIBLIO);
 end;
  /




DECLARE
 refBIBLIO REF biblio_type;
 
 begin
select REF(i) into refBIBLIO
 FROM bibliotheque i
 WHERE numbiblio='1111';
 insert into Adherent(numAd,nom,prenom,REFBIBLIO) values('1234','Benchiheb','hala',refBIBLIO);
 end;
  /














create or replace type body biblio_type AS

MEMBER procedure ajouterAdherent(nomAdh IN varchar, prenomAdh IN varchar, numAdh IN CHAR)Is

        refBIBLIO REF biblio_type;
        v_co NUMBER;


begin
    select count(*) into v_co from Adherent where numAD=numAdh;
    select REF(j) into refBIBLIO
    FROM bibliotheque j
    WHERE numbiblio='1111';
    if v_co=0 then
        insert into Adherent(nom,prenom,numAD, refBIBLIO) values (nomAdh,prenomAdh,numAdh, refBIBLIO);
    else
        dbms_output.put_line('l adherent que vous essayer d ajouter existe deja. ');
    end if;
end;

MEMBER procedure enleverAdherent(nomAdh IN varchar, prenomAdh IN varchar, numAdh IN CHAR)Is


        v_co NUMBER;



begin
    select count(*) into v_co from Adherent where numAD=numAdh;
    if v_co=0 then
        dbms_output.put_line('l adherent n existe pas.');
    else
        delete from Adherent where numAD=numAdh ;
        dbms_output.put_line('l adherent a ete supprimer.');
    end if;
end;

MEMBER procedure ajouterDocument(numdocument IN CHAR,Titre IN VARCHAR)Is

        refBIBLIO REF biblio_type;
        v_co NUMBER;
begin

    select count(*) into v_co from document where NUMDOC=numdocument;
    select REF(j) into refBIBLIO
    FROM bibliotheque j
    WHERE numbiblio='1111';
    if v_co=0 then
        insert into document(NUMDOC, TITRE, REFBIBLIO) values(numdocument, Titre, refBIBLIO);
        dbms_output.put_line('document ajouter avec succes.');
    else
        dbms_output.put_line('le document que vous essayez d ajouter existe deja.');
    end if;

end;

end;
/





create or replace type body livre_type AS
MEMBER function empruntable(id_livre in char) return char IS
liv char;
begin
 select disponible into liv from livre where NUMLIVRE = id_livre;
 return liv;
end;
end;
/





 






create or replace type body adherent_type AS

    MEMBER procedure emprunterLivre(id_livre IN Number,DateEmp IN date,DateRetour IN date)Is

        var CHAR;
        co number;
        AD REF adherent_type;

    begin
        select REF(i) into AD FROM Adherent i WHERE numAD=self.numAD;
        select count(*) into co from emprunte where REFAD = AD;
        if co > 2 THEN  
            dbms_output.put_line('vous ne pouvez pas empruntez plus que 3 livres');
        else   
            if self.warnings > 2 THEN
                dbms_output.put_line('vous ne pouvez pas emprunter le livre vous avez 3 warnings');
            ELSE

                SELECT l.empruntable(id_livre) into var FROM livre l WHERE numlivre = id_livre;
                select REF(i) into AD FROM Adherent i WHERE numAD=self.numAD;
                if var = '0' then
                    UPDATE livre SET disponible = '1' WHERE numlivre = id_livre;
                    insert into emprunte(numemp,DateEmpmprunt,DateRetouretour,refAD) values (id_livre,DateEmp,DateRetour,AD);
                    dbms_output.put_line('livre emprunter avec succes ');
                else
                    dbms_output.put_line('ce livre n est pas disponible');
                end if;
            end if;
        end if;
    end emprunterLivre;
    MEMBER procedure rendreLivre(id_livre IN Number,DateRetour IN date)Is

        var Number;
        aver number;
        db date;
        df date;
        AD REF adherent_type;
    begin
        UPDATE livre SET disponible = '0' WHERE numlivre = id_livre;
    
        UPDATE emprunte SET DateRetouretour = DateRetour WHERE numemp = id_livre;
        select DateEmpmprunt into db from Emprunte where numemp = id_livre;
        select DateRetouretour into df from Emprunte where numemp = id_livre ;
        select (df-db ) into var from dual;
        if var > 15 then
            SELECT warnings into aver from Adherent where numAd = self.numAD;

            aver := aver + 1;


            UPDATE Adherent SET warnings = aver WHERE numad = self.numAD;

            dbms_output.put_line('warning: vous n avez pas rendu le livre a temps');
        end if;

        DELETE FROM emprunte where numemp = id_livre;
        dbms_output.put_line('livre rendu a la bibliotheque.');
        end rendreLivre;
        end;
        /

