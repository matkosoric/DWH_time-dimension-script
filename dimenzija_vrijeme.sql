drop table if exists dimenzija_vrijeme;

CREATE TABLE dimenzija_vrijeme(
	id int,
    date_key date ,
	DAY_STRING CHAR(8) , 
	DAN_U_TJEDNU_NAZIV CHAR(44) , 
	DAN_U_TJEDNU_NAZIV_KRATKI CHAR(12) , 
	DAN_U_TJEDNU_NAZIV_BROJ tinyint,
    DAN_U_MJESECU tinyint,
	DAN_U_GODINI smallint,
    TJEDAN_U_GODINI_BROJ smallint,
    TJEDAN_I_GODINA CHAR(7),
    MJESEC_BROJ tinyint,
    MJESEC_GODINA_KRATKO_CRTA CHAR(17),
    MJESEC_U_DANIMA tinyint,
    MJESEC_ZADNJI_DAN_GODINE smallint,
	MJESEC_GODINA_KRATKO CHAR(17), 
	MJESEC_GODINA_DUGO CHAR(37), 
	MJESEC_KRATKO CHAR(12), 
	MJESEC_DUGO CHAR(32),
    KVARTAL tinyint,
    KVARTAL_TRAJANJE smallint,
    KVARTAL_ZADNJI_DAN smallint,
    GODINA smallint,
    GODINA_U_DANIMA smallint,
    GODINA_POLOVICA tinyint,
    GODINA_POLOVICA_NAZIV CHAR (7),
    GODINA_POLOVICA_TRAJANJE smallint,
    GODINA_POLOVICA_ZADNJI_DAN smallint,
		PRIMARY KEY (`date_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


SELECT * FROM dimenzija_vrijeme;

delimiter //

drop procedure if exists PopulateDateDimension//

CREATE PROCEDURE PopulateDateDimension(BeginDate DATETIME, EndDate DATETIME)
BEGIN

    DECLARE DateCounter DATETIME;
    DECLARE iterator INT DEFAULT 1;
    DECLARE DAN_U_TJEDNU_NAZIV CHAR(44);
    DECLARE DAN_U_TJEDNU_NAZIV_KRATKI CHAR(12); 
	DECLARE DAN_U_TJEDNU_NAZIV_BROJ tinyint;
    DECLARE DAN_U_MJESECU tinyint;
    DECLARE DAN_U_GODINI smallint;
    DECLARE TJEDAN_U_GODINI_BROJ tinyint;
    DECLARE TJEDAN_I_GODINA CHAR(7);
    DECLARE MJESEC_BROJ tinyint;
    DECLARE MJESEC_GODINA_KRATKO_CRTA CHAR(17);
    DECLARE MJESEC_U_DANIMA tinyint;
	DECLARE MJESEC_ZADNJI_DAN_GODINE smallint;
    DECLARE MJESEC_GODINA_KRATKO CHAR(17); 
	DECLARE MJESEC_GODINA_DUGO CHAR(37);
	DECLARE MJESEC_KRATKO CHAR(12);
	DECLARE MJESEC_DUGO CHAR(32);
	DECLARE KVARTAL tinyint;
    DECLARE KVARTAL_TRAJANJE smallint;
    DECLARE KVARTAL_ZADNJI_DAN smallint;
	DECLARE GODINA smallint;
    DECLARE GODINA_U_DANIMA smallint;
    DECLARE GODINA_POLOVICA tinyint;
    DECLARE GODINA_POLOVICA_NAZIV CHAR(7);
    DECLARE GODINA_POLOVICA_TRAJANJE smallint;
	DECLARE GODINA_POLOVICA_ZADNJI_DAN smallint;
 
    SET DateCounter = BeginDate;
   
    WHILE DateCounter <= EndDate DO
        
            SET DAN_U_TJEDNU_NAZIV_BROJ = DAYOFWEEK(DateCounter);
            
            IF DAN_U_TJEDNU_NAZIV_BROJ = 1 THEN SET DAN_U_TJEDNU_NAZIV_BROJ = 7; 		SET DAN_U_TJEDNU_NAZIV = 'Nedjelja';	SET DAN_U_TJEDNU_NAZIV_KRATKI = 'NED';
            ELSEIF DAN_U_TJEDNU_NAZIV_BROJ = 2 THEN SET DAN_U_TJEDNU_NAZIV_BROJ = 1;	SET DAN_U_TJEDNU_NAZIV = 'Ponedjeljak';	SET DAN_U_TJEDNU_NAZIV_KRATKI = 'PON';
            ELSEIF DAN_U_TJEDNU_NAZIV_BROJ = 3 THEN SET DAN_U_TJEDNU_NAZIV_BROJ = 2;	SET DAN_U_TJEDNU_NAZIV = 'Utorak';		SET DAN_U_TJEDNU_NAZIV_KRATKI = 'UTO';
            ELSEIF DAN_U_TJEDNU_NAZIV_BROJ = 4 THEN SET DAN_U_TJEDNU_NAZIV_BROJ = 3; 	SET DAN_U_TJEDNU_NAZIV = 'Srijeda';   	SET DAN_U_TJEDNU_NAZIV_KRATKI = 'SRI';
            ELSEIF DAN_U_TJEDNU_NAZIV_BROJ = 5 THEN SET DAN_U_TJEDNU_NAZIV_BROJ = 4;	SET DAN_U_TJEDNU_NAZIV = 'Četvrtak';	SET DAN_U_TJEDNU_NAZIV_KRATKI = 'ČET';
            ELSEIF DAN_U_TJEDNU_NAZIV_BROJ = 6 THEN SET DAN_U_TJEDNU_NAZIV_BROJ = 5;	SET DAN_U_TJEDNU_NAZIV = 'Petak';		SET DAN_U_TJEDNU_NAZIV_KRATKI = 'PET';
            ELSEIF DAN_U_TJEDNU_NAZIV_BROJ = 7 THEN SET DAN_U_TJEDNU_NAZIV_BROJ = 6;	SET DAN_U_TJEDNU_NAZIV = 'Subota';		SET DAN_U_TJEDNU_NAZIV_KRATKI = 'SUB';
            END IF;

			SET DAN_U_MJESECU = DAYOFMONTH(DateCounter);
			SET DAN_U_GODINI = DAYOFYEAR (DateCounter);
			SET TJEDAN_U_GODINI_BROJ = WEEK(DateCounter, 1);
            SET TJEDAN_I_GODINA = CONCAT (TJEDAN_U_GODINI_BROJ, '-', YEAR(DateCounter));
            
            SET MJESEC_BROJ = MONTH(DateCounter);
            IF MJESEC_BROJ = 1 THEN SET MJESEC_GODINA_KRATKO_CRTA = 'SIJ'; 			SET MJESEC_GODINA_KRATKO = 'Sij '; 		SET MJESEC_GODINA_DUGO = 'Siječanj ';	SET MJESEC_KRATKO = 'Sij';		SET MJESEC_DUGO = 'Siječanj';
            ELSEIF MJESEC_BROJ = 2 THEN SET MJESEC_GODINA_KRATKO_CRTA = 'VELJ'; 	SET MJESEC_GODINA_KRATKO = 'Velj '; 	SET MJESEC_GODINA_DUGO = 'Veljača ';	SET MJESEC_KRATKO = 'Velj';		SET MJESEC_DUGO = 'Veljača';
            ELSEIF MJESEC_BROJ = 3 THEN SET MJESEC_GODINA_KRATKO_CRTA = 'OŽU'; 		SET MJESEC_GODINA_KRATKO = 'Ožu '; 		SET MJESEC_GODINA_DUGO = 'Ožujak ';		SET MJESEC_KRATKO = 'Ožu';		SET MJESEC_DUGO = 'Ožujak';
            ELSEIF MJESEC_BROJ = 4 THEN SET MJESEC_GODINA_KRATKO_CRTA = 'TRA'; 		SET MJESEC_GODINA_KRATKO = 'Tra '; 		SET MJESEC_GODINA_DUGO = 'Travanj ';	SET MJESEC_KRATKO = 'Tra';		SET MJESEC_DUGO = 'Travanj';
            ELSEIF MJESEC_BROJ = 5 THEN SET MJESEC_GODINA_KRATKO_CRTA = 'SVI'; 		SET MJESEC_GODINA_KRATKO = 'Svi '; 		SET MJESEC_GODINA_DUGO = 'Svibanj ';	SET MJESEC_KRATKO = 'Svi';		SET MJESEC_DUGO = 'Svibanj';
            ELSEIF MJESEC_BROJ = 6 THEN SET MJESEC_GODINA_KRATKO_CRTA = 'LIP'; 		SET MJESEC_GODINA_KRATKO = 'Lip '; 		SET MJESEC_GODINA_DUGO = 'Lipanj ';		SET MJESEC_KRATKO = 'Lip';		SET MJESEC_DUGO = 'Lipanj';
            ELSEIF MJESEC_BROJ = 7 THEN SET MJESEC_GODINA_KRATKO_CRTA = 'SRP'; 		SET MJESEC_GODINA_KRATKO = 'Srp '; 		SET MJESEC_GODINA_DUGO = 'Srpanj ';		SET MJESEC_KRATKO = 'Srp';		SET MJESEC_DUGO = 'Srpanj';
            ELSEIF MJESEC_BROJ = 8 THEN SET MJESEC_GODINA_KRATKO_CRTA = 'KOL'; 		SET MJESEC_GODINA_KRATKO = 'Kol'; 		SET MJESEC_GODINA_DUGO = 'Kolovoz ';	SET MJESEC_KRATKO = 'Kol';		SET MJESEC_DUGO = 'Kolovoz';
            ELSEIF MJESEC_BROJ = 9 THEN SET MJESEC_GODINA_KRATKO_CRTA = 'RUJ'; 		SET MJESEC_GODINA_KRATKO = 'Ruj '; 		SET MJESEC_GODINA_DUGO = 'Rujan ';		SET MJESEC_KRATKO = 'Ruj';		SET MJESEC_DUGO = 'Rujan';
            ELSEIF MJESEC_BROJ = 10 THEN SET MJESEC_GODINA_KRATKO_CRTA = 'LIS'; 	SET MJESEC_GODINA_KRATKO = 'Lis '; 		SET MJESEC_GODINA_DUGO = 'Listopad ';	SET MJESEC_KRATKO = 'Lis';		SET MJESEC_DUGO = 'Listopad';
            ELSEIF MJESEC_BROJ = 11 THEN SET MJESEC_GODINA_KRATKO_CRTA = 'STU'; 	SET MJESEC_GODINA_KRATKO = 'Stu '; 		SET MJESEC_GODINA_DUGO = 'Studeni ';	SET MJESEC_KRATKO = 'Stu';		SET MJESEC_DUGO = 'Studeni';
            ELSEIF MJESEC_BROJ = 12 THEN SET MJESEC_GODINA_KRATKO_CRTA = 'PRO'; 	SET MJESEC_GODINA_KRATKO = 'Pro '; 		SET MJESEC_GODINA_DUGO = 'Prosinac ';	SET MJESEC_KRATKO = 'Pro';		SET MJESEC_DUGO = 'Prosinac';
			END IF;
            SET MJESEC_GODINA_KRATKO_CRTA = CONCAT (MJESEC_GODINA_KRATKO_CRTA, '-', YEAR(DateCounter));
            SET MJESEC_GODINA_KRATKO = CONCAT (MJESEC_GODINA_KRATKO,' ', YEAR(DateCounter));
            SET MJESEC_GODINA_DUGO = CONCAT (MJESEC_GODINA_DUGO, ' ', YEAR(DateCounter));
            
            SET MJESEC_U_DANIMA = DAY(LAST_DAY(DateCounter)) ;
			SET MJESEC_ZADNJI_DAN_GODINE = DAYOFYEAR (LAST_DAY(DateCounter));
            SET KVARTAL = quarter(DateCounter);
            SET KVARTAL_TRAJANJE = DAYOFYEAR(MAKEDATE(YEAR(DateCounter), 1) + INTERVAL QUARTER(DateCounter) QUARTER - INTERVAL 1 DAY) - DAYOFYEAR(MAKEDATE(YEAR(DateCounter), 1) + INTERVAL QUARTER(DateCounter) QUARTER - INTERVAL 1 Quarter) + 1;
            SET KVARTAL_ZADNJI_DAN = DAYOFYEAR(MAKEDATE(YEAR(DateCounter), 1) + INTERVAL QUARTER(DateCounter) QUARTER - INTERVAL 1 DAY);
            SET GODINA = YEAR(DateCounter);
            SET GODINA_U_DANIMA = DAYOFYEAR(LAST_DAY(MAKEDATE(YEAR(DateCounter), 365)));
            SET GODINA_POLOVICA = CEILING (quarter(DateCounter)/2) ;
            SET GODINA_POLOVICA_NAZIV = CONCAT('H', GODINA_POLOVICA, '-', GODINA);
            
            
            SET GODINA_POLOVICA_TRAJANJE = NULL;
            SET GODINA_POLOVICA_ZADNJI_DAN = NULL;
            #SET GODINA_POLOVICA_TRAJANJE = DAYOFYEAR(LAST_DAY(MAKEDATE(YEAR(DateCounter), INTERVAL 6 MONTH - INTERVAL 1 DAY))) -    DAYOFYEAR(MAKEDATE(YEAR(DateCounter), 1));   # POPRAVITI
			#SET GODINA_POLOVICA_ZADNJI_DAN = DAYOFYEAR(LAST_DAY(MAKEDATE(YEAR(DateCounter), INTERVAL 6 MONTH - INTERVAL 1 DAY)));

			SET iterator = iterator + 1 ;
			INSERT INTO dimenzija_vrijeme VALUES (
            		iterator,
                    DateCounter,
					CONCAT(CAST(YEAR(DateCounter) AS CHAR(4)),DATE_FORMAT(DateCounter,'%m'),DATE_FORMAT(DateCounter,'%d')),
                    DAN_U_TJEDNU_NAZIV,
                    DAN_U_TJEDNU_NAZIV_KRATKI,
                    DAN_U_TJEDNU_NAZIV_BROJ,
                    DAN_U_MJESECU,
                    DAN_U_GODINI,
                    TJEDAN_U_GODINI_BROJ,
                    TJEDAN_I_GODINA,
                    MJESEC_BROJ,
                    MJESEC_GODINA_KRATKO_CRTA,
					MJESEC_U_DANIMA,
                    MJESEC_ZADNJI_DAN_GODINE,
                    MJESEC_GODINA_KRATKO,
                    MJESEC_GODINA_DUGO,
                    MJESEC_KRATKO,
                    MJESEC_DUGO,
                    KVARTAL,
                    KVARTAL_TRAJANJE,
                    KVARTAL_ZADNJI_DAN,
					GODINA,
                    GODINA_U_DANIMA,
                    GODINA_POLOVICA,
                    GODINA_POLOVICA_NAZIV,
                    GODINA_POLOVICA_TRAJANJE,
                    GODINA_POLOVICA_ZADNJI_DAN
            );

            SET DateCounter = DATE_ADD(DateCounter, INTERVAL 1 DAY);
      END WHILE;
END//

CALL `world`.`PopulateDateDimension`(
			DATE_ADD(DATE_ADD(MAKEDATE(2000, 1), INTERVAL (1)-1 MONTH), INTERVAL (1)-1 DAY), 
            DATE_ADD(DATE_ADD(MAKEDATE(2001, 1), INTERVAL (3)-1 MONTH), INTERVAL (1)-1 DAY))//

SELECT * FROM dimenzija_vrijeme;
