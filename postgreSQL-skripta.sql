# postgreSQL skripta za generiranje vremenske dimenzije
# postgreSQL script for generating time dimension
# week calculation is different from mysql and mariadb script
# @ matko soric

DROP TABLE IF EXISTS dimenzija_vrijeme;

CREATE TABLE dimenzija_vrijeme(
	id int,
	DATUM_KEY date ,
	DAN_STRING CHAR(8), 
	DAN_U_TJEDNU_NAZIV CHAR(44) , 
	DAN_U_TJEDNU_NAZIV_KRATKI CHAR(12) , 
	DAN_U_TJEDNU_NAZIV_BROJ smallint,
	DAN_U_MJESECU smallint,
	DAN_U_GODINI smallint,
	TJEDAN_U_GODINI_BROJ smallint,
	TJEDAN_I_GODINA CHAR(7),
	MJESEC_BROJ smallint,
	MJESEC_GODINA_KRATKO_CRTA CHAR(17),
	MJESEC_U_DANIMA smallint,
	MJESEC_ZADNJI_DAN_GODINE smallint,
	MJESEC_GODINA_KRATKO CHAR(17), 
	MJESEC_GODINA_DUGO CHAR(37), 
	MJESEC_KRATKO CHAR(12), 
	MJESEC_DUGO CHAR(32),
	KVARTAL smallint,
	KVARTAL_TRAJANJE smallint,
	KVARTAL_ZADNJI_DAN smallint,
	GODINA smallint,
	GODINA_U_DANIMA smallint,
	GODINA_POLOVICA smallint,
	GODINA_POLOVICA_NAZIV CHAR (7),
	GODINA_POLOVICA_TRAJANJE smallint,
	GODINA_POLOVICA_ZADNJI_DAN int,
	PRIMARY KEY (DATUM_KEY)
);


DROP FUNCTION IF EXISTS GenerirajPodatke;


CREATE OR REPLACE FUNCTION GenerirajPodatke(DATE, DATE) RETURNS integer AS $$
DECLARE
	datum_pocetni ALIAS for $1;
	datum_krajnji ALIAS for $2;

    datum_trenutni DATE;
    iterator INT DEFAULT 0;
	DAN_STRING CHAR(8);
    DAN_U_TJEDNU_NAZIV CHAR(44);
    DAN_U_TJEDNU_NAZIV_KRATKI CHAR(12); 
	DAN_U_TJEDNU_NAZIV_BROJ smallint;
    DAN_U_MJESECU smallint;
    DAN_U_GODINI smallint;
    TJEDAN_U_GODINI_BROJ smallint;
    TJEDAN_I_GODINA CHAR(7);
    MJESEC_BROJ smallint;
    MJESEC_GODINA_KRATKO_CRTA CHAR(17);
    MJESEC_U_DANIMA smallint;
	MJESEC_ZADNJI_DAN_GODINE smallint;
    MJESEC_GODINA_KRATKO CHAR(17); 
	MJESEC_GODINA_DUGO CHAR(37);
	MJESEC_KRATKO CHAR(12);
	MJESEC_DUGO CHAR(32);
	KVARTAL smallint;
    KVARTAL_TRAJANJE smallint;
    KVARTAL_ZADNJI_DAN smallint;
	GODINA smallint;
    GODINA_U_DANIMA smallint;
    GODINA_POLOVICA smallint;
    GODINA_POLOVICA_NAZIV CHAR(7);
    GODINA_POLOVICA_TRAJANJE smallint;
	GODINA_POLOVICA_ZADNJI_DAN int;
	GODINA_POLOVICA_PRVI_DAN int;

 begin
	
    datum_trenutni := datum_pocetni;
   
    WHILE datum_trenutni <= datum_krajnji LOOP
        
    		GODINA := extract (year FROM datum_trenutni);
			
            DAN_U_TJEDNU_NAZIV_BROJ := date_part('dow', datum_trenutni);
           
            IF DAN_U_TJEDNU_NAZIV_BROJ = 1 THEN  DAN_U_TJEDNU_NAZIV_BROJ := 1; 		 DAN_U_TJEDNU_NAZIV := 'Ponedjeljak';		DAN_U_TJEDNU_NAZIV_KRATKI := 'PON';
            ELSIF DAN_U_TJEDNU_NAZIV_BROJ = 2 THEN  DAN_U_TJEDNU_NAZIV_BROJ := 2;	 DAN_U_TJEDNU_NAZIV := 'Utorak';	 		DAN_U_TJEDNU_NAZIV_KRATKI := 'UTO';
            ELSIF DAN_U_TJEDNU_NAZIV_BROJ = 3 THEN  DAN_U_TJEDNU_NAZIV_BROJ := 3;	 DAN_U_TJEDNU_NAZIV := 'Srijeda';			DAN_U_TJEDNU_NAZIV_KRATKI := 'SRI';
            ELSIF DAN_U_TJEDNU_NAZIV_BROJ = 4 THEN  DAN_U_TJEDNU_NAZIV_BROJ := 4; 	 DAN_U_TJEDNU_NAZIV := 'Četvrtak';   	 	DAN_U_TJEDNU_NAZIV_KRATKI := 'ČET';
            ELSIF DAN_U_TJEDNU_NAZIV_BROJ = 5 THEN  DAN_U_TJEDNU_NAZIV_BROJ := 5;	 DAN_U_TJEDNU_NAZIV := 'Petak';		 		DAN_U_TJEDNU_NAZIV_KRATKI := 'PET';
            ELSIF DAN_U_TJEDNU_NAZIV_BROJ = 6 THEN  DAN_U_TJEDNU_NAZIV_BROJ := 6;	 DAN_U_TJEDNU_NAZIV := 'Subota';		 	DAN_U_TJEDNU_NAZIV_KRATKI := 'SUB';
            ELSIF DAN_U_TJEDNU_NAZIV_BROJ = 0 THEN  DAN_U_TJEDNU_NAZIV_BROJ := 7;	 DAN_U_TJEDNU_NAZIV := 'Nedjelja';		 	DAN_U_TJEDNU_NAZIV_KRATKI := 'NED';
            END IF;

			DAN_U_MJESECU := date_part('day', datum_trenutni);
			DAN_U_GODINI := date_part('doy', datum_trenutni);
			TJEDAN_U_GODINI_BROJ := date_part('week', datum_trenutni);
            TJEDAN_I_GODINA := TJEDAN_U_GODINI_BROJ || '-' || date_part('year', datum_trenutni);
            
            MJESEC_BROJ := extract (month from datum_trenutni::date);
            IF MJESEC_BROJ = 1 THEN  MJESEC_GODINA_KRATKO_CRTA := 'SIJ'; 			MJESEC_GODINA_KRATKO := 'Sij '; 		MJESEC_GODINA_DUGO := 'Siječanj ';	MJESEC_KRATKO := 'Sij';		 MJESEC_DUGO := 'Siječanj';
            ELSIF MJESEC_BROJ = 2 THEN  MJESEC_GODINA_KRATKO_CRTA := 'VELJ'; 	 	MJESEC_GODINA_KRATKO := 'Velj '; 	 	MJESEC_GODINA_DUGO := 'Veljača ';	MJESEC_KRATKO := 'Velj';		 MJESEC_DUGO := 'Veljača';
            ELSIF MJESEC_BROJ = 3 THEN  MJESEC_GODINA_KRATKO_CRTA := 'OŽU'; 		MJESEC_GODINA_KRATKO := 'Ožu '; 		MJESEC_GODINA_DUGO := 'Ožujak ';	MJESEC_KRATKO := 'Ožu';		 MJESEC_DUGO := 'Ožujak';
            ELSIF MJESEC_BROJ = 4 THEN  MJESEC_GODINA_KRATKO_CRTA := 'TRA'; 		MJESEC_GODINA_KRATKO := 'Tra '; 		MJESEC_GODINA_DUGO := 'Travanj ';	MJESEC_KRATKO := 'Tra';		 MJESEC_DUGO := 'Travanj';
            ELSIF MJESEC_BROJ = 5 THEN  MJESEC_GODINA_KRATKO_CRTA := 'SVI'; 		MJESEC_GODINA_KRATKO := 'Svi '; 		MJESEC_GODINA_DUGO := 'Svibanj ';	MJESEC_KRATKO := 'Svi';		 MJESEC_DUGO := 'Svibanj';
            ELSIF MJESEC_BROJ = 6 THEN  MJESEC_GODINA_KRATKO_CRTA := 'LIP'; 		MJESEC_GODINA_KRATKO := 'Lip '; 		MJESEC_GODINA_DUGO := 'Lipanj ';	MJESEC_KRATKO := 'Lip';		 MJESEC_DUGO := 'Lipanj';
            ELSIF MJESEC_BROJ = 7 THEN  MJESEC_GODINA_KRATKO_CRTA := 'SRP'; 		MJESEC_GODINA_KRATKO := 'Srp '; 		MJESEC_GODINA_DUGO := 'Srpanj ';	MJESEC_KRATKO := 'Srp';		 MJESEC_DUGO := 'Srpanj';
            ELSIF MJESEC_BROJ = 8 THEN  MJESEC_GODINA_KRATKO_CRTA := 'KOL'; 		MJESEC_GODINA_KRATKO := 'Kol'; 		 	MJESEC_GODINA_DUGO := 'Kolovoz ';	MJESEC_KRATKO := 'Kol';		 MJESEC_DUGO := 'Kolovoz';
            ELSIF MJESEC_BROJ = 9 THEN  MJESEC_GODINA_KRATKO_CRTA := 'RUJ'; 		MJESEC_GODINA_KRATKO := 'Ruj '; 		MJESEC_GODINA_DUGO := 'Rujan ';		MJESEC_KRATKO := 'Ruj';		 MJESEC_DUGO := 'Rujan';
            ELSIF MJESEC_BROJ = 10 THEN  MJESEC_GODINA_KRATKO_CRTA := 'LIS'; 	 	MJESEC_GODINA_KRATKO := 'Lis '; 		MJESEC_GODINA_DUGO := 'Listopad ';	MJESEC_KRATKO := 'Lis';		 MJESEC_DUGO := 'Listopad';
            ELSIF MJESEC_BROJ = 11 THEN  MJESEC_GODINA_KRATKO_CRTA := 'STU'; 	 	MJESEC_GODINA_KRATKO := 'Stu '; 		MJESEC_GODINA_DUGO := 'Studeni ';	MJESEC_KRATKO := 'Stu';		 MJESEC_DUGO := 'Studeni';
            ELSIF MJESEC_BROJ = 12 THEN  MJESEC_GODINA_KRATKO_CRTA := 'PRO'; 	 	MJESEC_GODINA_KRATKO := 'Pro '; 		MJESEC_GODINA_DUGO := 'Prosinac ';	MJESEC_KRATKO := 'Pro';		 MJESEC_DUGO := 'Prosinac';
			END IF;

            MJESEC_GODINA_KRATKO_CRTA := MJESEC_GODINA_KRATKO_CRTA || '-' || date_part('year', datum_trenutni);
            MJESEC_GODINA_KRATKO := MJESEC_GODINA_KRATKO || ' ' || date_part('year', datum_trenutni);
            MJESEC_GODINA_DUGO := MJESEC_GODINA_DUGO || ' '|| date_part('year', datum_trenutni);
            MJESEC_U_DANIMA := date_part('day', (date_trunc('month', datum_trenutni::date) + interval '1 month' - interval '1 day')::date);
			MJESEC_ZADNJI_DAN_GODINE := date_part('doy', (date_trunc('month', datum_trenutni::date) + interval '1 month' - interval '1 day')::date);
            
			KVARTAL := EXTRACT(QUARTER from datum_trenutni);
			KVARTAL_TRAJANJE := date_part('doy', (date_trunc('quarter', datum_trenutni::date) + interval '3 month' - interval '1 day')::date) - date_part('doy', (date_trunc('quarter', datum_trenutni::date))::date);
			KVARTAL_ZADNJI_DAN := date_part('doy', (date_trunc('quarter', datum_trenutni::date) + interval '3 month' - interval '1 day')::date);
            
            GODINA_U_DANIMA := date_part('doy', (date_trunc('year', datum_trenutni::date) + interval '12 month' - interval '1 day')::date);
            
            GODINA_POLOVICA := CEIL (KVARTAL::decimal/2) ;
            GODINA_POLOVICA_NAZIV := 'H' || GODINA_POLOVICA || '-' || GODINA;

			if KVARTAL = 1 then
					GODINA_POLOVICA_ZADNJI_DAN := date_part('doy', (date_trunc('year', datum_trenutni::date) + interval '6 month' - interval '1 day')::date);
					GODINA_POLOVICA_PRVI_DAN := date_part('doy', (date_trunc('year', datum_trenutni::date))::date);
			end if;
			if KVARTAL = 2 then
					GODINA_POLOVICA_ZADNJI_DAN := date_part('doy', (date_trunc('year', datum_trenutni::date) + interval '12 month' - interval '1 day')::date);
					GODINA_POLOVICA_PRVI_DAN := date_part('doy', (date_trunc('year', datum_trenutni::date) + interval '6 month')::date);
			end if;

			GODINA_POLOVICA_TRAJANJE :=  GODINA_POLOVICA_ZADNJI_DAN - GODINA_POLOVICA_PRVI_DAN;
			
			DAN_STRING := (GODINA::text) || (MJESEC_BROJ::text) || (DAN_U_MJESECU::text);

			iterator := iterator + 1 ;
			INSERT INTO dimenzija_vrijeme VALUES (
            		iterator,
                    datum_trenutni,
                    DAN_STRING,
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

             datum_trenutni := datum_trenutni + '1 DAY'::INTERVAL;

      END LOOP;

	return 1;

END;
$$ LANGUAGE plpgsql;


select GenerirajPodatke (make_date(2000, 1, 1), make_date(2100, 1, 1));

--SELECT * FROM dimenzija_vrijeme;
