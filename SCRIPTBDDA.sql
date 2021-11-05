-- Generated by Oracle SQL Developer Data Modeler 19.1.0.081.0911
--   at:        2021-11-04 12:39:11 EDT
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



DROP TABLE adresse CASCADE CONSTRAINTS;

DROP TABLE client CASCADE CONSTRAINTS;

DROP TABLE colis CASCADE CONSTRAINTS;

DROP TABLE contratrelai CASCADE CONSTRAINTS;

DROP TABLE contratsite CASCADE CONSTRAINTS;

DROP TABLE coordgps CASCADE CONSTRAINTS;

DROP TABLE couvrir CASCADE CONSTRAINTS;

DROP TABLE departement CASCADE CONSTRAINTS;

DROP TABLE "depend de" CASCADE CONSTRAINTS;

DROP TABLE facture CASCADE CONSTRAINTS;

DROP TABLE horaires CASCADE CONSTRAINTS;

DROP TABLE listeadressescolis CASCADE CONSTRAINTS;

DROP TABLE livreur CASCADE CONSTRAINTS;

DROP TABLE magasin CASCADE CONSTRAINTS;

DROP TABLE "S'occuper" CASCADE CONSTRAINTS;

DROP TABLE siteecommerce CASCADE CONSTRAINTS;

DROP TABLE tarif CASCADE CONSTRAINTS;

DROP TABLE transcolis CASCADE CONSTRAINTS;

DROP TABLE transite CASCADE CONSTRAINTS;

DROP TABLE typelivraison CASCADE CONSTRAINTS;

CREATE TABLE adresse (
    id                      INTEGER NOT NULL,
    nomrue                  CHAR(50),
    numrue                  INTEGER,
    ville                   CHAR(50),
    departement             INTEGER,
    client_id               INTEGER NOT NULL,
    listeadressescolis_id   INTEGER NOT NULL
);

drop sequence adr_seq;
create sequence adr_seq start with 1;

create or replace trigger adresse_bir
before insert on adresse 
for each row 

begin 
    select adr_seq.NEXTVAL
    into :new.id
    from dual;
end;
/


CREATE UNIQUE INDEX adresse__idx ON
    adresse (
        client_id
    ASC );

ALTER TABLE adresse ADD CONSTRAINT adresse_pk PRIMARY KEY ( id );

CREATE TABLE client (
    id    INTEGER NOT NULL,
    nom   CHAR(50)
);

ALTER TABLE client ADD CONSTRAINT client_pk PRIMARY KEY ( id );


drop sequence cli_seq;
create sequence cli_seq start with 1;

create or replace trigger client_bir
before insert on client 
for each row 

begin 
    select cli_seq.NEXTVAL
    into :new.id
    from dual;
end;
/

CREATE TABLE colis (
    id                      INTEGER NOT NULL,
    nom                     CHAR(50),
    taille                  FLOAT(01),
    poids                   FLOAT(01),
    tarif                   INTEGER,
    listeadressescolis_id   INTEGER NOT NULL,
    departementdest         INTEGER,
    destinationrelai        CHAR(1)
);

ALTER TABLE colis ADD CONSTRAINT colis_pk PRIMARY KEY ( id );

CREATE TABLE contratrelai (
    id                              INTEGER NOT NULL,
    date_debut                      DATE,
    date_fin                        DATE,
    tarif                           INTEGER,
    dateresiliation                 DATE,
    magasin_id                      INTEGER NOT NULL,
    encours                         CHAR(1),
    coefrelai                       FLOAT
);

ALTER TABLE contratrelai ADD CONSTRAINT contratrelai_pk PRIMARY KEY ( id );

drop sequence cont_seq;
create sequence cont_seq start with 1;

create or replace trigger contratrelai_bir
before insert on contratrelai 
for each row 

begin 
    select cont_seq.NEXTVAL
    into :new.id
    from dual;
end;
/

CREATE TABLE contratsite (
    id                 INTEGER NOT NULL,
    date_debut         DATE,
    date_fin           DATE,
    coeftaille         FLOAT,
    coefpoids          FLOAT,
    coefrelai          FLOAT,
    siteecommerce_id   INTEGER NOT NULL,
    encours            CHAR(1)
);

ALTER TABLE contratsite ADD CONSTRAINT contratsite_pk PRIMARY KEY ( id );

CREATE TABLE coordgps (
    id       INTEGER NOT NULL,
    coordx   NUMBER,
    coordy   NUMBER,
    coordz   NUMBER
);

ALTER TABLE coordgps ADD CONSTRAINT coordgps_pk PRIMARY KEY ( id );

CREATE TABLE couvrir (
    livreur_id       INTEGER NOT NULL,
    departement_id   INTEGER NOT NULL
);

ALTER TABLE couvrir ADD CONSTRAINT relation_24_pk PRIMARY KEY ( livreur_id,
                                                                departement_id );

CREATE TABLE departement (
    id       INTEGER NOT NULL,
    numero   INTEGER
);

ALTER TABLE departement ADD CONSTRAINT departement_pk PRIMARY KEY ( id );

CREATE TABLE "depend de" (
    typelivraison_id   INTEGER NOT NULL,
    facture_id         INTEGER NOT NULL
);

ALTER TABLE "depend de" ADD CONSTRAINT relation_28_pk_ PRIMARY KEY ( typelivraison_id,
                                                                    facture_id );

CREATE TABLE facture (
    id                 INTEGER NOT NULL,
    total              INTEGER,
    siteecommerce_id   INTEGER NOT NULL,
    estpayee           CHAR(1)
);

ALTER TABLE facture ADD CONSTRAINT facture_pk PRIMARY KEY ( id );

CREATE TABLE horaires (
    id                              INTEGER NOT NULL,
    heuredebut                      DATE,
    heurefin                        DATE,
    datedebut                       DATE,
    datefin                         DATE,
    magasin_id                      INTEGER NOT NULL,
    encours                         CHAR(1),
    
);

ALTER TABLE horaires ADD CONSTRAINT horaires_pk PRIMARY KEY ( id );

CREATE TABLE listeadressescolis (
    id           INTEGER NOT NULL,
    livreur_id   INTEGER NOT NULL,
    datejour     DATE
);

CREATE UNIQUE INDEX listeadressescolis__idx ON
    listeadressescolis (
        livreur_id
    ASC );

ALTER TABLE listeadressescolis ADD CONSTRAINT listeadressescolis_pk PRIMARY KEY ( id );

CREATE TABLE livreur (
    id INTEGER NOT NULL
);

ALTER TABLE livreur ADD CONSTRAINT livreur_pk PRIMARY KEY ( id );

drop sequence liv_seq;
create sequence liv_seq start with 1;

create or replace trigger livreue_bir
before insert on livreur 
for each row 

begin 
    select liv_seq.NEXTVAL
    into :new.id
    from dual;
end;
/

CREATE TABLE magasin (
    id                      INTEGER NOT NULL,
    numerorue               INTEGER,
    nomrue                  CHAR(150),
    ville                   CHAR(50),
    departement             INTEGER,
    raisonsociale           CHAR(50),
    numregistre             INTEGER,
    nomresponsable          CHAR(50),
    telephone               NUMBER,
    listeadressescolis_id   INTEGER NOT NULL
);

ALTER TABLE magasin ADD CONSTRAINT magasin_pk PRIMARY KEY ( id,
                                                            listeadressescolis_id );

CREATE TABLE "S'occuper" (
    livreur_id                               INTEGER NOT NULL,
    transcolis_id                            INTEGER NOT NULL,
    transcolis_colis_id                      INTEGER, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    transcolis_colis_listeadressescolis_id   INTEGER
);

ALTER TABLE "S'occuper"
    ADD CONSTRAINT relation_23_pk PRIMARY KEY ( livreur_id,
                                                transcolis_id,
                                                transcolis_colis_id,
                                                transcolis_colis_listeadressescolis_id );

CREATE TABLE siteecommerce (
    id               INTEGER NOT NULL,
    raison_sociale   CHAR 
--  WARNING: CHAR size not specified 
    ,
    numeroregistre   INTEGER,
    telephone        NUMBER,
    numrue           INTEGER,
    nomrue           CHAR(50),
    ville            CHAR(50),
    departement      INTEGER
);

ALTER TABLE siteecommerce ADD CONSTRAINT siteecommerce_pk PRIMARY KEY ( id );

CREATE TABLE tarif (
    id                              INTEGER NOT NULL,
    datedebut                       DATE,
    datefin                         DATE,
    prix                            FLOAT,
    magasin_id                      INTEGER NOT NULL,
    encours                         CHAR(1)
    
);

ALTER TABLE tarif ADD CONSTRAINT tarif_pk PRIMARY KEY ( id );

CREATE TABLE transcolis (
    id                            INTEGER NOT NULL,
    siteecommerce_id              INTEGER NOT NULL,
    client_id                     INTEGER NOT NULL,
    estlivre                      CHAR(1),
    "date"                        DATE,
    estrecupere                   CHAR(1),
    iscurrent                     CHAR(1),
    colis_id                      INTEGER NOT NULL,
    colis_listeadressescolis_id   INTEGER NOT NULL
);

ALTER TABLE transcolis
    ADD CONSTRAINT transcolis_pk PRIMARY KEY ( id,
                                               colis_id,
                                               colis_listeadressescolis_id );

CREATE TABLE transite (
    magasin_id                               INTEGER NOT NULL,
    transcolis_id                            INTEGER NOT NULL,
    magasin_id1                              INTEGER,
    magasin_listeadressescolis_id            INTEGER,
    magasin_listeadressescolis_id1           INTEGER,
    transcolis_colis_id                      INTEGER, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    transcolis_colis_listeadressescolis_id   INTEGER,
    magasin_listeadressescolis_id2           INTEGER
);

ALTER TABLE transite
    ADD CONSTRAINT relation_18_pk__ PRIMARY KEY ( magasin_id,
                                                transcolis_id,
                                                magasin_id1,
                                                magasin_listeadressescolis_id,
                                                magasin_listeadressescolis_id1,
                                                transcolis_colis_id,
                                                transcolis_colis_listeadressescolis_id,
                                                magasin_listeadressescolis_id2 );

CREATE TABLE typelivraison (
    id     INTEGER NOT NULL,
    type   CHAR(50)
);

ALTER TABLE typelivraison ADD CONSTRAINT typelivraison_pk PRIMARY KEY ( id );

ALTER TABLE adresse
    ADD CONSTRAINT adresse_client_fk FOREIGN KEY ( client_id )
        REFERENCES client ( id );

ALTER TABLE adresse
    ADD CONSTRAINT adresse_listeadressescolis_fk FOREIGN KEY ( listeadressescolis_id )
        REFERENCES listeadressescolis ( id );

ALTER TABLE colis
    ADD CONSTRAINT colis_listeadressescolis_fk FOREIGN KEY ( listeadressescolis_id )
        REFERENCES listeadressescolis ( id );

ALTER TABLE contratrelai
    ADD CONSTRAINT contratrelai_magasin_fk FOREIGN KEY ( magasin_id )
        REFERENCES magasin ( id );

ALTER TABLE contratsite
    ADD CONSTRAINT contratsite_siteecommerce_fk FOREIGN KEY ( siteecommerce_id )
        REFERENCES siteecommerce ( id );

-- Error - Foreign Key coordGps_TransColis_FK has no columns

ALTER TABLE facture
    ADD CONSTRAINT facture_siteecommerce_fk FOREIGN KEY ( siteecommerce_id )
        REFERENCES siteecommerce ( id );

ALTER TABLE horaires
    ADD CONSTRAINT horaires_magasin_fk FOREIGN KEY ( magasin_id )
        REFERENCES magasin ( id );

ALTER TABLE listeadressescolis
    ADD CONSTRAINT listeadressescolis_livreur_fk FOREIGN KEY ( livreur_id )
        REFERENCES livreur ( id );

ALTER TABLE magasin
    ADD CONSTRAINT magasin_listeadressescolis_fk FOREIGN KEY ( listeadressescolis_id )
        REFERENCES listeadressescolis ( id );

ALTER TABLE transite
    ADD CONSTRAINT relation_18_magasin_fk FOREIGN KEY ( magasin_id,
                                                        magasin_listeadressescolis_id2 )
        REFERENCES magasin ( id,
                             listeadressescolis_id );

ALTER TABLE transite
    ADD CONSTRAINT relation_18_transcolis_fk FOREIGN KEY ( transcolis_id,
                                                           transcolis_colis_id,
                                                           transcolis_colis_listeadressescolis_id )
        REFERENCES transcolis ( id,
                                colis_id,
                                colis_listeadressescolis_id );

ALTER TABLE "S'occuper"
    ADD CONSTRAINT relation_23_livreur_fk FOREIGN KEY ( livreur_id )
        REFERENCES livreur ( id );

ALTER TABLE "S'occuper"
    ADD CONSTRAINT relation_23_transcolis_fk FOREIGN KEY ( transcolis_id,
                                                           transcolis_colis_id,
                                                           transcolis_colis_listeadressescolis_id )
        REFERENCES transcolis ( id,
                                colis_id,
                                colis_listeadressescolis_id );

ALTER TABLE couvrir
    ADD CONSTRAINT relation_24_departement_fk FOREIGN KEY ( departement_id )
        REFERENCES departement ( id );

ALTER TABLE couvrir
    ADD CONSTRAINT relation_24_livreur_fk FOREIGN KEY ( livreur_id )
        REFERENCES livreur ( id );

ALTER TABLE "depend de"
    ADD CONSTRAINT relation_28_facture_fk FOREIGN KEY ( facture_id )
        REFERENCES facture ( id );

ALTER TABLE "depend de"
    ADD CONSTRAINT relation_28_typelivraison_fk FOREIGN KEY ( typelivraison_id )
        REFERENCES typelivraison ( id );

ALTER TABLE tarif
    ADD CONSTRAINT tarif_magasin_fk FOREIGN KEY ( magasin_id )
        REFERENCES magasin ( id );

ALTER TABLE transcolis
    ADD CONSTRAINT transcolis_client_fk FOREIGN KEY ( client_id )
        REFERENCES client ( id );

ALTER TABLE transcolis
    ADD CONSTRAINT transcolis_colis_fk FOREIGN KEY ( colis_id )
        REFERENCES colis ( id );

ALTER TABLE transcolis
    ADD CONSTRAINT transcolis_siteecommerce_fk FOREIGN KEY ( siteecommerce_id )
        REFERENCES siteecommerce ( id );

insert into client values(1,'Nicolas');
insert into client values(2,'Martin');
insert into client values(3,'Mael');
insert into client values(4,'Alex');
insert into client values(5,'Jean');
insert into client values(6,'Thibaud');
insert into client values(7,'Pierre');
insert into client values(8,'Emilien');
insert into client values(9,'Quentin');
insert into client values(10,'Paul');
insert into client values(0,'Georges'); --le trigger marche bien 

select * from client;

insert into livreur values(1);
insert into livreur values(2);
insert into livreur values(3);
insert into livreur values(4);
insert into livreur values(5);
insert into livreur values(6);
insert into livreur values(7);
insert into livreur values(8);
insert into livreur values(9);
insert into livreur values(10);

select * from livreur;

insert into listeadressescolis values(1,1,TO_DATE('19990218','YYYYMMDD'));
insert into listeadressescolis values(2,2,TO_DATE('19990218','YYYYMMDD'));
insert into listeadressescolis values(3,3,TO_DATE('19990218','YYYYMMDD'));
insert into listeadressescolis values(4,4,TO_DATE('19990218','YYYYMMDD'));
insert into listeadressescolis values(5,5,TO_DATE('19990218','YYYYMMDD'));
insert into listeadressescolis values(6,6,TO_DATE('19990218','YYYYMMDD'));
insert into listeadressescolis values(7,7,TO_DATE('19990218','YYYYMMDD'));
insert into listeadressescolis values(8,8,TO_DATE('19990218','YYYYMMDD'));
insert into listeadressescolis values(9,9,TO_DATE('19990218','YYYYMMDD'));
insert into listeadressescolis values(10,10,TO_DATE('19990218','YYYYMMDD'));



--select * from listeadressescolis;

insert into magasin values(1,1,'rue du tourment','Villejuif',94,'GTHIC',1111,'PERROT',613254789,1);
insert into magasin values(2,2,'rue du tournelsol','Villeverte',90,'STREETWEAR3',1112,'PARS',684421563,1);
insert into magasin values(3,2,'rue du paradis','Villenoire',99,'BOXING BEARS',1113,'BRIGITTE',623254895,1);
insert into magasin values(4,4,'rue du chatiment','Villemauve',46,'HADNMADE SHOES',1114,'SARDOU',635417875,2);
insert into magasin values(5,4,'rue du cercle','Villechretienne',60,'SOUTHERN CLOTHING',1115,'PERI',635986535,2);
insert into magasin values(6,19,'rue du grand jeu','Villeislamique',87,'GAMING GEARS',1116,'ZOLA',632659887,3);
insert into magasin values(7,17,'rue du grand jeu','Villeislamique',87,'COMPUTER BEASTS',1117,'MONTAIGNE',654218754,4);
insert into magasin values(8,15,'rue du phare','Villeperdue',74,'SOFT CANDIES',1118,'MONTEQUIEU',639429331,4);
insert into magasin values(9,18,'rue du tacos','Ville-sur-yvettes',30,'WE SELL DRUGS',1119,'BAUDELAIRE',0624863274,4);
insert into magasin values(10,1,'rue du kebab','Ville-coeur-brises',41,'TOYS AT HOME',1110,'VOLTAIRE',668426842,4);

select * from magasin;

insert into adresse values (1,'rue des alliés',1,'Pavois',74,1,1);
insert into adresse values (1,'rue des animaux',45,'Rocheville',41,2,1);
insert into adresse values (1,'rue des ferrys',78,'Marvois',36,3,1);
insert into adresse values (1,'rue des avions',42,'Pontax',57,4,1);
insert into adresse values (1,'rue des bateaux',96,'Ozoirax',63,5,2);
insert into adresse values (1,'rue des voitures',24,'Pariax',22,6,2);
insert into adresse values (1,'rue des cornes',100,'Orlyax',20,7,4);
insert into adresse values (1,'rue des jardins',33,'Vitryax',37,8,4);
insert into adresse values (1,'rue des malabars',78,'Antonax',64,9,3);
insert into adresse values (1,'rue des coquillages',79,'Fresnax',11,10,3);

select * from adresse;

insert into contratrelai values(1,TO_DATE('20050101','YYYYMMDD'),TO_DATE('20050501','YYYYMMDD'),20,null,1,0,0.25);
insert into contratrelai values(1,TO_DATE('20060101','YYYYMMDD'),TO_DATE('20060501','YYYYMMDD'),20,null,2,0,0.25);
insert into contratrelai values(1,TO_DATE('20070101','YYYYMMDD'),TO_DATE('20070501','YYYYMMDD'),20,null,3,0,0.25);
insert into contratrelai values(1,TO_DATE('20080101','YYYYMMDD'),TO_DATE('20080501','YYYYMMDD'),20,null,4,0,0.25);
insert into contratrelai values(1,TO_DATE('20090101','YYYYMMDD'),TO_DATE('20090501','YYYYMMDD'),20,null,5,0,0.25);
insert into contratrelai values(1,TO_DATE('20100101','YYYYMMDD'),TO_DATE('20100501','YYYYMMDD'),20,null,6,0,0.25);
insert into contratrelai values(1,TO_DATE('20200101','YYYYMMDD'),TO_DATE('20200501','YYYYMMDD'),20,null,7,0,0.25);
insert into contratrelai values(1,TO_DATE('20200101','YYYYMMDD'),TO_DATE('20020501','YYYYMMDD'),20,null,8,0,0.25);
insert into contratrelai values(1,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20210501','YYYYMMDD'),20,null,9,1,0.25);
insert into contratrelai values(1,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20210501','YYYYMMDD'),20,null,10,1,0.25);

select * from contratrelai;


-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            20
-- CREATE INDEX                             2
-- ALTER TABLE                             41
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0   
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   3
-- WARNINGS                                 1
