SQL scripts for time dimension
===================================================

Here are several SQL scripts for generating time dimension table in an enterprise data warehouse.
Start and end date are easily configurable in function call.
All columns and values are on Croatian language, but can easily be translated to English. 
Results for 21. century are exported in a sample file (time.csv).


### Table schema

id;								- Primary key \
DATUM_KEY;						- Unique date string in format yyyy-mm-dd  \
DAN_STRING;						- Unique date string in format yyyymmdd \
DAN_U_TJEDNU_NAZIV;				- Full day of the week string \
DAN_U_TJEDNU_NAZIV_KRATKI;		- Short day of the week string \
DAN_U_TJEDNU_NAZIV_BROJ;		- Day of the week in a numeric format \
DAN_U_MJESECU;					- Day of the month in a numeric format \
DAN_U_GODINI;					- Day of the year in a numeric format \
TJEDAN_U_GODINI_BROJ;			- Week of the year in a numeric format \
TJEDAN_I_GODINA;				- Week of the year with year in a format ww-yyyy \
MJESEC_BROJ;					- Month of the year in a numeric format \
MJESEC_GODINA_KRATKO_CRTA;		- Month of the year as short string with year in a format mmm-yyyy \ 
MJESEC_U_DANIMA;				- Number of days in current month \
MJESEC_ZADNJI_DAN_GODINE;		- Last day of the month represented through its position in a year \
MJESEC_GODINA_KRATKO;			- Month of the year as short string with year in a format MMM yyyy \
MJESEC_GODINA_DUGO;				- Month of the year as full string with year \
MJESEC_KRATKO;					- Month as a short string \
MJESEC_DUGO;					- Month as a full name \
KVARTAL;						- Quarter as a numeric value \
KVARTAL_TRAJANJE;				- Number of days in a quarter \
KVARTAL_ZADNJI_DAN;				- Last day of the quarter represented through its position in a year \
GODINA;							- Year in a numeric format yyyy \
GODINA_U_DANIMA;				- Number of days in a year \
GODINA_POLOVICA;				- Flag for a first (1) or a second (2) part of the year \
GODINA_POLOVICA_NAZIV;			- Long identifier with year in a form H*-yyyy. H is for "half". \
GODINA_POLOVICA_TRAJANJE;		- Number of days in the current half of the year \
GODINA_POLOVICA_ZADNJI_DAN		- Last day of the current half of the year represented through its position in a year \



### Data sample

11113;2030-06-04;20300604;Utorak;UTO;2;4;155;23;23-2030;6;LIP-2030;30;181;Lip 2030;Lipanj 2030;Lip;Lipanj;2;91;181;2030;365;1;H1-2030;181;11139 \
11114;2030-06-05;20300605;Srijeda;SRI;3;5;156;23;23-2030;6;LIP-2030;30;181;Lip 2030;Lipanj 2030;Lip;Lipanj;2;91;181;2030;365;1;H1-2030;181;11139 \
11115;2030-06-06;20300606;Četvrtak;ČET;4;6;157;23;23-2030;6;LIP-2030;30;181;Lip 2030;Lipanj 2030;Lip;Lipanj;2;91;181;2030;365;1;H1-2030;181;11139 \
11116;2030-06-07;20300607;Petak;PET;5;7;158;23;23-2030;6;LIP-2030;30;181;Lip 2030;Lipanj 2030;Lip;Lipanj;2;91;181;2030;365;1;H1-2030;181;11139 \
11117;2030-06-08;20300608;Subota;SUB;6;8;159;23;23-2030;6;LIP-2030;30;181;Lip 2030;Lipanj 2030;Lip;Lipanj;2;91;181;2030;365;1;H1-2030;181;11139 \
11118;2030-06-09;20300609;Nedjelja;NED;7;9;160;23;23-2030;6;LIP-2030;30;181;Lip 2030;Lipanj 2030;Lip;Lipanj;2;91;181;2030;365;1;H1-2030;181;11139 \
11119;2030-06-10;20300610;Ponedjeljak;PON;1;10;161;24;24-2030;6;LIP-2030;30;181;Lip 2030;Lipanj 2030;Lip;Lipanj;2;91;181;2030;365;1;H1-2030;181;11139 \
11120;2030-06-11;20300611;Utorak;UTO;2;11;162;24;24-2030;6;LIP-2030;30;181;Lip 2030;Lipanj 2030;Lip;Lipanj;2;91;181;2030;365;1;H1-2030;181;11139 \
11121;2030-06-12;20300612;Srijeda;SRI;3;12;163;24;24-2030;6;LIP-2030;30;181;Lip 2030;Lipanj 2030;Lip;Lipanj;2;91;181;2030;365;1;H1-2030;181;11139 \
11122;2030-06-13;20300613;Četvrtak;ČET;4;13;164;24;24-2030;6;LIP-2030;30;181;Lip 2030;Lipanj 2030;Lip;Lipanj;2;91;181;2030;365;1;H1-2030;181;11139 \

