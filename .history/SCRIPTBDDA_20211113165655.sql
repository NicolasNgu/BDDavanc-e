
------------------------------------
--DDL-------------------------------
------------------------------------


--CREATION DES TABLES DE LA BDD -----------------------------------------------------------------------------------------------------------------------------


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

ALTER TABLE client ADD CONSTRAINT client_pk PRIMARY KEY ( id );

CREATE TABLE colis (
    id                      INTEGER NOT NULL,
    nom                     CHAR(50),
    taille                  FLOAT(01),
    poids                   FLOAT(01),
    tarif                   INTEGER,
    listeadressescolis_id   INTEGER NOT NULL,
    departementdest         INTEGER,
    destinationrelai        CHAR(1),
    departrelai             CHAR(1)
);

drop sequence col_seq;
create sequence col_seq start with 1;

create or replace trigger colis_bir
before insert on colis
for each row

begin
    select col_seq.NEXTVAL
    into :new.id
    from dual;
end;
/

ALTER TABLE colis ADD CONSTRAINT colis_pk PRIMARY KEY ( id );

CREATE TABLE contratrelai (
    id                              INTEGER NOT NULL,
    date_debut                      DATE,
    date_fin                        DATE,
    dateresiliation                 DATE,
    magasin_id                      INTEGER NOT NULL,
    encours                         CHAR(1),
    coefrelai                       FLOAT
);

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

ALTER TABLE contratrelai ADD CONSTRAINT contratrelai_pk PRIMARY KEY ( id );

CREATE TABLE contratsite (
    id                 INTEGER NOT NULL,
    date_debut         DATE,
    date_fin           DATE,
    tarif              INTEGER,
    coeftaille         FLOAT,
    coefpoids          FLOAT,
    coefrelai          FLOAT,
    siteecommerce_id   INTEGER NOT NULL,
    encours            CHAR(1)
);



ALTER TABLE contratsite ADD CONSTRAINT contratsite_pk PRIMARY KEY ( id );

drop sequence csi_seq;
create sequence csi_seq start with 1;

create or replace trigger contratsite_bir
before insert on contratsite
for each row

begin
    select csi_seq.NEXTVAL
    into :new.id
    from dual;
end;
/

CREATE TABLE coordgps (
    id       INTEGER NOT NULL,
    coordx   NUMBER,
    coordy   NUMBER,
    transcolis_id integer not null
    
);

drop sequence coord_seq;
create sequence coord_seq start with 1;

create or replace trigger coordgps_bir
before insert on coordgps
for each row

begin
    select coord_seq.NEXTVAL
    into :new.id
    from dual;
end;
/

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

drop sequence dep_seq;
create sequence dep_seq start with 1;

create or replace trigger departement_bir
before insert on departement
for each row

begin
    select dep_seq.NEXTVAL
    into :new.id
    from dual;
end;
/

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
    totalR_R           INTEGER,
    totalR_A           INTEGER,
    totalA_R           INTEGER,
    totalA_A           INTEGER,
    siteecommerce_id   INTEGER NOT NULL,
    estpayee           CHAR(1)
);

drop sequence fac_seq;
create sequence fac_seq start with 1;

create or replace trigger facture_bir
before insert on facture
for each row

begin
    select fac_seq.NEXTVAL
    into :new.id
    from dual;
end;
/

ALTER TABLE facture ADD CONSTRAINT facture_pk PRIMARY KEY ( id );

CREATE TABLE horaires (
    id                              INTEGER NOT NULL,
    heuredebut                      INTEGER NOT NULL,
    heurefin                        INTEGER NOT NULL,
    datedebut                       DATE,
    datefin                         DATE,
    magasin_id                      INTEGER NOT NULL,
    encours                         CHAR(1)
   
);

drop sequence hor_seq;
create sequence hor_seq start with 1;

create or replace trigger horaires_bir
before insert on horaires
for each row

begin
    select hor_seq.NEXTVAL
    into :new.id
    from dual;
end;
/

ALTER TABLE horaires ADD CONSTRAINT horaires_pk PRIMARY KEY ( id );

CREATE TABLE listeadressescolis (
    id           INTEGER NOT NULL,
    livreur_id   INTEGER NOT NULL,
    datejour     DATE
);

drop sequence lac_seq;
create sequence lac_seq start with 1;

create or replace trigger listeadressescolis_bir
before insert on listeadressescolis
for each row

begin
    select lac_seq.NEXTVAL
    into :new.id
    from dual;
end;
/

CREATE UNIQUE INDEX listeadressescolis__idx ON  --index 
    listeadressescolis (
        livreur_id
    ASC );

ALTER TABLE listeadressescolis ADD CONSTRAINT listeadressescolis_pk PRIMARY KEY ( id );

CREATE TABLE livreur (
    id INTEGER NOT NULL
);

drop sequence liv_seq;
create sequence liv_seq start with 1;

create or replace trigger livreur_bir
before insert on livreur
for each row

begin
    select liv_seq.NEXTVAL
    into :new.id
    from dual;
end;
/

ALTER TABLE livreur ADD CONSTRAINT livreur_pk PRIMARY KEY ( id );

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

drop sequence mag_seq;
create sequence mag_seq start with 1;

create or replace trigger magasin_bir
before insert on magasin
for each row

begin
    select mag_seq.NEXTVAL
    into :new.id
    from dual;
end;
/

ALTER TABLE magasin ADD CONSTRAINT magasin_pk PRIMARY KEY ( id );

CREATE TABLE "S'occuper" (
    livreur_id                               INTEGER NOT NULL,
    transcolis_id                            INTEGER NOT NULL );


ALTER TABLE "S'occuper"
    ADD CONSTRAINT relation_23_pk PRIMARY KEY ( livreur_id,
                                                transcolis_id );

CREATE TABLE siteecommerce (
    id               INTEGER NOT NULL,
    raison_sociale   CHAR(50),   
    numeroregistre   INTEGER,
    telephone        NUMBER,
    numrue           INTEGER,
    nomrue           CHAR(50),
    ville            CHAR(50),
    departement      INTEGER
);

drop sequence sec_seq;
create sequence sec_seq start with 1;

create or replace trigger siteecommerce_bir
before insert on siteecommerce
for each row

begin
    select sec_seq.NEXTVAL
    into :new.id
    from dual;
end;
/

ALTER TABLE siteecommerce ADD CONSTRAINT siteecommerce_pk PRIMARY KEY ( id );

CREATE TABLE tarif (
    id                              INTEGER NOT NULL,
    datedebut                       DATE,
    datefin                         DATE,
    prix                            FLOAT,
    magasin_id                      INTEGER NOT NULL,
    encours                         CHAR(1)
   
);

drop sequence tar_seq;
create sequence tar_seq start with 1;

create or replace trigger tarif_bir
before insert on tarif
for each row

begin
    select tar_seq.NEXTVAL
    into :new.id
    from dual;
end;
/

ALTER TABLE tarif ADD CONSTRAINT tarif_pk PRIMARY KEY ( id );

CREATE TABLE transcolis (
    id                            INTEGER NOT NULL,
    siteecommerce_id              INTEGER NOT NULL,
    client_id                     INTEGER NOT NULL,
    estlivre                      CHAR(1),
    "date"                        DATE,
    estrecupere                   CHAR(1),
    iscurrent                     CHAR(1),
    colis_id                      INTEGER NOT NULL );

drop sequence tra_seq;
create sequence tra_seq start with 1;

create or replace trigger transcolis_bir
before insert on transcolis
for each row

begin
    select tra_seq.NEXTVAL
    into :new.id
    from dual;
end;
/

ALTER TABLE transcolis
    ADD CONSTRAINT transcolis_pk PRIMARY KEY ( id );

CREATE TABLE transite (
    magasin_id                               INTEGER NOT NULL,
    transcolis_id                            INTEGER NOT NULL);


ALTER TABLE transite
    ADD CONSTRAINT relation_18_pk__ PRIMARY KEY ( magasin_id );

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


ALTER TABLE coordgps
    ADD CONSTRAINT coordGps_TransColis_FK FOREIGN KEY ( transcolis_id )
        REFERENCES transcolis ( id );

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
    ADD CONSTRAINT relation_18_magasin_fk FOREIGN KEY ( magasin_id )
        REFERENCES magasin ( id );

ALTER TABLE transite
    ADD CONSTRAINT relation_18_transcolis_fk FOREIGN KEY ( transcolis_id )
        REFERENCES transcolis ( id );

ALTER TABLE "S'occuper"
    ADD CONSTRAINT relation_23_livreur_fk FOREIGN KEY ( livreur_id )
        REFERENCES livreur ( id );

ALTER TABLE "S'occuper"
    ADD CONSTRAINT relation_23_transcolis_fk FOREIGN KEY ( transcolis_id )
        REFERENCES transcolis ( id);

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
        

------------------------------------
--Les données-----------------------
------------------------------------

insert into client values(1,'Nicolas');
insert into client values(1,'Martin');
insert into client values(1,'Mael');
insert into client values(1,'Alex');
insert into client values(1,'Jean');
insert into client values(1,'Thibaud');
insert into client values(1,'Pierre');
insert into client values(1,'Emilien');
insert into client values(1,'Quentin');
insert into client values(1,'Paul');
insert into client values(1,'Georges'); --le trigger marche bien

select * from client;

insert into livreur values(1);
insert into livreur values(1);
insert into livreur values(1);
insert into livreur values(1);
insert into livreur values(1);
insert into livreur values(1);
insert into livreur values(1);
insert into livreur values(1);
insert into livreur values(1);
insert into livreur values(1);

select * from livreur;

insert into listeadressescolis values(1,1,TO_DATE('19990218','YYYYMMDD'));
insert into listeadressescolis values(1,2,TO_DATE('19990218','YYYYMMDD'));
insert into listeadressescolis values(1,3,TO_DATE('19990218','YYYYMMDD'));
insert into listeadressescolis values(1,4,TO_DATE('19990218','YYYYMMDD'));
insert into listeadressescolis values(1,5,TO_DATE('19990218','YYYYMMDD'));
insert into listeadressescolis values(1,6,TO_DATE('19990218','YYYYMMDD'));
insert into listeadressescolis values(1,7,TO_DATE('19990218','YYYYMMDD'));
insert into listeadressescolis values(1,8,TO_DATE('19990218','YYYYMMDD'));
insert into listeadressescolis values(1,9,TO_DATE('19990218','YYYYMMDD'));
insert into listeadressescolis values(1,10,TO_DATE('19990218','YYYYMMDD'));

select * from listeadressescolis;

insert into magasin values(1,1,'rue du tourment','Villejuif',90,'GTHIC',1111,'PERROT',613254789,1);
insert into magasin values(1,2,'rue du tournelsol','Villeverte',91,'STREETWEAR3',1112,'PARS',684421563,1);
insert into magasin values(1,2,'rue du paradis','Villenoire',92,'BOXING BEARS',1113,'BRIGITTE',623254895,1);
insert into magasin values(1,4,'rue du chatiment','Villemauve',93,'HADNMADE SHOES',1114,'SARDOU',635417875,2);
insert into magasin values(1,4,'rue du cercle','Villechretienne',94,'SOUTHERN CLOTHING',1115,'PERI',635986535,2);
insert into magasin values(1,19,'rue du grand jeu','Villeislamique',95,'GAMING GEARS',1116,'ZOLA',632659887,3);
insert into magasin values(1,17,'rue du grand jeu','Villeislamique',96,'COMPUTER BEASTS',1117,'MONTAIGNE',654218754,4);
insert into magasin values(1,15,'rue du phare','Villeperdue',97,'SOFT CANDIES',1118,'MONTEQUIEU',639429331,4);
insert into magasin values(1,18,'rue du tacos','Ville-sur-yvettes',98,'WE SELL DRUGS',1119,'BAUDELAIRE',0624863274,4);
insert into magasin values(1,1,'rue du kebab','Ville-coeur-brises',99,'TOYS AT HOME',1110,'VOLTAIRE',668426842,4);

select * from magasin;

insert into adresse values (1,'rue des alliés',4,'Pavois',90,1,1);
insert into adresse values (1,'rue des animaux',35,'Rocheville',91,2,1);
insert into adresse values (1,'rue des ferrys',47,'Marvois',92,3,1);
insert into adresse values (1,'rue des avions',74,'Pontax',93,4,1);
insert into adresse values (1,'rue des bateaux',36,'Ozoirax',94,5,2);
insert into adresse values (1,'rue des voitures',84,'Pariax',95,6,2);
insert into adresse values (1,'rue des cornes',22,'Orlyax',96,7,4);
insert into adresse values (1,'rue des jardins',33,'Vitryax',97,8,4);
insert into adresse values (1,'rue des malabars',77,'Antonax',98,9,3);
insert into adresse values (1,'rue des coquillages',79,'Fresnax',99,10,3);

select * from adresse;

insert into contratrelai values(1,TO_DATE('20050101','YYYYMMDD'),TO_DATE('20050501','YYYYMMDD'),null,1,0,0.25);
insert into contratrelai values(1,TO_DATE('20060101','YYYYMMDD'),TO_DATE('20060501','YYYYMMDD'),null,2,0,0.25);
insert into contratrelai values(1,TO_DATE('20070101','YYYYMMDD'),TO_DATE('20070501','YYYYMMDD'),null,3,0,0.25);
insert into contratrelai values(1,TO_DATE('20080101','YYYYMMDD'),TO_DATE('20080501','YYYYMMDD'),null,4,0,0.25);
insert into contratrelai values(1,TO_DATE('20090101','YYYYMMDD'),TO_DATE('20090501','YYYYMMDD'),null,5,0,0.25);
insert into contratrelai values(1,TO_DATE('20100101','YYYYMMDD'),TO_DATE('20100501','YYYYMMDD'),null,6,0,0.25);
insert into contratrelai values(1,TO_DATE('20200101','YYYYMMDD'),TO_DATE('20200501','YYYYMMDD'),null,7,0,0.25);
insert into contratrelai values(1,TO_DATE('20200101','YYYYMMDD'),TO_DATE('20020501','YYYYMMDD'),null,8,0,0.25);
insert into contratrelai values(1,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20210501','YYYYMMDD'),null,9,1,0.25);
insert into contratrelai values(1,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20210501','YYYYMMDD'),null,10,1,0.25);

select * from contratrelai;

insert into tarif values(1,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20210601','YYYYMMDD'),250,1,1);
insert into tarif values(1,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20210501','YYYYMMDD'),251,2,1);
insert into tarif values(1,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20210401','YYYYMMDD'),252,3,1);
insert into tarif values(1,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20210301','YYYYMMDD'),253,4,1);
insert into tarif values(1,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20210201','YYYYMMDD'),254,5,1);
insert into tarif values(1,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20210701','YYYYMMDD'),255,6,1);
insert into tarif values(1,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20210901','YYYYMMDD'),256,7,1);
insert into tarif values(1,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20211001','YYYYMMDD'),257,8,1);
insert into tarif values(1,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20211101','YYYYMMDD'),258,9,1);
insert into tarif values(1,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20211101','YYYYMMDD'),259,10,1);

select * from tarif;

insert into horaires values(1,9,21,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20210601','YYYYMMDD'),1,0);
insert into horaires values(1,8,22,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20210601','YYYYMMDD'),2,0);
insert into horaires values(1,9,22,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20210601','YYYYMMDD'),3,0);
insert into horaires values(1,10,20,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20210601','YYYYMMDD'),4,0);
insert into horaires values(1,9,19,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20220601','YYYYMMDD'),5,1);
insert into horaires values(1,8,18,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20220601','YYYYMMDD'),6,1);
insert into horaires values(1,7,18,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20220601','YYYYMMDD'),7,1);
insert into horaires values(1,9,19,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20220601','YYYYMMDD'),8,1);
insert into horaires values(1,10,20,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20220601','YYYYMMDD'),9,1);
insert into horaires values(1,10,20,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20220601','YYYYMMDD'),10,1);

select * from horaires;

insert into typelivraison values(1,'Relais-Relais');
insert into typelivraison values(2,'Relais-Adresse');
insert into typelivraison values(3,'Adresse-Relais');
insert into typelivraison values(4,'Adresse-Adresse');

select * from typelivraison;


insert into siteecommerce values(1,'Amazon',2220,0122334455,10,'Rue du Business','Parix',90);
insert into siteecommerce values(1,'LDLC',2221,0203040506,20,'Boulevard des Profits','Marseillix',91);
insert into siteecommerce values(1,'Darty',2222,0399887766,30,'Avenue des Euros','Lyonx',92);
insert into siteecommerce values(1,'Wish',2223,1111111111,40,'Place des Ventes','Nantix',93);
insert into siteecommerce values(1,'Boulanger',2224,0102030405,50,'Impasse de la Bourse','Strasbourix',94);
insert into siteecommerce values(1,'TopAchat',2225,0199887766,60,'Chemin du Benefice','Toulousix',95);
insert into siteecommerce values(1,'Leboncoin',2226,0000000000,70,'Rue de la rue','Montpelliex',96);
insert into siteecommerce values(1,'Ebay',2227,1112131415,80,'Allée des Banquiers','Rennix',97);
insert into siteecommerce values(1,'Alibaba',2228,0101010101,90,'Avenue de la Venue','Bordox',98);
insert into siteecommerce values(1,'Vinted',2229,0908070605,100,'Rue du Découvert','Nicix',99);

select * from siteecommerce;

insert into facture values(1,0,0,0,0,0,1,0);
insert into facture values(1,0,0,0,0,0,2,1);
insert into facture values(1,0,0,0,0,0,3,1);
insert into facture values(1,0,0,0,0,0,4,0);
insert into facture values(1,0,0,0,0,0,5,0);
insert into facture values(1,0,0,0,0,0,5,1);
insert into facture values(1,0,0,0,0,0,7,0);
insert into facture values(1,0,0,0,0,0,8,1);
insert into facture values(1,0,0,0,0,0,9,1);
insert into facture values(1,0,0,0,0,0,10,1);

select * from facture;


insert into colis values(1,'Ordinateur',60.0,2.0,1500,1,90,0,1);
insert into colis values(1,'Clavier',30.0,0.5,120,2,91,0,0);
insert into colis values(1,'Souris',10.0,0.1,30,2,92,0,1);
insert into colis values(1,'Enceinte',20.0,0.8,80,1,93,1,1);
insert into colis values(1,'Bureau',200.0,30.0,1000,1,94,1,0);
insert into colis values(1,'Lit',250.0,50.0,800,1,95,0,0);
insert into colis values(1,'CleUsb',50.0,10.0,1500,2,96,0,1);
insert into colis values(1,'Chaise',80.0,1.0,50,3,97,1,1);
insert into colis values(1,'Table',150.0,3.0,200,3,98,1,0);
insert into colis values(1,'Four',50.0,2.0,400,4,99,1,0);

select * from colis;

insert into contratsite values(1,TO_DATE('20210101','YYYYMMDD'),TO_DATE('20211201','YYYYMMDD'),0,2,2,0.5,1,1);
insert into contratsite values(1,TO_DATE('20210111','YYYYMMDD'),TO_DATE('20210202','YYYYMMDD'),0,1.5,2,0.5,2,0);
insert into contratsite values(1,TO_DATE('20210202','YYYYMMDD'),TO_DATE('20210606','YYYYMMDD'),0,2,1.5,0.5,3,0);
insert into contratsite values(1,TO_DATE('20210303','YYYYMMDD'),TO_DATE('2021125','YYYYMMDD'),0,1.2,1.2,0.5,4,1);
insert into contratsite values(1,TO_DATE('20210404','YYYYMMDD'),TO_DATE('20210505','YYYYMMDD'),0,3,1,0.5,5,0);
insert into contratsite values(1,TO_DATE('20201111','YYYYMMDD'),TO_DATE('20210101','YYYYMMDD'),0,1.8,1.8,0.5,6,0);
insert into contratsite values(1,TO_DATE('20200606','YYYYMMDD'),TO_DATE('20210707','YYYYMMDD'),0,2.5,2.5,0.5,7,0);
insert into contratsite values(1,TO_DATE('20211010','YYYYMMDD'),TO_DATE('20220101','YYYYMMDD'),0,1.3,1.7,0.5,8,1);
insert into contratsite values(1,TO_DATE('20210909','YYYYMMDD'),TO_DATE('20220202','YYYYMMDD'),0,1.7,1.3,0.5,9,1);
insert into contratsite values(1,TO_DATE('20210302','YYYYMMDD'),TO_DATE('20210403','YYYYMMDD'),0,3,3,0.5,10,0);

select * from contratsite;

insert into departement values(1,90);
insert into departement values(1,91);
insert into departement values(1,92);
insert into departement values(1,93);
insert into departement values(1,94);
insert into departement values(1,95);
insert into departement values(1,96);
insert into departement values(1,97);
insert into departement values(1,98);
insert into departement values(1,99);

select * from departement;

insert into couvrir values(1,1);
insert into couvrir values(2,2);
insert into couvrir values(3,3);
insert into couvrir values(4,4);
insert into couvrir values(5,5);
insert into couvrir values(6,6);
insert into couvrir values(7,7);
insert into couvrir values(8,8);
insert into couvrir values(9,9);
insert into couvrir values(10,10);

select * from couvrir;



insert into "depend de" values(1,1);
insert into "depend de" values(2,2);
insert into "depend de" values(3,3);
insert into "depend de" values(4,4);
insert into "depend de" values(1,5);
insert into "depend de" values(2,6);
insert into "depend de" values(3,7);
insert into "depend de" values(4,8);
insert into "depend de" values(1,9);
insert into "depend de" values(2,10);

select * from "depend de";

insert into transcolis values(1,1,1,1,TO_DATE('20210101','YYYYMMDD'),1,1,1);
insert into transcolis values(1,1,1,1,TO_DATE('20210201','YYYYMMDD'),1,1,1);
insert into transcolis values(1,2,2,0,TO_DATE('20210202','YYYYMMDD'),1,0,2);
insert into transcolis values(1,3,3,1,TO_DATE('20210303','YYYYMMDD'),1,0,3);
insert into transcolis values(1,4,4,0,TO_DATE('20210505','YYYYMMDD'),0,1,4);
insert into transcolis values(1,5,5,1,TO_DATE('20210505','YYYYMMDD'),1,1,5);
insert into transcolis values(1,6,6,0,TO_DATE('20210606','YYYYMMDD'),1,0,6);
insert into transcolis values(1,7,7,0,TO_DATE('20210707','YYYYMMDD'),0,1,7);
insert into transcolis values(1,8,8,0,TO_DATE('20210808','YYYYMMDD'),0,0,8);
insert into transcolis values(1,9,9,1,TO_DATE('20210909','YYYYMMDD'),1,0,9);
insert into transcolis values(1,10,10,0,TO_DATE('20211010','YYYYMMDD'),1,1,10);

select * from transcolis;

insert into "S'occuper" values(1,1);
insert into "S'occuper" values(1,2);
insert into "S'occuper" values(3,3);
insert into "S'occuper" values(4,4);
insert into "S'occuper" values(5,5);
insert into "S'occuper" values(6,6);
insert into "S'occuper" values(7,7);
insert into "S'occuper" values(8,8);
insert into "S'occuper" values(9,9);
insert into "S'occuper" values(10,10);

select * from "S'occuper";



insert into transite values(1,1);
insert into transite values(2,2);
insert into transite values(3,3);
insert into transite values(4,4);
insert into transite values(5,5);
insert into transite values(6,6);
insert into transite values(7,7);
insert into transite values(8,8);
insert into transite values(9,9);
insert into transite values(10,10);

select * from transite;

insert into coordgps values(1,30,30,1);
insert into coordgps values(1,40,40,2);
insert into coordgps values(1,50,50,3);
insert into coordgps values(1,60,60,4);
insert into coordgps values(1,70,70,5);
insert into coordgps values(1,80,80,6);
insert into coordgps values(1,90,90,7);
insert into coordgps values(1,95,95,8);
insert into coordgps values(1,100,100,9);
insert into coordgps values(1,120,120,10);

select * from coordgps;

------------------------------------
--Les Vues--------------------------
------------------------------------


--Question 1
CREATE or replace VIEW listClientActifs AS
SELECT distinct raison_sociale
FROM siteecommerce
JOIN contratsite ON siteecommerce.id = contratsite.siteecommerce_id
WHERE enCours = 1;

select * from listClientActifs;


--Question 2
CREATE or replace VIEW listRelaisActifs AS
SELECT distinct raisonSociale
FROM Magasin
JOIN ContratRelai ON Magasin.id = ContratRelai.Magasin_id
WHERE enCours = 1;

select * from listRelaisActifs;

--Question 3
CREATE or replace VIEW listeLivraisons AS
SELECT distinct T."date", C.nom, A.nomRue, A.numRue, A.ville, S.livreur_id
FROM transcolis T
JOIN colis C ON T.Colis_id = C.id
JOIN "S'occuper" S ON T.id = TransColis_id
JOIN client CL ON T.Client_id = CL.id
JOIN adresse A ON CL.id = A.Client_id
WHERE T."date" = TO_DATE('20210505','YYYYMMDD')
GROUP BY T."date", C.nom, A.nomrue, A.numRue, A.ville, S.livreur_id
ORDER BY S.livreur_id;

select * from listeLivraisons;


--Question 4
CREATE or replace VIEW nbrLivraisons AS
SELECT livreur_id, "date", COUNT (id) AS "nombreColis"
FROM transcolis
JOIN "S'occuper" ON transcolis.id = "S'occuper".transcolis_id
WHERE estLivre = 1
GROUP BY livreur_id, "date"
ORDER BY "date";

select * from nbrLivraisons;


--Question 5
CREATE or replace VIEW nbrColisRelais AS
SELECT COUNT (C.id) AS "nombreRelai", T."date", M.raisonSociale
FROM colis C
JOIN transcolis T ON C.id = T.colis_id
JOIN transite TR ON T.id = TR.TransColis_id
JOIN magasin M ON TR.Magasin_id = M.id
WHERE C.destinationRelai = 1 AND T."date" = TO_DATE('20210505','YYYYMMDD')
GROUP BY T."date", M.raisonSociale
ORDER BY T."date";

select * from nbrColisRelais;


--Question 6
CREATE or replace VIEW livraisonsEnCours AS
SELECT C.nom, S.livreur_id
FROM Colis C
JOIN TransColis T ON C.id = T.Colis_id
JOIN "S'occuper" S ON T.id = S.TransColis_id
WHERE T.isCurrent = 1
GROUP BY S.livreur_id, C.nom
ORDER BY S.livreur_id;

select * from livraisonsEnCours;


--Question 7
CREATE or replace VIEW attenteClient AS
SELECT COUNT(id) "nbrEnAttente"
FROM TransColis
WHERE estRecupere = 0;

select * FROM attenteClient;


--Question 8
/*CREATE VIEW avgColisTransit AS
SELECT CAST(AVG(CAST("date" AS INT)) AS DATE), nom
FROM transcolis
JOIN Client ON transcolis.Client_id = client.id
GROUP BY nom;*/


------------------------------------
--Contraintes d'intégrité-----------
------------------------------------


------------------------------------
--Procédures et fonctions-----------
------------------------------------

--Question 1
CREATE OR REPLACE PROCEDURE genFactureClient(id_site INTEGER) IS
totalRR integer := 0;
totalAR INTEGER := 0; 
totalRA INTEGER := 0; 
totalAA INTEGER := 0; 
destinationrelai integer := 0;
departrelai integer := 0;

BEGIN
for o in (select distinct colis.destinationrelai, colis.departrelai /*into destinationrelai, departrelai*/ from transcolis join colis on transcolis.colis_id = colis.id where transcolis.siteecommerce_id = id_site )
    loop 
        --dbms_output.put_line(o.destinationrelai);
       if (o.destinationrelai = 0 and o.departrelai = 0) then 
        totalAA := totalAA + 1;
       end if;
       if (o.destinationrelai = 1 and o.departrelai = 0) then 
        totalAR := totalAR + 1;
       end if;
       if (o.destinationrelai = 0 and o.departrelai = 1) then 
        totalRA := totalRA + 1;
       end if;
       if (o.destinationrelai = 1 and o.departrelai = 1) then 
        totalAA := totalRR + 1;
       end if;
    end loop;
    insert into facture values (1,totalAA + totalRA + totalAR + totalRR, totalRR, totalRA, totalAR, totalAA, id_site,0);
    
END;
/ 
--

EXEC genFactureClient(1);
select* from facture;



--Question 2
/*CREATE OR REPLACE PROCEDURE genPaiementRelais()
BEGIN
SELECT COUNT
*/

--Question 3
CREATE OR REPLACE FUNCTION calTarifColis(id_colis integer) return integer IS
est_recupere integer := null;
--is_current integer := null;
var_taille float := null;
var_poids float := null;
var_coefPoids float := null;
var_coefTaille float := null;
prix float := null;
var_coefRelai float := null;
var_idSite integer := null;


begin 

    select siteecommerce_id, estrecupere into var_idSite, est_recupere from transcolis where colis_id = id_colis and iscurrent = 1;
    select coeftaille, coefpoids, coefrelai into var_coefTaille, var_coefPoids, var_coefRelai from contratsite where siteecommerce_id = var_idSite and encours = 1;
    select taille, poids into var_taille, var_poids from colis where id = id_colis;
    prix := var_poids * var_coefPoids + var_taille * var_coefTaille;
    if(est_recupere = 1) then 
        prix := prix - var_coefRelai;
    end if;
    return prix;
    
end; 
/
--select siteecommerce_id, estrecupere from transcolis where colis_id = 1 and iscurrent = 1;

select calTarifColis(1) from dual;

--Question 5
CREATE OR REPLACE FUNCTION parcoursRelai(id_colis integer) return sys_refcursor is 
v_result SYS_REFCURSOR;
   BEGIN
      OPEN v_result FOR
         SELECT coordgps.coordx,
                coordgps.coordy
           FROM colis join transcolis on colis.id = transcolis.colis_id join coordgps on transcolis.id = coordgps.transcolis_id
          WHERE transcolis.colis_id = id_colis;
      RETURN v_result;
    END;
/

select parcoursRelai(1) from dual;

------------------------------------
--Les Triggers----------------------
------------------------------------
DROP TABLE alertLivreur CASCADE CONSTRAINTS;

CREATE TABLE alertLivreur (
    id_colis    INTEGER NOT NULL,
    nom_colis   CHAR(50),
    id_livreur  INTEGER NOT NULL
    );

DELIMITER !
CREATE OR REPLACE TRIGGER alertLivreurTrigger
AFTER UPDATE OF date ON TransColis
BEGIN
    SELECT T.estLivre, C.nom, C.id, S.livreur_id
    FROM TransColis T
    JOIN Colis C ON T.Colis = C.id
    JOIN "S'occuper" S ON T.id = S.TransColis_id;
IF T.estLivre = 0
THEN
    INSERT INTO alertLivreur
    VALUES (C.id, C.nom, S.livreur_id);
END IF;
END;
DELIMITER ;





