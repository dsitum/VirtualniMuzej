-- phpMyAdmin SQL Dump
-- version 3.3.7deb7
-- http://www.phpmyadmin.net
--
-- Računalo: localhost
-- Vrijeme generiranja: Lip 17, 2013 u 03:24 PM
-- Verzija poslužitelja: 5.0.51
-- PHP verzija: 5.3.3-7+squeeze15

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Baza podataka: `WebDiP2012_073`
--

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `eksponati`
--

CREATE TABLE IF NOT EXISTS `eksponati` (
  `idEksponata` int(11) NOT NULL auto_increment,
  `naziv` varchar(50) NOT NULL,
  `opisEksponata` text NOT NULL,
  `godinaPorijekla` int(11) default NULL,
  `prijeKrista` tinyint(1) NOT NULL default '0',
  `brojPregleda` int(10) NOT NULL,
  `slika` text NOT NULL,
  `soba` int(11) NOT NULL,
  `OAutoru` text,
  `Orazdoblju` text,
  `kljucneRijeci` text,
  `vidljivostEksponata` tinyint(1) NOT NULL COMMENT 'Poprima 3 vrijednosti: 0 = javno; 1 = samo registrirani korisnici; 2 = privatno',
  PRIMARY KEY  (`idEksponata`),
  UNIQUE KEY `id_eksponata_UNIQUE` (`idEksponata`),
  KEY `fk_eksponati_sobe1_idx` (`soba`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=33 ;

--
-- Izbacivanje podataka za tablicu `eksponati`
--

INSERT INTO `eksponati` (`idEksponata`, `naziv`, `opisEksponata`, `godinaPorijekla`, `prijeKrista`, `brojPregleda`, `slika`, `soba`, `OAutoru`, `Orazdoblju`, `kljucneRijeci`, `vidljivostEksponata`) VALUES
(1, 'Vučedolska golubica', 'Keramička posuda s arheoloških iskopina u vučedolu. Jedan je od najpoznatijih simbola Vukovara. Iako je prozvana golubica, arheolozi smatraju da se zapravo radi o ptici jarebici.', 3000, 1, 1494, '1370900626.vucedolska_golubica.jpg', 10, NULL, 'http://hr.wikipedia.org/wiki/Vučedolska_kultura', 'Vukovar,golubica,vučedol,jarebica,posuda', 0),
(2, 'Barbarsko-keltski novac', 'Skupni nalaz srebrnog barbarsko-keltskog novca, 1. st. pr Kr. Okić kod Samobora', 100, 1, 1328, '1370900639.barbarsko-keltski_novac.jpg', 1, NULL, 'http://tinyurl.com/lvd6hsc', 'novac', 1),
(3, 'Banski denar', 'Banski denar (tzv. slavonski banovac), srebro, 13. st. zagrebačka kovnica, promjer 15 mm', 1300, 0, 1609, '1370900656.banski_denar.jpg', 1, NULL, 'http://www.ladica.net/ostalo/banski-denar-banovac.aspx', 'novac', 2),
(4, 'Radnitzky spomen medalja', 'C. Radnitzky: Zagrebačka biskupija postaje nadbiskupijom, srebrna spomen-medalja, 1853. god.', 1853, 0, 1088, '1370900647.Radnitzky_spomen_medalja.jpg', 2, NULL, NULL, NULL, 0),
(5, 'Istočnogotska fibula', 'Par istočnogotskih srebrnih lučnih fibula, 5. st. Ilok, dužina 22 cm', 500, 0, 1731, '1370900665.istocnogotska_fibula_ilok.jpg', 1, NULL, 'http://tinyurl.com/ndbnrr4', NULL, 0),
(6, 'Bašćanska ploča', 'Starohrvatski spomenik, pisan glagoljicom otprilike 1100. godine, a pronađena je 15. rujna 1851. u crkve sv. Lucije u Jurandvoru kod Baške na otoku Krku, zahvaljujući baščanskom kleriku Petru Dorčiću.', 1100, 0, 1558, '1370900593.Bascanska_ploca.jpg', 2, '', 'http://hr.wikipedia.org/wiki/Bašćanska_ploča', '', 1),
(7, 'Mona Lisa', 'The Mona Lisa (La Gioconda ili La Joconde) je jedna od najpoznatijih slika, naslikana uljem na drvu, veličine 77 x 53 cm, nalazi se u pariškom muzeju Louvreu ( Musée du Louvre, Paris). Portret Lise Gherardini.', 1500, 0, 23, '1371086014.1)Mona Lisa - Leonardo da Vinci.jpg', 6, 'http://hr.wikipedia.org/wiki/Leonardo_da_Vinci', 'http://hr.wikipedia.org/wiki/Renesansa', 'Mona Lisa,Leonardo da Vinci,renesansa', 0),
(8, 'Mislilac', 'Skulptura od bronce, patinirana i polirana, visine 72 cm. Original se nalazi u pariškom muzeju Rodin (Musée Rodin, Paris).', 1800, 0, 24, '1371086166.2)The Thinker- Auguste Rodin.jpg', 6, 'http://hr.wikipedia.org/wiki/Auguste_Rodin', 'http://hr.wikipedia.org/wiki/Simbolizam', 'Mislilac,Auguste Rodin,muzej Rodin', 1),
(9, 'Diskobol', 'Rimska mramorna kopija prema grčkom originalu u bronci, prirodne veličine načinjen prema motivu Diskobola, bacača diska, starogrčkog atletičara. Čuva se u muzeju „Museo delle Terme“ u Rimu dok se jedna kopija čuva i u Londonskom muzeju.', 500, 1, 28, '1371086311.3)Diskobol Miron.jpg', 8, 'http://hr.wikipedia.org/wiki/Miron', NULL, 'Diskobol,Miron', 2),
(10, 'Krik, The Scream', 'Krik (91 × 73,5 cm) najpoznatija je slika norveškog ekspresionista Edvarda Muncha koja prikazuje užasnutu, pomalo demonsku figuru kako stoji na mostu nasuprot krvavocrvenog neba. Slika bi trebala simbolizirati ljudsku vrstu nadjačanu osjećajem egzistencijalnog straha i tjeskobe. Pejsaž u pozadini je Oslofjord, gledan s jednog brda nedaleko od Osla. Tehnika slikanja: ulje, tempera i pastel na kartonu', 1893, 0, 41, '1371086396.4)Krik.jpg', 7, 'http://hr.wikipedia.org/wiki/Edvard_Munch', 'http://hr.wikipedia.org/wiki/Ekspresionizam', 'Krik,The Scream,Munch', 0),
(11, 'Etrich Taube ili Etrich II Taube', 'Jedan od prvih zrakoplova koji su se gradili u večim količinama. Zbog svojih svojstava služio je kao izviđač te kao vojni avion. Primjerak se čuva u tehničkom muzeju u Beču. Dužina zrakoplova iznosila je 9,9 metara, visina 3,2 metara, površina krila 32,5 m2,  te se koristio 4-cilindrični Argus motor ili 6-cilindrični Mercedes motor.', 1915, 0, 40, '1371086464.5)Etrich Taube.jpg', 5, 'http://en.wikipedia.org/wiki/Igo_Etrich', NULL, 'Etrich,izviđač', 1),
(12, 'Commodore 64', 'elektroničko, kućno, 8-bitno računalo. Dimenzije 405 x205 x 80 cm, masa: 2 kg. Nastalo u SAD-u . Jedan primjerak čuva se u tehničkom muzeju u Zagrebu. Posjedovao je OS Commodore KERNAL/Commodore BASIC 2.0 GEOS , a procesor je bio izgrađen u MOS tehnologiji.', 1983, 0, 24, '1371086525.6)Commodore 64.jpg', 5, 'http://hr.wikipedia.org/wiki/Commodore_International', NULL, 'Commodore 64,kućno', 2),
(13, 'Hamurabijev zakonik', 'Hamurabijeva stela je crna bazaltna stela visoka 213 cm koja je pronađena u Suzi u današnjem Iranu, a danas se čuva u muzeju Louvre u Parizu. Na njenom vrhu se nalazi reljef visok 71,1 cm s prikazom cara Hamurabija ispred akadskog boga sunca Šamaša koji sjedi okrunjen na simboličnoj planini. Hamurabijev zakonik koji je ispisan na steli, pisan je klinastim pismom.', 1750, 1, 28, '1371086647.7)Hamurabijeva stela.jpg', 8, 'http://hr.wikipedia.org/wiki/Hamurabi', 'http://bs.wikipedia.org/wiki/Antička_Grčka', 'Hammurabi,stela,zakonik', 2),
(14, 'Skulptura iz Dur-Untaša, Mezopotamija', 'Figurica prikazuje mušku osobu koja štuje božanstvo. Građena od crnog vapnenca, školjaka, visine 29,5 cm. Čuva se u muzeju u Bagdadu.', 2700, 1, 30, '1371086730.8)Figurica iz Mezopotamije.jpg', 10, NULL, 'http://hr.wikipedia.org/wiki/Mezopotamija', 'Mezopotamija,skulptura,Bagdad', 0),
(15, 'Anubis', 'Drvena figurica šakala Anubisa, egipatskog boga mrtvih. Visina figurice je 23,5 cm ,a širina 43 cm. Figurica je napravljena od više zasebnih drvenih dijelova koji su potom spojeni skupa.  Pronađena u Africi.', NULL, 0, 45, '1371086796.9)Anubis.jpg', 2, NULL, 'http://hr.wikipedia.org/wiki/Drevni_Egipat', 'Anubis,Egipat', 1),
(16, 'Kristalna lubanja', 'Lubanja napravljena od jednog komada kvarca.Istraživač Mike Mitchell-Hedges je sa svojom kćerkom Annom 1927.g. otkrio jednu takvu lubanju u gradu Maja Lubaantum. Lubanja se čuva u Britanskom muzeju.', 1900, 0, 27, '1371086865.10)Kristalna lubanja.jpg', 3, 'http://hr.wikipedia.org/wiki/Maya_Indijanci', NULL, 'Kristalna lubanja,Maje', 2),
(17, 'Brončana figurica lovca', 'Pronađeno u Nigeriji. Figurica predstavlja lovca koji nosi antilopu, sa psom na svojoj nozi. Ima neobičan stil. Visina: 36 cm. Danas se čuva u  Britanskom muzeju.', 1700, 0, 47, '1371086921.11)Broncana figurica lovca.jpg', 9, NULL, NULL, 'figurica,lovca,muzeju', 1),
(18, 'Kamena ploča iz sjevernog dijela Asurbanipalove pa', 'Asirski reljef, pronađen u sjevernom Iraku, nastao za vrijeme vladavine kralja Ausrbanipala ( 669-631 god.pr.Kr.). Danas se čuva u Britanskom muzeju, a prikazuje lov na jelene.', 700, 1, 43, '1371087045.12)Kamena ploca iz sjevernog dijela Asurbanipalove palace.jpg', 8, NULL, 'http://hr.wikipedia.org/wiki/Asirci', 'kamena ploča,Asurbanipal', 0),
(19, 'Stolni sat', 'Izrađen u Londonu, Engleska u arhitekturnom stilu. Visina: 63,5 cm. Čuva se u Britanskom muzeju u sobi  satova.', 1675, 0, 39, '1371087160.13) stolni sat.jpg', 4, 'http://www.marshclocks.co.uk/antique-clock-details.asp?stockID=151', NULL, 'stolni,sat,Jones,muzej', 1),
(20, 'Tablica jednadžbi', 'Tablica jednadžbi za podešavanje satova po Suncu za 1768.godinu sa smjerovima za smjerovima za pronalaženje  pravog sjevera i juga. Duljina: 41,3 cm, visina: 25.6 cm.', 1768, 0, 23, '1371087215.14) Tablica jednadzbi.jpg', 4, 'http://en.wikipedia.org/wiki/Benjamin_Martin', NULL, 'tablica,Martin', 2),
(21, 'Mehanička galija', 'Ovaj bakreno –čelični  automat je osmišljen kako bi se kotrljao veliki stolom i objavljivao gozbu.', 1585, 0, 47, '1371087288.15)Mehanicka galija.jpg', 3, NULL, 'http://www.britishmuseum.org/explore/highlights/highlight_objects/pe_mla/a/the_mechanical_galleon.aspx', NULL, 1),
(22, 'Brončana skulptura boga Marsa', 'Smatra se poklonom Marsu, bogu rata. Visina: 27 cm. Pronađeno 1774.godine kod Lincolnshirea.', 100, 0, 67, '1371087359.16) Broncana skulptura boga Marsa.jpg', 9, NULL, 'http://en.wikipedia.org/wiki/Roman_Britain', 'skulptura,Mars,rat,bog', 0),
(23, 'Mozaik iz rimske vile', 'Mozaik pronađen kod Abbots Ann, Hampshire, oko 1850.godine. Jednostavan stil izgradnje u ograničenom rasponu boja slijedi tradicionalni rimski geometrijski dizajn.', 400, 0, 23, '1371087407.17) Mozaik iz rimske vile.jpg', 6, NULL, 'http://en.wikipedia.org/wiki/Roman_Britain', 'Mozaik,vile,Hampshire', 2),
(24, 'Partenonska skulptura metopa', 'Načinjena u Ateni. Prednji dio desnog stopala. Površina je oštećena.', 447, 1, 43, '1371087491.18) Partenonska skulptura metopa.jpg', 3, 'http://hr.wikipedia.org/wiki/Fidija', 'http://sh.wikipedia.org/wiki/Klasična_Grčka', 'Ateni,Fidija', 1),
(25, 'Bočica', 'Bočica od javorovog drva, zaobljena. Duljine: 8,4 cm i visine: 6,3 cm.', 700, 0, 27, '1371087567.19) Bocica.jpg', 9, NULL, 'http://hr.wikipedia.org/wiki/Anglosasi', 'Bočica,7.st.,Engleska', 2),
(26, 'Željezna sjekira', 'Pronađena u Graveu, Kent. Ovaj primjerak sa inicijalima pronađen je u grobu jedne značajne osobe. Duljina :17cm.', 600, 0, 27, '1371087619.20) Zeljezna sjekira.jpg', 10, NULL, 'http://hr.wikipedia.org/wiki/Anglosasi', 'sjekira,Kent', 2),
(27, 'Venus de Milo', 'Skulptura prikazuje grčku božicu Afroditu i potiče iz helenističke radionice. Najveća je i najbolje očuvana skulptura božice ljepote. Izgrađena je na otoku Melos.', 120, 1, 28, '1371087696.21) Venus de Milo.jpg', 10, NULL, 'http://bs.wikipedia.org/wiki/Antiohija', NULL, 1),
(28, 'Amor i Psiha', 'Mramorna skulptura visine 155 cm, čuva se u muzeju Louvre.', 1793, 0, 23, '1371087764.22) Amor i Psiha.jpg', 7, 'http://hr.wikipedia.org/wiki/Antonio_Canova', 'http://hr.wikipedia.org/wiki/Klasicizam', 'Canova,Amor i Psiha', 2),
(29, 'Podmornica “CB-20“', 'Talijanska obalna podmornica napravljena u Milanu. Maksimalna dubina ronjenja iznosila je 55 m. Težina: 35 tona. Raspolagala je s dva torpeda.', 1943, 0, 39, '1371087838.23) Podmornica CB-20.jpg', 5, NULL, 'http://hr.wikipedia.org/wiki/Drugi_svjetski_rat', 'CB-20,podmornica', 1),
(30, 'Melancholia, an engraving', 'Slika predstavlja Melankoliju okruženu instrumentima svog temperamenta.Slika je nastala u Njemačkoj. Visina: 241.000 mm, duljina: 192.000 mm', 1514, 0, 23, '1371087919.24) Melancholia.png', 7, 'http://hr.wikipedia.org/wiki/Albrecht_Dürer', 'http://hr.wikipedia.org/wiki/Renesansa', 'Dürer,Melankolija,renesansa', 2),
(32, 'Prva hrvatska biblija', 'Prva hrvatska biblija', 1500, 0, 3, '1371105956.original_biblija.jpg', 12, NULL, NULL, 'biblija', 1);

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `kalendarizlozbi`
--

CREATE TABLE IF NOT EXISTS `kalendarizlozbi` (
  `brojIzlozbe` int(11) NOT NULL auto_increment,
  `nazivIzlozbe` varchar(45) NOT NULL,
  `vrijemeOtvaranja` datetime NOT NULL,
  `vrijemeZatvaranja` datetime NOT NULL,
  `cijenaIzlozbe` int(11) NOT NULL,
  PRIMARY KEY  (`brojIzlozbe`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

--
-- Izbacivanje podataka za tablicu `kalendarizlozbi`
--

INSERT INTO `kalendarizlozbi` (`brojIzlozbe`, `nazivIzlozbe`, `vrijemeOtvaranja`, `vrijemeZatvaranja`, `cijenaIzlozbe`) VALUES
(1, 'Parne sobe', '2013-06-07 20:28:00', '2013-06-28 21:27:00', 50),
(8, 'Sav sadržaj muzeja', '2013-06-21 12:00:00', '2013-06-30 12:00:00', 75),
(9, 'Neparne sobe', '2013-06-03 12:00:00', '2013-06-09 12:00:00', 30),
(10, 'Tehnički odjel', '2013-06-08 12:00:00', '2013-06-20 12:00:00', 30),
(11, 'Galerije', '2013-06-09 12:00:00', '2013-06-30 12:00:00', 30),
(12, 'Arheološki odjel', '2013-06-03 22:00:00', '2013-06-17 22:00:00', 50),
(13, 'Prvih pet soba', '2013-06-01 12:00:00', '2013-06-04 12:00:00', 25),
(14, 'Drugih pet soba', '2013-06-01 12:00:00', '2013-06-09 12:00:00', 35),
(15, 'Odabrani eksponati ', '2013-06-06 12:00:00', '2013-06-15 12:00:00', 30),
(16, 'Odabrani eksponati (drugi dio)', '2013-06-21 12:00:00', '2013-06-30 12:00:00', 25),
(18, 'Biblije SZ Hrvatske', '2013-06-12 12:00:00', '2013-06-16 12:00:00', 30);

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `komentari`
--

CREATE TABLE IF NOT EXISTS `komentari` (
  `idKomentara` int(11) NOT NULL auto_increment,
  `nazivKomentara` varchar(45) default NULL,
  `tekstKomentara` text NOT NULL,
  `datumKomentiranja` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `eksponat` int(11) NOT NULL,
  `komentator` int(11) NOT NULL,
  PRIMARY KEY  (`idKomentara`),
  UNIQUE KEY `idKomentara_UNIQUE` (`idKomentara`),
  KEY `fk_komentari_eksponati1_idx` (`eksponat`),
  KEY `komentator` (`komentator`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=43 ;

--
-- Izbacivanje podataka za tablicu `komentari`
--

INSERT INTO `komentari` (`idKomentara`, `nazivKomentara`, `tekstKomentara`, `datumKomentiranja`, `eksponat`, `komentator`) VALUES
(1, 'Lorem ipsum dolor sit amet', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ac arcu mauris. Nam venenatis vestibulum fringilla. Mauris blandit sem quis ante facilisis sollicitudin. Duis tellus risus, laoreet adipiscing auctor a, elementum eget tortor. Etiam ullamcorper, leo id dignissim blandit, nunc justo commodo sem, vitae malesuada tellus augue sit amet lectus. Nam et neque magna, et venenatis odio. Sed feugiat, ante nec tempor dapibus, arcu purus rhoncus justo, vitae hendrerit lorem ligula vestibulum eros. Pellentesque ipsum dui, scelerisque in commodo sit amet, convallis sit amet elit. Suspendisse ut commodo nisi.', '2013-06-03 16:16:51', 5, 5),
(3, 'Vivamus facilisis', 'Morbi sagittis, dui a venenatis ornare, orci eros mattis justo, ac porta nisl nulla et justo. Maecenas sit amet leo ac ipsum posuere blandit. In hac habitasse platea dictumst. Donec porta erat felis, ut ornare enim. Proin hendrerit, augue vitae rutrum fringilla, libero leo vehicula nisi, ac cursus erat eros ut lacus. Sed auctor iaculis pulvinar. Quisque tincidunt tempus risus eget tempor. Integer sit amet molestie ligula. Nullam lobortis tincidunt commodo. Nulla eget erat sit amet sem malesuada hendrerit vel tempus est. Suspendisse id quam justo. Maecenas luctus lorem quis sem porta vulputate. Vivamus facilisis, nisl nec pulvinar vulputate, mauris mauris imperdiet leo, non commodo sapien ligula a ligula.', '2013-06-04 00:40:01', 5, 7),
(10, 'Moj prvi komentar', 'Moj prvi komentar pomoću ove forme koji zapravo radi!! Yaay!', '2013-06-04 03:10:01', 5, 13),
(13, 'Left-leaning', 'I visited a Rauschenberg exhibition the other day after a saunter through Borough market and it struck me. The salt-of-the-earth type jobs some of my primary school classmates ended up in just don''t exist any more. We should all go back to living in communes like they did in Sweden in the 70s!', '2013-06-04 08:14:41', 3, 13),
(15, 'James ''Jimmy'' Mayberry-Smithwick', 'After spending three years in a Tibetan Buddhist monastery, I find that I am able to see much more clearly the interconnections between today''s geo-political imbalances and many of our social predicaments - for instance: At a time of global recession why are we still having to fight for trans rights? We might as well adopt American-style gun laws and let the EDL take over government because this country''s going to hell anyway.', '2013-06-13 04:12:28', 2, 3),
(16, 'Still working class inside', 'Chatting to the builder sprucing up our conservatory, I started to ponder. When it comes to buying seafood, it just simply isn''t worth trying to save a few pounds choosing dredged over hand-caught scallops. We might as well adopt American-style gun laws and let the EDL take over government because this country''s going to hell anyway.', '2013-06-13 04:16:27', 24, 5),
(17, 'More in it than most', 'As my great-uncle on my mother''s side was a steel-worker from East Kilbride I feel that I can speak with some authority about the British working-class experience. One cannot re-read Kafka enough these days - the lessons for our generation especially have never been more salient. Unless we send out a clear message to the Bob Diamonds and Howard Schultz''s of this world they will never learn!', '2013-06-13 04:16:27', 25, 9),
(18, 'Gwyneth', 'My holiday home in Provence is hardly a luxury! One cannot re-read Kafka enough these days - the lessons for our generation especially have never been more salient. Volunteering and community have been killed by Cameron''s ''Big Society''.', '2013-06-13 04:23:56', 12, 3),
(19, 'Milliband 4 PM', 'Whilst looking for a charging spot for my electric car it came to me. Nigel Slater''s dumbing-down of cookery means he rarely uses any of the interesting ingredients in my local deli. We should all go back to living in communes like they did in Sweden in the 70s!', '2013-06-13 04:23:56', 7, 4),
(20, 'Michael Pentonville-Saatchi', 'As one of only a handful enjoying a remarkable Rumanian reproduction of The Master and Margarita in our local art-house theatre I couldn''t help but wonder what today''s culturally degenerated youth were doing instead? I would rather vote for the BNP than let my three year old eat anything sold in Asda! We should all go back to living in communes like they did in Sweden in the 70s!', '2013-06-13 04:23:56', 8, 5),
(21, 'Left-leaning', 'My holiday home in Provence is hardly a luxury! Osborne''s savage attack on differently-abled people is an outright abuse of the British commitment to decency and tolerance. The problem is that we''re always competing instead of working together.', '2013-06-13 04:23:56', 9, 7),
(22, 'Milliband 4 PM', 'I don''t go to the pub often since I hate commercial lagers, but I was drinking an American Pale Ale with a friend yesterday and it really got us thinking. Of course Church is important but our little Sophia managed to fit in Diwali, Ramadan, Kwanza and, of course, Chanukah, just in her small group of friends. That''s just one more reason why we must stop multinationals from buying up British companies!', '2013-06-13 04:23:56', 10, 8),
(23, 'James ''Jimmy'' Mayberry-Smithwick', 'With my youngest at violin lessons twice a week and the oldest getting really into her aquarels at the moment, do I really have time to get involved in the local community? One cannot re-read Kafka enough these days - the lessons for our generation especially have never been more salient. That just goes to show what happens when global corporations can get their hands on our personal information!', '2013-06-13 04:23:56', 11, 9),
(24, NULL, 'My holiday home in Provence is hardly a luxury! If my cleaner can speak such wonderful English, why can''t all children in the UK learn at least two foreign languages? We might as well adopt American-style gun laws and let the EDL take over government because this country''s going to hell anyway.', '2013-06-13 04:23:56', 12, 10),
(25, 'Multicultural and proud!', 'A touch of nutmeg really bolsters the egg flavours in an otherwise traiditional Yorkshire pudding, which can really focus the mind on other issues. At a time of global recession why are we still having to fight for trans rights? And that''s why prison is the best place to show the vulnerable that we care.', '2013-06-13 04:23:56', 13, 11),
(26, NULL, 'As one of only a handful enjoying a remarkable Rumanian reproduction of The Master and Margarita in our local art-house theatre I couldn''t help but wonder what today''s culturally degenerated youth were doing instead? It''s absurd we haven''t yet reached full equality for all ethno-sexual persuasions. But I guess that''s just what happens when we let Saudi oil magnates rape our ecosystems and ruin the planet.', '2013-06-13 04:23:56', 14, 12),
(27, NULL, 'Last Saturday, as I was weeding my organic foxglove bed, it struck me! Why are the cis-sexual backlash movement intent on opressing my right to fair-trade cocoa? But that''s just what we get when we continue to measure economic growth through GDP rather than focusing on freedom of expression and sustainability.', '2013-06-13 04:23:56', 15, 13),
(28, 'Persemmone', 'After a late night pilates session me and my chums were discussing things. Nigel Slater''s dumbing-down of cookery means he rarely uses any of the interesting ingredients in my local deli. That''s just one more reason why we must stop multinationals from buying up British companies!', '2013-06-13 04:23:56', 16, 14),
(29, 'A tantric dream state.', 'I was talking to friends at the local fair-trade delicatessen and we''re agreed. We must give back the USA to the native Americans right away! I guess Marx was more right than he knew when he warned us against the dangers of laissez-faire capitalism.', '2013-06-13 04:23:56', 17, 3),
(30, NULL, 'The other day, admiring the pictures taken during our recent trip to rural Malawi with my new DLSR camera, the honest simplicity of the locals'' existence got me thinking. I mean, I''m not saying that I have never fallen foul of watching Big Brother, but come on, we''ve got to have some standards. That''s just one more reason why we must stop multinationals from buying up British companies!', '2013-06-13 04:23:56', 18, 4),
(31, 'St. Andrews.', 'We were chatting over a coffee, simple filter, not Nescafe (baby-killers) and started to think out loud. If we all paid more regular visits to our local Turkish tea shops we might better understand why Armenia is such a complicated issue. We should all go back to living in communes like they did in Sweden in the 70s!', '2013-06-13 04:23:56', 19, 5),
(32, 'Close to Nirvana.', 'As I was composting the left-overs of my foraged berry and wild sorrel salad, I couldn''t help wonder! Of course Church is important but our little Sophia managed to fit in Diwali, Ramadan, Kwanza and, of course, Chanukah, just in her small group of friends. Do you think the multinational corporations would let that happen?', '2013-06-13 04:23:56', 20, 7),
(33, 'Head in the clouds.', 'I don''t go to the pub often since I hate commercial lagers, but I was drinking an American Pale Ale with a friend yesterday and it really got us thinking. When pickling one''s own sauerkraut, hand-picked juniper berries are simply a non-negotiable necessity. Do you think the multinational corporations would let that happen?', '2013-06-13 04:23:56', 21, 8),
(34, 'More in it than most', 'I refused to read the article as I was so outraged by the headline but my response is unambiguous! One cannot re-read Kafka enough these days - the lessons for our generation especially have never been more salient. But how can we expect things to improve whilst China are still in Tibet!', '2013-06-13 04:23:56', 22, 9),
(35, NULL, 'My holiday home in Provence is hardly a luxury! Judging children''s abilities by standardised exams denies them their unique individuality and the expression of their culturally distinct identities. Free Gaza now!', '2013-06-13 04:23:56', 23, 10),
(36, NULL, 'I don''t go to the pub often since I hate commercial lagers, but I was drinking an American Pale Ale with a friend yesterday and it really got us thinking. Why bring back O-levels when dance still isn''t a compulsory part of science! It''s time to recognise that animal rights now are as important as women''s rights last century.', '2013-06-13 04:23:56', 24, 11),
(37, 'The Chilterns.', 'I don''t go to the pub often since I hate commercial lagers, but I was drinking an American Pale Ale with a friend yesterday and it really got us thinking. If we all paid more regular visits to our local Turkish tea shops we might better understand why Armenia is such a complicated issue. We should all go back to living in communes like they did in Sweden in the 70s!', '2013-06-13 04:23:56', 25, 14),
(38, NULL, 'With my youngest at violin lessons twice a week and the oldest getting really into her aquarels at the moment, do I really have time to get involved in the local community? It''s absurd we haven''t yet reached full equality for all ethno-sexual persuasions. Where have all the real socialists gone?', '2013-06-13 04:24:59', 26, 8),
(39, 'Gwyn Trig-Hampsteath', 'After spending three years in a Tibetan Buddhist monastery, I find that I am able to see much more clearly the interconnections between today''s geo-political imbalances and many of our social predicaments - for instance: You can''t tell whether a small chain is real or just a front for Te$co. Where have all the real socialists gone?', '2013-06-13 04:24:59', 27, 12),
(40, NULL, 'I was talking to friends at the local fair-trade delicatessen and we''re agreed. How can we expect the next generation to get their five-a-day when even Waitrose don''t sell traditional British apple varieties? The problem is that we''re always competing instead of working together.', '2013-06-13 04:25:21', 30, 14),
(41, '', 'Jako lijepa knjiga', '2013-06-13 08:47:23', 32, 41),
(42, '', 'Ovo je moj drugi komentar', '2013-06-13 08:47:40', 32, 41);

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `korisnici`
--

CREATE TABLE IF NOT EXISTS `korisnici` (
  `idKorisnika` int(11) NOT NULL auto_increment,
  `korime` varchar(15) NOT NULL,
  `lozinka` char(64) NOT NULL,
  `ime` varchar(30) default NULL,
  `prezime` varchar(30) default NULL,
  `email` varchar(100) NOT NULL,
  `telefon` varchar(15) NOT NULL,
  `grad` varchar(30) NOT NULL,
  `zivotopis` text NOT NULL,
  `datum_rodjenja` date NOT NULL,
  `spol` char(1) default NULL,
  `mailObavijesti` tinyint(4) default NULL,
  `datum_registracije` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `aktiviran` tinyint(1) default NULL,
  `tipKorisnika` int(11) NOT NULL,
  `zakljucan` tinyint(4) NOT NULL,
  `neuspjesnePrijave` int(11) NOT NULL default '0',
  `brojPrijava` int(11) NOT NULL default '0',
  PRIMARY KEY  (`idKorisnika`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `id_korisnika_UNIQUE` (`idKorisnika`),
  UNIQUE KEY `korime` (`korime`),
  KEY `fk_korisnici_tipKorisnika_idx` (`tipKorisnika`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=42 ;

--
-- Izbacivanje podataka za tablicu `korisnici`
--

INSERT INTO `korisnici` (`idKorisnika`, `korime`, `lozinka`, `ime`, `prezime`, `email`, `telefon`, `grad`, `zivotopis`, `datum_rodjenja`, `spol`, `mailObavijesti`, `datum_registracije`, `aktiviran`, `tipKorisnika`, `zakljucan`, `neuspjesnePrijave`, `brojPrijava`) VALUES
(3, 'dsitum', '123456', 'Domagoj', 'Šitum', 'dsitum@foi.hr', '098555555', 'Ivankovo', 'Moj kratki životopis ;)', '1991-06-05', 'm', 1, '2013-06-12 18:56:30', 1, 3, 0, 0, 1),
(4, 'atomas', '123456', 'Anto', 'Tomaš', 'antotomas@foi.hr', '0981234565', 'Severin', 'Životopis .....', '1992-07-09', 'm', 0, '2013-05-07 09:55:03', 1, 1, 0, 0, 1),
(5, 'perisa', '123456', 'Jozo', 'Perišić', 'perisa@pero.net', '0986242260', 'Zadar', 'Ja sam pero periša', '1991-06-13', 'm', 1, '2013-05-07 16:14:35', 1, 1, 0, 0, 0),
(7, 'lzodan', '456789', 'Lucija', 'Žodan', 'lzodan@foi.hr', '0945646461', 'Zadar', 'ruiaurie rei urvpeiurvjepi eiu', '1986-05-08', 'z', 1, '2013-05-07 21:58:01', 0, 1, 0, 0, 0),
(8, 'pbilic', 'bilic03', 'Petra', 'Bilić', 'pbilic@foi.hr', '094564602', 'Zagreb', 'Moj životopis', '2013-02-14', 'z', 0, '2013-05-07 21:59:09', 0, 1, 1, 0, 0),
(9, 'dpranjic', 'pranja1', 'David', 'Pranjić', 'pranjic@hotmail.com', '098456789', 'Ivankovo', 'Ja sam david pranjić', '2009-05-15', 'm', 0, '2013-05-07 22:00:46', 1, 2, 0, 0, 0),
(10, 'lili99', 'lili123', 'Ljiljana', 'Škrabo', 'lskrabo@domena.com', '098287684', 'Varaždin', 'rm ezrupr09d8k pdkp8 iaehi ', '2005-05-13', 'z', 1, '2013-06-12 19:51:00', 0, 2, 0, 0, 0),
(11, 'zzan__', 'strašni', 'Žan', 'Strahija', 'zstrahij@foi.hr', '095456287', 'Čakovec', 'ienmiia8  žeinafiemna enmi', '2008-12-12', 'm', 1, '2013-05-07 22:05:34', 1, 1, 0, 0, 0),
(12, 'tutavac', 'tutifruti', 'Ivan', 'Tutavac', 'itutavac@gmail.com', '0914580369', 'Dubrovnik', 'Dubrovnik je lijep grad', '1990-05-11', 'm', 1, '2013-05-07 22:06:43', 0, 1, 0, 0, 0),
(13, 'admin', 'admin', 'Administrator', 'Anonim', 'admin@muzej.com', '0980000000', 'Vinkovci', 'Sopot FTW!!!!!!11!!!!1!!', '1982-05-20', 'm', 1, '2013-05-21 07:24:42', 1, 3, 0, 0, 16),
(14, 'webdip', 'webdip', 'Webdip', 'Webdip', 'webdip@webdip.hr', '0980000001', 'Vinkovci', 'Sopot !!!!!!11!!!!1!!', '1990-05-18', 'm', 1, '2013-05-21 07:31:11', 1, 1, 0, 0, 5),
(36, 'kustos', 'kustos', 'Andrej', 'Vidinović', 'kustos@muzej.com', '098000111', 'Zabok', 'Veliki obožavatelj muzeja', '1988-06-09', 'm', 0, '2013-06-13 04:47:45', 1, 2, 0, 0, 5),
(41, 'blanka', '123456', 'Blanka', 'Vlašić', 'domagoj.situm@hotmail.com', '098111788', 'Split', 'Životaiem', '1987-12-16', 'z', 1, '2013-06-13 08:35:38', 1, 1, 0, 0, 3);

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `log`
--

CREATE TABLE IF NOT EXISTS `log` (
  `brojZapisa` int(11) NOT NULL auto_increment,
  `korisnik` int(11) default NULL,
  `aktivnost` text NOT NULL,
  `vrijeme` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `ipAdresa` varchar(15) NOT NULL,
  `preglednik` varchar(150) NOT NULL,
  PRIMARY KEY  (`brojZapisa`),
  KEY `fk_log_korisnici1_idx` (`korisnik`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=266 ;

--
-- Izbacivanje podataka za tablicu `log`
--

INSERT INTO `log` (`brojZapisa`, `korisnik`, `aktivnost`, `vrijeme`, `ipAdresa`, `preglednik`) VALUES
(9, 3, 'Kupio suvenire: Replika banskog denara (1 kom), ', '2013-06-13 04:32:43', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(10, 3, 'Kupio ulaznicu za izložbu "Probna izložba 1"', '2013-06-13 04:36:41', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(16, NULL, 'Aktivirao korisnički račun (dsitum)', '2013-06-12 18:59:18', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(17, NULL, 'Pokušao aktivirati korisnički račun korisnika koji ne postoji. Proslijeđeni ID: 125', '2013-06-12 19:00:42', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(23, 13, 'Uredio korisničke podatke korisnika: admin', '2013-06-12 19:30:45', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(24, 13, 'Uredio korisničke podatke korisnika: dsitum', '2013-06-12 19:31:33', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(27, 14, 'Uredio vlastite korisničke podatke', '2013-06-12 19:34:57', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(31, 14, 'Odjava sa sustava (korisnik: webdip)', '2013-06-12 19:37:31', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(32, 13, 'Odjava sa sustava (korisnik: admin)', '2013-06-12 19:51:59', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(33, NULL, 'Pokušao aktivirati korisnički račun koji već postoji (korisničko ime: dpranjic)', '2013-06-12 19:52:07', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(34, NULL, 'Pokušao aktivirati korisnički račun kojem je vrijeme za aktivaciju isteklo (korisničko ime: dpranjic)', '2013-06-12 19:52:07', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(35, NULL, 'Aktivirao korisnički račun (lili99)', '2013-06-12 19:52:16', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(36, 13, 'Odjava sa sustava (korisnik: admin)', '2013-06-13 20:52:46', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(37, NULL, 'Pokušao aktivirati korisnički račun kojem je vrijeme za aktivaciju isteklo (korisničko ime: lili99)', '2013-06-13 20:52:52', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(38, 13, 'Odjava sa sustava (korisnik: admin)', '2013-06-12 19:53:19', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(39, NULL, 'Aktivirao korisnički račun (lili99)', '2013-06-12 19:53:27', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(42, 13, 'Prijavio se na sustav', '2013-06-12 20:14:54', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(43, 13, 'Odjava sa sustava (korisnik: admin)', '2013-06-12 20:15:05', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(48, 13, 'Prijavio se na sustav', '2013-06-12 20:18:21', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(49, 13, 'Odjava sa sustava (korisnik: admin)', '2013-06-12 20:25:57', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(50, 14, 'Prijavio se na sustav', '2013-06-12 20:26:02', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(51, 14, 'Pokušao uređivati korisničke podatke drugog korisnika.', '2013-06-12 20:26:14', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(52, 14, 'Odjava sa sustava (korisnik: webdip)', '2013-06-12 20:26:44', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(54, 13, 'Prijavio se na sustav', '2013-06-12 20:56:29', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(66, 13, 'Prijavio se na sustav', '2013-06-13 01:54:21', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(67, 13, 'Odjava sa sustava (korisnik: admin)', '2013-06-13 03:39:03', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(68, 13, 'Prijavio se na sustav', '2013-06-13 03:39:07', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(69, 13, 'Uredio korisničke podatke korisnika: atomas', '2013-06-13 04:31:48', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(70, 13, 'Uredio korisničke podatke korisnika: atomas', '2013-06-13 04:32:06', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(71, 13, 'Pokušao aktivirati korisnički račun korisnika koji ne postoji. Proslijeđeni ID: 138', '2013-06-13 04:35:06', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(72, 13, 'Pokušao aktivirati korisnički račun korisnika koji ne postoji. Proslijeđeni ID: 138', '2013-06-13 00:36:10', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(73, 13, 'Pokušao aktivirati korisnički račun korisnika koji ne postoji. Proslijeđeni ID: 138', '2013-06-13 00:36:58', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(74, 13, 'Pokušao aktivirati korisnički račun korisnika koji ne postoji. Proslijeđeni ID: 137', '2013-06-13 00:37:08', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(75, 13, 'Odjava sa sustava (korisnik: admin)', '2013-06-13 00:37:41', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(76, NULL, 'Pokušao aktivirati korisnički račun korisnika koji ne postoji. Proslijeđeni ID: 137', '2013-06-13 00:40:49', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(77, NULL, 'Pokušao aktivirati korisnički račun korisnika koji ne postoji. Proslijeđeni ID: 142', '2013-06-13 00:41:42', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(78, 13, 'Prijavio se na sustav', '2013-06-13 00:49:40', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(79, 13, 'Odjava sa sustava (korisnik: admin)', '2013-06-13 00:52:03', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(80, 13, 'Prijavio se na sustav', '2013-06-13 00:52:15', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(81, 13, 'Odjava sa sustava (korisnik: admin)', '2013-06-13 00:53:08', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(82, 13, 'Prijavio se na sustav', '2013-06-13 00:53:12', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(83, 13, 'Odjava sa sustava (korisnik: admin)', '2013-06-13 00:53:16', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(84, 13, 'Prijavio se na sustav', '2013-06-13 00:53:24', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(85, 13, 'Kupio suvenire: Replika banskog denara (1 kom), ', '2013-06-13 00:53:31', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(86, 13, 'Odjava sa sustava (korisnik: admin)', '2013-06-13 00:53:43', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(87, 13, 'Prijavio se na sustav', '2013-06-13 00:55:57', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(88, 13, 'Uklonio eksponat "Bašćanska ploča" iz osobne galerije', '2013-06-13 00:59:06', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(89, 13, 'Uklonio eksponat "Istočnogotska fibula" iz osobne galerije', '2013-06-13 01:11:32', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(90, 13, 'Odjava sa sustava (korisnik: admin)', '2013-06-13 01:11:46', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(91, NULL, 'Pokušao se prijaviti u sustav s krivim korisničkim podacima (upisano korisničko ime: dsitum). Pokušaj prijave: 1', '2013-06-13 01:11:52', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(92, 3, 'Prijavio se na sustav', '2013-06-13 01:11:56', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(93, 3, 'Dodao eksponat "Vučedolska golubica" u osobnu galeriju', '2013-06-13 01:12:08', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(94, 3, 'Odjava sa sustava (korisnik: dsitum)', '2013-06-13 01:18:58', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(95, 13, 'Prijavio se na sustav', '2013-06-13 02:06:14', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(96, 13, 'Dodao eksponat "Bašćanska ploča" u osobnu galeriju', '2013-06-13 02:06:18', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(97, 13, 'Prijavio se na sustav', '2013-06-13 02:21:35', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(98, 13, 'Prijavio se na sustav', '2013-06-13 03:09:18', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(99, 13, 'Uredio postojeći eksponat: Vučedolska golubica', '2013-06-13 03:09:43', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(100, 13, 'Uredio postojeći eksponat: Barbarsko-keltski novac', '2013-06-13 03:10:05', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(101, 13, 'Uredio postojeći eksponat: Banski denar', '2013-06-13 03:10:25', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(102, 13, 'Uredio postojeći eksponat: Istočnogotska fibula', '2013-06-13 03:10:37', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(103, 13, 'Uredio postojeći eksponat: Radnitzky spomen medalja', '2013-06-13 03:10:44', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(104, 13, 'Dodao novi eksponat: Mona Lisa', '2013-06-13 03:13:34', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(105, 13, 'Uredio postojeći eksponat: Mona Lisa', '2013-06-13 03:13:50', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(106, 13, 'Dodao novi eksponat: Mislilac', '2013-06-13 03:16:07', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(107, 13, 'Dodao novi eksponat: Diskobol', '2013-06-13 03:18:31', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(108, 13, 'Dodao novi eksponat: Krik, The Scream', '2013-06-13 03:19:57', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(109, 13, 'Dodao novi eksponat: Etrich Taube ili Etrich II Taube', '2013-06-13 03:21:05', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(110, 13, 'Dodao novi eksponat: Commodore 64', '2013-06-13 03:22:05', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(111, 13, 'Dodao novi eksponat: Hamurabijev zakonik', '2013-06-13 03:24:07', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(112, 13, 'Dodao novi eksponat: Skulptura iz Dur-Untaša, Mezopotamija', '2013-06-13 03:25:31', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(113, 13, 'Dodao novi eksponat: Anubis', '2013-06-13 03:26:36', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(114, 13, 'Dodao novi eksponat: Kristalna lubanja', '2013-06-13 03:27:45', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(115, 13, 'Dodao novi eksponat: Brončana figurica lovca', '2013-06-13 03:28:41', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(116, 13, 'Dodao novi eksponat: Kamena ploča iz sjevernog dijela Asurbanipalove pa', '2013-06-13 03:30:45', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(117, 13, 'Dodao novi eksponat: Stolni sat', '2013-06-13 03:32:40', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(118, 13, 'Dodao novi eksponat: Tablica jednadžbi', '2013-06-13 03:33:35', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(119, 13, 'Dodao novi eksponat: Mehanička galija', '2013-06-13 03:34:48', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(120, 13, 'Dodao novi eksponat: Brončana skulptura boga Marsa', '2013-06-13 03:35:59', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(121, 13, 'Dodao novi eksponat: Mozaik iz rimske vile', '2013-06-13 03:36:47', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(122, 13, 'Dodao novi eksponat: Partenonska skulptura metopa', '2013-06-13 03:38:11', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(123, 13, 'Dodao novi eksponat: Bočica', '2013-06-13 03:39:27', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(124, 13, 'Dodao novi eksponat: Željezna sjekira', '2013-06-13 03:40:19', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(125, 13, 'Dodao novi eksponat: Venus de Milo', '2013-06-13 03:41:36', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(126, 13, 'Dodao novi eksponat: Amor i Psiha', '2013-06-13 03:42:44', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(127, 13, 'Dodao novi eksponat: Podmornica “CB-20“', '2013-06-13 03:43:58', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(128, 13, 'Dodao novi eksponat: Melancholia, an engraving', '2013-06-13 03:45:20', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(129, 13, 'Uredio postojeći eksponat: Amor i Psiha', '2013-06-13 03:46:18', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(130, 13, 'Uredio postojeći eksponat: Anubis', '2013-06-13 03:46:49', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(131, 13, 'Uredio postojeći eksponat: Bočica', '2013-06-13 03:47:18', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(132, 13, 'Dodao novu sobu: Osma soba', '2013-06-13 03:49:27', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(133, 13, 'Uredio postojeći eksponat: Brončana figurica lovca', '2013-06-13 03:49:49', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(134, 13, 'Uredio postojeći eksponat: Brončana skulptura boga Marsa', '2013-06-13 03:50:21', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(135, 13, 'Uredio postojeći eksponat: Commodore 64', '2013-06-13 03:50:39', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(136, 13, 'Uredio postojeći eksponat: Diskobol', '2013-06-13 03:50:56', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(137, 13, 'Uredio postojeći eksponat: Etrich Taube ili Etrich II Taube', '2013-06-13 03:51:15', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(138, 13, 'Uredio postojeći eksponat: Hamurabijev zakonik', '2013-06-13 03:52:19', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(139, 13, 'Uredio postojeći eksponat: Kamena ploča iz sjevernog dijela Asurbanipalove pa', '2013-06-13 03:52:32', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(140, 13, 'Uredio postojeću sobu: Treća soba', '2013-06-13 03:52:47', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(141, 13, 'Uredio postojeći eksponat: Krik, The Scream', '2013-06-13 03:53:12', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(142, 13, 'Uredio postojeći eksponat: Kristalna lubanja', '2013-06-13 03:53:30', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(143, 13, 'Uredio postojeći eksponat: Mehanička galija', '2013-06-13 03:54:38', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(144, 13, 'Uredio postojeći eksponat: Melancholia, an engraving', '2013-06-13 03:55:11', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(145, 13, 'Uredio postojeći eksponat: Mislilac', '2013-06-13 03:55:32', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(146, 13, 'Uredio postojeći eksponat: Mozaik iz rimske vile', '2013-06-13 03:55:58', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(147, 13, 'Uredio postojeći eksponat: Partenonska skulptura metopa', '2013-06-13 03:56:13', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(148, 13, 'Uredio postojeći eksponat: Podmornica “CB-20“', '2013-06-13 03:56:24', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(149, 13, 'Uredio postojeći eksponat: Skulptura iz Dur-Untaša, Mezopotamija', '2013-06-13 03:57:02', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(150, 13, 'Uredio postojeći eksponat: Stolni sat', '2013-06-13 03:57:18', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(151, 13, 'Dodao novu sobu: Deveta soba', '2013-06-13 03:57:47', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(152, 13, 'Uredio postojeći eksponat: Venus de Milo', '2013-06-13 03:57:57', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(153, 13, 'Uredio postojeći eksponat: Željezna sjekira', '2013-06-13 03:58:21', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(154, 13, 'Uredio postojeći eksponat: Stolni sat', '2013-06-13 03:58:32', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(155, 13, 'Uredio postojeći eksponat: Brončana figurica lovca', '2013-06-13 03:59:04', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(156, 13, 'Uredio postojeći eksponat: Brončana skulptura boga Marsa', '2013-06-13 03:59:13', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(157, 13, 'Dodao novu sobu: Deseta Soba', '2013-06-13 03:59:25', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(158, 13, 'Uredio postojeći eksponat: Skulptura iz Dur-Untaša, Mezopotamija', '2013-06-13 03:59:37', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(159, 13, 'Uredio postojeći eksponat: Vučedolska golubica', '2013-06-13 03:59:45', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(160, 13, 'Uredio postojeći eksponat: Bočica', '2013-06-13 04:00:04', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(161, 13, 'Uredio postojeći eksponat: Željezna sjekira', '2013-06-13 04:00:17', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(162, 13, 'Uredio postojeći eksponat: Venus de Milo', '2013-06-13 04:00:29', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(163, 13, 'Uredio postojeću izložbu: Parne sobe', '2013-06-13 04:08:28', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(164, 13, 'Iz izložbe s nazivom "Parne sobe" uklonio sve sobe i dodao: "Četvrta soba", "Deseta Soba", "Druga soba", "Osma soba", "Šesta soba", ', '2013-06-13 04:08:28', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(165, 13, 'Stvorio novu izložbu s nazivom: Sav sadržaj muzeja', '2013-06-13 04:09:02', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(166, 13, 'U izložbu s nazivom "Sav sadržaj muzeja" dodao odjele: "Arheološki", "Galerije", "Tehnički", ', '2013-06-13 04:09:03', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(167, 13, 'Stvorio novu izložbu s nazivom: Neparne sobe', '2013-06-13 04:09:49', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(168, 13, 'U izložbu s nazivom "Neparne sobe" dodao sobe: "Deveta soba", "Peta soba", "Prva soba", "Sedma soba", "Treća soba", ', '2013-06-13 04:09:49', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(169, 13, 'Stvorio novu izložbu s nazivom: Tehnički odjel', '2013-06-13 04:10:19', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(170, 13, 'U izložbu s nazivom "Tehnički odjel" dodao odjele: "Tehnički", ', '2013-06-13 04:10:19', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(171, 13, 'Stvorio novu izložbu s nazivom: Galerije', '2013-06-13 04:10:52', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(172, 13, 'U izložbu s nazivom "Galerije" dodao odjele: "Galerije", ', '2013-06-13 04:10:52', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(173, 13, 'Stvorio novu izložbu s nazivom: Arheološki odjel', '2013-06-13 04:11:16', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(174, 13, 'U izložbu s nazivom "Arheološki odjel" dodao odjele: "Arheološki", ', '2013-06-13 04:11:16', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(175, 13, 'Stvorio novu izložbu s nazivom: Prvih pet soba', '2013-06-13 04:12:29', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(176, 13, 'U izložbu s nazivom "Prvih pet soba" dodao sobe: "Četvrta soba", "Druga soba", "Peta soba", "Prva soba", "Treća soba", ', '2013-06-13 04:12:30', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(177, 13, 'Stvorio novu izložbu s nazivom: Drugih pet soba', '2013-06-13 04:12:57', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(178, 13, 'U izložbu s nazivom "Drugih pet soba" dodao sobe: "Deseta Soba", "Deveta soba", "Osma soba", "Sedma soba", "Šesta soba", ', '2013-06-13 04:12:57', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(179, 13, 'Stvorio novu izložbu s nazivom: Odabrani eksponati ', '2013-06-13 04:13:57', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(180, 13, 'U izložbu s nazivom "Odabrani eksponati " dodao eksponate: "Anubis", "Istočnogotska fibula", "Mehanička galija", "Mislilac", "Mona Lisa", "Podmornica “CB-20“", "Stolni sat", "Tablica jednadžbi", "Venus de Milo", "Vučedolska golubica", ', '2013-06-13 04:13:58', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(181, 13, 'Stvorio novu izložbu s nazivom: Odabrani eksponati (drugi dio)', '2013-06-13 04:14:42', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(182, 13, 'U izložbu s nazivom "Odabrani eksponati (drugi dio)" dodao eksponate: "Amor i Psiha", "Anubis", "Bašćanska ploča", "Bočica", "Commodore 64", "Diskobol", "Krik, The Scream", "Kristalna lubanja", "Radnitzky spomen medalja", "Željezna sjekira", ', '2013-06-13 04:14:43', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(183, 13, 'Odjava sa sustava (korisnik: admin)', '2013-06-13 04:44:20', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(184, NULL, 'Odjava sa sustava (korisnik: )', '2013-06-13 04:46:04', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(185, 14, 'Prijavio se na sustav', '2013-06-13 04:56:43', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(186, 14, 'Dodao komentar na eksponat "Brončana figurica lovca". Tekst komentara: "Komentar"', '2013-06-13 04:59:20', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(187, 14, 'Kupio ulaznicu za izložbu "Arheološki odjel"', '2013-06-13 05:01:34', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(188, 14, 'Uredio vlastite korisničke podatke', '2013-06-13 05:02:34', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(189, 14, 'Odjava sa sustava (korisnik: webdip)', '2013-06-13 05:02:53', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(190, NULL, 'Pokušao se ulogirati na korisničko ime "kustos", ali taj nije bio aktiviran', '2013-06-13 05:02:59', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(191, 36, 'Prijavio se na sustav', '2013-06-13 05:03:40', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(192, 36, 'Odjava sa sustava (korisnik: kustos)', '2013-06-13 05:03:49', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(193, 36, 'Prijavio se na sustav', '2013-06-13 05:04:07', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(194, 36, 'Odjava sa sustava (korisnik: kustos)', '2013-06-13 05:04:26', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(195, 36, 'Prijavio se na sustav', '2013-06-13 05:04:34', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(196, 36, 'Odjava sa sustava (korisnik: kustos)', '2013-06-13 05:04:43', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(197, 36, 'Prijavio se na sustav', '2013-06-13 05:05:16', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(198, 36, 'Dodao eksponat "Skulptura iz Dur-Untaša, Mezopotamija" u osobnu galeriju', '2013-06-13 05:07:26', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(199, 36, 'Odjava sa sustava (korisnik: kustos)', '2013-06-13 05:08:22', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(200, 13, 'Prijavio se na sustav', '2013-06-13 05:08:27', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(201, 13, 'Uredio korisničke podatke korisnika: pbilic', '2013-06-13 05:09:38', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(202, 13, 'Odjava sa sustava (korisnik: admin)', '2013-06-13 05:09:53', '127.0.0.1', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(203, 14, 'Odjava sa sustava (korisnik: webdip)', '2013-06-13 05:20:33', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(204, 14, 'Prijavio se na sustav', '2013-06-13 05:20:43', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(205, 14, 'Dodao eksponat "Istočnogotska fibula" u osobnu galeriju', '2013-06-13 05:28:54', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(206, 14, 'Dodao novu ocjenu (4) na eksponat (Istočnogotska fibula)', '2013-06-13 05:29:06', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(207, 14, 'Uklonio eksponat "Istočnogotska fibula" iz osobne galerije', '2013-06-13 05:29:14', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(208, 14, 'Odjava sa sustava (korisnik: webdip)', '2013-06-13 05:41:44', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(209, NULL, 'Korisnik s korisničkim imenom: domagoj (Domagoj Šitum) se registrirao na stranicu', '2013-06-13 05:47:07', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(210, NULL, 'Korisnik s korisničkim imenom: iaeomnsta (Drisemriamet Siemsniaemsianm) se registrirao na stranicu', '2013-06-13 05:51:11', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(211, 14, 'Prijavio se na sustav', '2013-06-13 05:51:31', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(212, 14, 'Dodao eksponat "Mehanička galija" u osobnu galeriju', '2013-06-13 05:51:56', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(213, 14, 'Odjava sa sustava (korisnik: webdip)', '2013-06-13 05:52:25', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(214, 13, 'Prijavio se na sustav', '2013-06-13 05:52:31', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(215, 13, 'Uredio postojeću izložbu: Arheološki odjel', '2013-06-13 15:57:26', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(216, 13, 'Iz izložbe s nazivom "Arheološki odjel" uklonio sve odjele i dodao: "Arheološki", ', '2013-06-13 15:57:26', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(217, 13, 'Stvorio novu izložbu s nazivom: tt', '2013-06-13 15:58:04', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(218, 13, 'U izložbu s nazivom "tt" dodao eksponate: "Amor i Psiha", ', '2013-06-13 15:58:04', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(219, 13, 'Obrisao izložbu s nazivom: tt', '2013-06-13 15:58:09', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(220, 13, 'Uredio postojeći eksponat: Istočnogotska fibula', '2013-06-13 15:59:10', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(221, 13, 'Uredio postojeći eksponat: Istočnogotska fibul', '2013-06-13 15:59:29', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(222, 13, 'Uredio postojeći eksponat: Istočnogotska fibula', '2013-06-13 15:59:40', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(223, 13, 'Dodao novi odjel: rim', '2013-06-13 16:00:13', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(224, 13, 'Obrisao odjel s nazivom: rim', '2013-06-13 16:00:16', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(225, 13, 'Dodao novu sobu: riemrem', '2013-06-13 16:00:19', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(226, 13, 'Obrisao sobu s nazivom: riemrem', '2013-06-13 16:00:24', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(227, 13, 'Dodao novi eksponat: remr', '2013-06-13 16:00:50', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(228, 13, 'Obrisao eksponat s nazivom: remr', '2013-06-13 16:00:57', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(229, 13, 'Odjava sa sustava (korisnik: admin)', '2013-06-13 16:15:00', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(230, 4, 'Prijavio se na sustav', '2013-06-13 16:15:12', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(231, 4, 'Odjava sa sustava (korisnik: atomas)', '2013-06-13 16:15:20', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(232, 13, 'Prijavio se na sustav', '2013-06-13 16:15:30', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(233, 13, 'Prijavio se na sustav', '2013-06-13 16:15:55', '193.198.27.60', 'Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.15'),
(234, 13, 'Prijavio se na sustav', '2013-06-13 16:16:28', '193.198.27.60', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(235, 13, 'Odjava sa sustava (korisnik: admin)', '2013-06-13 16:19:22', '193.198.27.60', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(236, 14, 'Prijavio se na sustav', '2013-06-13 16:21:34', '193.198.27.60', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(237, 14, 'Kupio suvenire: Kalendar s uzorkom bašćanske ploče (3 kom), ', '2013-06-13 16:22:15', '193.198.27.60', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(238, 14, 'Kupio ulaznicu za izložbu "Galerije"', '2013-06-13 16:37:58', '193.198.27.60', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(239, 14, 'Kupio ulaznicu za izložbu "Odabrani eksponati "', '2013-06-13 16:39:48', '193.198.27.60', 'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(240, 13, 'Prijavio se na sustav', '2013-06-13 18:20:28', '161.53.120.107', 'Opera/9.80 (Windows NT 6.1; WOW64) Presto/2.12.388 Version/12.15'),
(241, 13, 'Odjava sa sustava (korisnik: admin)', '2013-06-13 18:20:40', '161.53.120.107', 'Opera/9.80 (Windows NT 6.1; WOW64) Presto/2.12.388 Version/12.15'),
(242, 13, 'Prijavio se na sustav', '2013-06-13 18:32:50', '161.53.120.107', 'Opera/9.80 (Windows NT 6.1; WOW64) Presto/2.12.388 Version/12.15'),
(243, NULL, 'Korisnik s korisničkim imenom: blanka (Blanka Vlašić) se registrirao na stranicu', '2013-06-13 18:35:38', '161.53.120.107', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(244, 13, 'Pokušao aktivirati korisnički račun kojem je vrijeme za aktivaciju isteklo (korisničko ime: blanka)', '2013-06-15 08:36:23', '161.53.120.107', 'Opera/9.80 (Windows NT 6.1; WOW64) Presto/2.12.388 Version/12.15'),
(245, 13, 'Aktivirao korisnički račun (blanka)', '2013-06-13 08:38:11', '161.53.120.107', 'Opera/9.80 (Windows NT 6.1; WOW64) Presto/2.12.388 Version/12.15'),
(246, 41, 'Prijavio se na sustav', '2013-06-13 08:38:24', '161.53.120.107', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(247, 41, 'Odjava sa sustava (korisnik: blanka)', '2013-06-13 08:40:15', '161.53.120.107', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(248, NULL, 'Pokušao se prijaviti u sustav s krivim korisničkim podacima (upisano korisničko ime: blanka). Pokušaj prijave: 1', '2013-06-13 08:40:32', '161.53.120.107', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(249, NULL, 'Pokušao se prijaviti u sustav s krivim korisničkim podacima (upisano korisničko ime: blanka). Pokušaj prijave: 2', '2013-06-13 08:40:37', '161.53.120.107', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(250, NULL, 'Pokušao se prijaviti u sustav s krivim korisničkim podacima (upisano korisničko ime: blanka). Pokušaj prijave: 3', '2013-06-13 08:40:51', '161.53.120.107', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(251, NULL, 'Pokušao se prijaviti tri puta s krivim korisničkim podacima (upisano korisničko ime: blanka) - korisnički račun zaključan!', '2013-06-13 08:40:51', '161.53.120.107', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(252, NULL, 'Pokušao se ulogirati na korisničko ime "blanka", ali je taj korisnički račun zaključan', '2013-06-13 08:40:58', '161.53.120.107', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(253, 13, 'Uredio korisničke podatke korisnika: blanka', '2013-06-13 08:41:18', '161.53.120.107', 'Opera/9.80 (Windows NT 6.1; WOW64) Presto/2.12.388 Version/12.15'),
(254, 41, 'Prijavio se na sustav', '2013-06-13 08:41:26', '161.53.120.107', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(255, 41, 'Odjava sa sustava (korisnik: blanka)', '2013-06-13 08:41:30', '161.53.120.107', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(256, 41, 'Prijavio se na sustav', '2013-06-13 08:41:40', '161.53.120.107', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(257, 36, 'Prijavio se na sustav', '2013-06-13 08:42:54', '161.53.120.107', 'Opera/9.80 (Windows NT 6.1; WOW64) Presto/2.12.388 Version/12.15'),
(258, 36, 'Dodao novi odjel: Knjižnica', '2013-06-13 08:43:38', '161.53.120.107', 'Opera/9.80 (Windows NT 6.1; WOW64) Presto/2.12.388 Version/12.15'),
(259, 36, 'Dodao novu sobu: Biblije', '2013-06-13 08:44:03', '161.53.120.107', 'Opera/9.80 (Windows NT 6.1; WOW64) Presto/2.12.388 Version/12.15'),
(260, 36, 'Dodao novi eksponat: Prva hrvatska biblija', '2013-06-13 08:45:56', '161.53.120.107', 'Opera/9.80 (Windows NT 6.1; WOW64) Presto/2.12.388 Version/12.15'),
(261, 41, 'Dodao komentar na eksponat "Prva hrvatska biblija". Tekst komentara: "Jako lijepa knjiga"', '2013-06-13 08:47:24', '161.53.120.107', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(262, 41, 'Dodao komentar na eksponat "Prva hrvatska biblija". Tekst komentara: "Ovo je moj drugi komentar"', '2013-06-13 08:47:40', '161.53.120.107', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31'),
(263, 36, 'Stvorio novu izložbu s nazivom: Biblije SZ Hrvatske', '2013-06-13 08:52:50', '161.53.120.107', 'Opera/9.80 (Windows NT 6.1; WOW64) Presto/2.12.388 Version/12.15'),
(264, 36, 'U izložbu s nazivom "Biblije SZ Hrvatske" dodao odjele: "Knjižnica", ', '2013-06-13 08:52:50', '161.53.120.107', 'Opera/9.80 (Windows NT 6.1; WOW64) Presto/2.12.388 Version/12.15'),
(265, 41, 'Dodao novu ocjenu (4) na eksponat (Prva hrvatska biblija)', '2013-06-13 08:55:54', '161.53.120.107', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31');

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `ocjene`
--

CREATE TABLE IF NOT EXISTS `ocjene` (
  `korisnik` int(11) NOT NULL,
  `eksponat` int(11) NOT NULL,
  `ocjena` smallint(5) unsigned NOT NULL,
  `datumOcjenjivanja` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`korisnik`,`eksponat`),
  KEY `fk_svidjanja_korisnici1_idx` (`korisnik`),
  KEY `fk_svidjanja_eksponati1_idx` (`eksponat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Izbacivanje podataka za tablicu `ocjene`
--

INSERT INTO `ocjene` (`korisnik`, `eksponat`, `ocjena`, `datumOcjenjivanja`) VALUES
(3, 1, 5, '2013-06-02 18:16:30'),
(3, 2, 3, '2013-06-13 04:03:57'),
(3, 3, 2, '2013-06-04 22:48:39'),
(3, 6, 4, '2013-06-13 03:59:41'),
(3, 21, 2, '2013-06-13 04:28:08'),
(3, 30, 4, '2013-06-13 04:28:08'),
(4, 1, 4, '2013-06-02 19:22:17'),
(4, 22, 3, '2013-06-13 04:28:08'),
(4, 28, 3, '2013-06-13 04:28:08'),
(5, 20, 4, '2013-06-13 04:28:08'),
(5, 27, 2, '2013-06-13 04:28:08'),
(7, 19, 5, '2013-06-13 04:28:08'),
(7, 25, 5, '2013-06-13 04:28:08'),
(8, 26, 4, '2013-06-13 04:28:08'),
(8, 29, 5, '2013-06-13 04:28:30'),
(9, 16, 3, '2013-06-13 04:28:08'),
(9, 17, 5, '2013-06-13 04:28:08'),
(10, 18, 4, '2013-06-13 04:28:08'),
(11, 6, 4, '2013-06-07 15:37:38'),
(11, 23, 3, '2013-06-13 04:28:08'),
(12, 6, 1, '2013-06-07 15:37:38'),
(12, 24, 2, '2013-06-13 04:28:08'),
(13, 1, 5, '2013-06-03 02:02:29'),
(13, 2, 3, '2013-06-07 16:56:06'),
(13, 3, 4, '2013-06-09 02:12:36'),
(13, 4, 3, '2013-06-03 14:29:36'),
(13, 5, 3, '2013-06-04 04:40:44'),
(13, 6, 3, '2013-06-07 15:33:48'),
(14, 2, 4, '2013-06-12 00:25:42'),
(14, 5, 4, '2013-06-13 05:29:06'),
(14, 29, 5, '2013-06-13 04:28:08'),
(41, 32, 4, '2013-06-13 08:55:53');

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `odjeli`
--

CREATE TABLE IF NOT EXISTS `odjeli` (
  `brojOdjela` int(11) NOT NULL auto_increment,
  `nazivOdjela` varchar(45) NOT NULL,
  `opisOdjela` text NOT NULL,
  `vidljivostOdjela` tinyint(1) NOT NULL COMMENT 'Poprima 3 vrijednosti: 0 = javno; 1 = samo registrirani korisnici; 2 = privatno',
  PRIMARY KEY  (`brojOdjela`),
  UNIQUE KEY `brojDvorane_UNIQUE` (`brojOdjela`),
  UNIQUE KEY `nazivDvorane_UNIQUE` (`nazivOdjela`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Izbacivanje podataka za tablicu `odjeli`
--

INSERT INTO `odjeli` (`brojOdjela`, `nazivOdjela`, `opisOdjela`, `vidljivostOdjela`) VALUES
(1, 'Arheološki', 'Prikupljeni eksponati koji su obilježili kulturu čovječanstva mogu se pronaći na ovom odjelu', 0),
(2, 'Tehnički', 'Rukotvorine sjajnih izumitelja čije su ideje dovele do razvoja tehnologije', 0),
(3, 'Galerije', 'Umjetnička djela prepoznata diljem svijeta', 1),
(6, 'Knjižnica', 'Stare knjige...', 1);

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `osobnagalerija`
--

CREATE TABLE IF NOT EXISTS `osobnagalerija` (
  `idKorisnika` int(11) NOT NULL,
  `Eksponat` int(11) NOT NULL,
  PRIMARY KEY  (`idKorisnika`,`Eksponat`),
  KEY `fk_osobnaGalerija_korisnici1_idx` (`idKorisnika`),
  KEY `fk_osobnaGalerija_eksponati1_idx` (`Eksponat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Izbacivanje podataka za tablicu `osobnagalerija`
--

INSERT INTO `osobnagalerija` (`idKorisnika`, `Eksponat`) VALUES
(3, 1),
(3, 2),
(3, 28),
(4, 6),
(4, 12),
(4, 23),
(5, 7),
(5, 11),
(5, 24),
(7, 5),
(7, 29),
(8, 4),
(8, 30),
(9, 14),
(9, 15),
(9, 18),
(10, 13),
(10, 16),
(10, 17),
(11, 3),
(11, 19),
(11, 21),
(11, 27),
(12, 8),
(12, 22),
(12, 25),
(13, 1),
(13, 6),
(14, 9),
(14, 20),
(14, 21),
(14, 26),
(36, 14);

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `pomakVremena`
--

CREATE TABLE IF NOT EXISTS `pomakVremena` (
  `pomak` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Izbacivanje podataka za tablicu `pomakVremena`
--

INSERT INTO `pomakVremena` (`pomak`) VALUES
(0);

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `pristupeksponatima`
--

CREATE TABLE IF NOT EXISTS `pristupeksponatima` (
  `eksponat` int(11) NOT NULL,
  `izlozba` int(11) NOT NULL,
  PRIMARY KEY  (`eksponat`,`izlozba`),
  KEY `fk_pristupEksponatima_eksponati1_idx` (`eksponat`),
  KEY `fk_pristupEksponatima_kalendarIzlozbi1_idx` (`izlozba`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Izbacivanje podataka za tablicu `pristupeksponatima`
--

INSERT INTO `pristupeksponatima` (`eksponat`, `izlozba`) VALUES
(1, 15),
(4, 16),
(5, 15),
(6, 16),
(7, 15),
(8, 15),
(9, 16),
(10, 16),
(12, 16),
(15, 15),
(15, 16),
(16, 16),
(19, 15),
(20, 15),
(21, 15),
(25, 16),
(26, 16),
(27, 15),
(28, 16),
(29, 15);

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `pristupodjelima`
--

CREATE TABLE IF NOT EXISTS `pristupodjelima` (
  `odjel` int(11) NOT NULL,
  `izlozba` int(11) NOT NULL,
  PRIMARY KEY  (`odjel`,`izlozba`),
  KEY `fk_pristupOdjelima_odjeli1_idx` (`odjel`),
  KEY `fk_pristupOdjelima_kalendarIzlozbi1_idx` (`izlozba`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Izbacivanje podataka za tablicu `pristupodjelima`
--

INSERT INTO `pristupodjelima` (`odjel`, `izlozba`) VALUES
(1, 8),
(1, 12),
(2, 8),
(2, 10),
(3, 8),
(3, 11),
(6, 18);

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `pristupsobama`
--

CREATE TABLE IF NOT EXISTS `pristupsobama` (
  `soba` int(11) NOT NULL,
  `izlozba` int(11) NOT NULL,
  PRIMARY KEY  (`soba`,`izlozba`),
  KEY `fk_pristupSobama_sobe1_idx` (`soba`),
  KEY `fk_pristupSobama_kalendarIzlozbi1_idx` (`izlozba`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Izbacivanje podataka za tablicu `pristupsobama`
--

INSERT INTO `pristupsobama` (`soba`, `izlozba`) VALUES
(1, 9),
(1, 13),
(2, 1),
(2, 13),
(3, 9),
(3, 13),
(4, 1),
(4, 13),
(5, 9),
(5, 13),
(6, 1),
(6, 14),
(7, 9),
(7, 14),
(8, 1),
(8, 14),
(9, 9),
(9, 14),
(10, 1),
(10, 14);

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `sobe`
--

CREATE TABLE IF NOT EXISTS `sobe` (
  `brojSobe` int(11) NOT NULL auto_increment,
  `nazivSobe` varchar(50) NOT NULL,
  `Odjel` int(11) NOT NULL,
  `vidljivostSobe` tinyint(1) NOT NULL COMMENT 'Poprima 3 vrijednosti: 0 = javno; 1 = samo registrirani korisnici; 2 = privatno',
  PRIMARY KEY  (`brojSobe`),
  KEY `fk_sobe_odjeli1_idx` (`Odjel`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Izbacivanje podataka za tablicu `sobe`
--

INSERT INTO `sobe` (`brojSobe`, `nazivSobe`, `Odjel`, `vidljivostSobe`) VALUES
(1, 'Prva soba', 1, 0),
(2, 'Druga soba', 1, 1),
(3, 'Treća soba', 1, 1),
(4, 'Četvrta soba', 2, 0),
(5, 'Peta soba', 2, 1),
(6, 'Šesta soba', 3, 2),
(7, 'Sedma soba', 3, 0),
(8, 'Osma soba', 1, 1),
(9, 'Deveta soba', 1, 0),
(10, 'Deseta Soba', 1, 2),
(12, 'Biblije', 6, 1);

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `suveniri`
--

CREATE TABLE IF NOT EXISTS `suveniri` (
  `idSuvenira` int(11) NOT NULL auto_increment,
  `naziv` varchar(45) NOT NULL,
  `opis` text,
  `cijena` int(11) NOT NULL,
  `eksponat` int(11) NOT NULL,
  PRIMARY KEY  (`idSuvenira`),
  KEY `fk_suveniri_eksponati1_idx` (`eksponat`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Izbacivanje podataka za tablicu `suveniri`
--

INSERT INTO `suveniri` (`idSuvenira`, `naziv`, `opis`, `cijena`, `eksponat`) VALUES
(1, 'Privjesak banski denar', NULL, 25, 3),
(2, 'Replika banskog denara', '', 30, 4),
(3, 'Kalendar s uzorkom bašćanske ploče', NULL, 5, 6),
(4, 'Mona Lisa poster', 'Poster veličine 50x100', 30, 7),
(5, 'Diskobol privjesak za ključeve', NULL, 15, 9),
(6, 'Krik, The Scream Poster', 'Poster veličine 50x100', 30, 10),
(7, 'Commodore 64 Igračka', 'Igačka za djecu računala Commodore 64', 150, 12),
(8, 'Hamurabijev zakonik replika', 'Replika hamurabijevog zakonika', 150, 13),
(9, 'Kristalna lubanja', 'Privjesak za ključeve', 20, 16),
(10, 'Podmornica “CB-20“', 'Maketa podmornice CB-20 dimenzija 20x10x15', 170, 29),
(11, 'Brončana skulptura boga Marsa', 'Privjesak skulpture za ključeve', 15, 22);

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `tipkorisnika`
--

CREATE TABLE IF NOT EXISTS `tipkorisnika` (
  `brojTipa` int(11) NOT NULL auto_increment,
  `tip` varchar(45) NOT NULL,
  PRIMARY KEY  (`brojTipa`),
  UNIQUE KEY `brojTipa_UNIQUE` (`brojTipa`),
  UNIQUE KEY `tip_UNIQUE` (`tip`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Izbacivanje podataka za tablicu `tipkorisnika`
--

INSERT INTO `tipkorisnika` (`brojTipa`, `tip`) VALUES
(3, 'administrator'),
(1, 'korisnik'),
(2, 'kustos');

-- --------------------------------------------------------

--
-- Tablična struktura za tablicu `ulaznice`
--

CREATE TABLE IF NOT EXISTS `ulaznice` (
  `kupac` int(11) NOT NULL,
  `izlozba` int(11) NOT NULL,
  PRIMARY KEY  (`kupac`,`izlozba`),
  KEY `fk_ulaznice_korisnici1_idx` (`kupac`),
  KEY `fk_ulaznice_kalendar1_idx` (`izlozba`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Izbacivanje podataka za tablicu `ulaznice`
--

INSERT INTO `ulaznice` (`kupac`, `izlozba`) VALUES
(3, 1),
(3, 13),
(4, 12),
(5, 16),
(7, 15),
(8, 14),
(9, 11),
(10, 8),
(13, 1),
(14, 9),
(14, 11),
(14, 12),
(14, 15);

--
-- Ograničenja za izbačene tablice
--

--
-- Ograničenja za tablicu `eksponati`
--
ALTER TABLE `eksponati`
  ADD CONSTRAINT `eksponati_ibfk_1` FOREIGN KEY (`soba`) REFERENCES `sobe` (`brojSobe`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograničenja za tablicu `komentari`
--
ALTER TABLE `komentari`
  ADD CONSTRAINT `komentari_ibfk_3` FOREIGN KEY (`komentator`) REFERENCES `korisnici` (`idKorisnika`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `komentari_ibfk_2` FOREIGN KEY (`eksponat`) REFERENCES `eksponati` (`idEksponata`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograničenja za tablicu `korisnici`
--
ALTER TABLE `korisnici`
  ADD CONSTRAINT `fk_korisnici_tipKorisnika` FOREIGN KEY (`tipKorisnika`) REFERENCES `tipkorisnika` (`brojTipa`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ograničenja za tablicu `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `log_ibfk_1` FOREIGN KEY (`korisnik`) REFERENCES `korisnici` (`idKorisnika`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograničenja za tablicu `ocjene`
--
ALTER TABLE `ocjene`
  ADD CONSTRAINT `ocjene_ibfk_2` FOREIGN KEY (`eksponat`) REFERENCES `eksponati` (`idEksponata`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ocjene_ibfk_1` FOREIGN KEY (`korisnik`) REFERENCES `korisnici` (`idKorisnika`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograničenja za tablicu `osobnagalerija`
--
ALTER TABLE `osobnagalerija`
  ADD CONSTRAINT `osobnagalerija_ibfk_2` FOREIGN KEY (`Eksponat`) REFERENCES `eksponati` (`idEksponata`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `osobnagalerija_ibfk_1` FOREIGN KEY (`idKorisnika`) REFERENCES `korisnici` (`idKorisnika`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograničenja za tablicu `pristupeksponatima`
--
ALTER TABLE `pristupeksponatima`
  ADD CONSTRAINT `pristupeksponatima_ibfk_2` FOREIGN KEY (`izlozba`) REFERENCES `kalendarizlozbi` (`brojIzlozbe`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pristupeksponatima_ibfk_1` FOREIGN KEY (`eksponat`) REFERENCES `eksponati` (`idEksponata`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograničenja za tablicu `pristupodjelima`
--
ALTER TABLE `pristupodjelima`
  ADD CONSTRAINT `pristupodjelima_ibfk_2` FOREIGN KEY (`izlozba`) REFERENCES `kalendarizlozbi` (`brojIzlozbe`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pristupodjelima_ibfk_1` FOREIGN KEY (`odjel`) REFERENCES `odjeli` (`brojOdjela`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograničenja za tablicu `pristupsobama`
--
ALTER TABLE `pristupsobama`
  ADD CONSTRAINT `pristupsobama_ibfk_2` FOREIGN KEY (`izlozba`) REFERENCES `kalendarizlozbi` (`brojIzlozbe`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pristupsobama_ibfk_1` FOREIGN KEY (`soba`) REFERENCES `sobe` (`brojSobe`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograničenja za tablicu `sobe`
--
ALTER TABLE `sobe`
  ADD CONSTRAINT `sobe_ibfk_1` FOREIGN KEY (`Odjel`) REFERENCES `odjeli` (`brojOdjela`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograničenja za tablicu `suveniri`
--
ALTER TABLE `suveniri`
  ADD CONSTRAINT `suveniri_ibfk_1` FOREIGN KEY (`eksponat`) REFERENCES `eksponati` (`idEksponata`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ograničenja za tablicu `ulaznice`
--
ALTER TABLE `ulaznice`
  ADD CONSTRAINT `ulaznice_ibfk_1` FOREIGN KEY (`kupac`) REFERENCES `korisnici` (`idKorisnika`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ulaznice_ibfk_2` FOREIGN KEY (`izlozba`) REFERENCES `kalendarizlozbi` (`brojIzlozbe`) ON DELETE CASCADE ON UPDATE CASCADE;
