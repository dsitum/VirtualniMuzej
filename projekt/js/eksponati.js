function jSuccessBox(poruka) {
    jSuccess(poruka,
    {
            HorizontalPosition : 'center',
            VerticalPosition : 'top'
    });
}

function jErrorBox(poruka) {
    jError(poruka,
    {
            HorizontalPosition : 'center',
            VerticalPosition : 'center',
            TimeShown : 2000
    });
}

function Pocetna(idEksponata, ajaxPhpDir, IDDivaSaSadrzajem, jRatingDir) {
	//postavljamo početnu korisnikovu ocjenu (ukoliko postoji)
	$.get(ajaxPhpDir,
	{
		action : 'KorisnikovaOcjenaEksponata',
		eksponat: $('.ProsjecnaOcjena.s' + idEksponata).attr('data-id')
	},
	function(data) {
		var ocjena = parseInt($(data).find('KorisnikovaOcjenaEksponata').text()) / 100;
		if (ocjena !== 0)    //ako je korisnik glasao, ocjenu ćemo ispisati
			$('.KorisnikovaOcjena.s' + idEksponata).html('<b>Vaša ocjena: </b>' + ocjena).after('<br>');
	});


	//dohvaćamo prosječnu ocjenu eksponata
	$.get(ajaxPhpDir, 
	{
		action : 'ProsjecnaOcjenaEksponata',
		eksponat : $('.ProsjecnaOcjena.s' + idEksponata).attr('data-id')
	}, 
	function(data) {
		var ocjena = parseInt($(data).find('ProsjecnaOcjenaEksponata').text());
		$('.ProsjecnaOcjena.s' + idEksponata).attr('data-average',ocjena);

                
                //ako korisnik nije ulogiran, isključujemo ocjenjivanje sadržaja
                var isDisabled = true;
                $.get(ajaxPhpDir, {
                    action: 'DohvatiTipKorisnika'
                }, function(data) {
                    var tipKorisnika = $(data).find('tipKorisnika').text();
                    if (tipKorisnika >= 1)
                        isDisabled = false;
                    
                    //nakon što su postavljeni svi parametri (dohvaćena prosječna ocjena), možemo ispisati zvjezdice na ekran
                    $('.ProsjecnaOcjena.s' + idEksponata).jRating({
                            step:true,
                            rateMax:500,
                            showRateInfo:false,
                            bigStarsPath : jRatingDir + 'icons/stars.png',
                            smallStarsPath : jRatingDir + 'icons/small.png',
                            phpPath : jRatingDir + 'php/jRating.php',
                            isDisabled: isDisabled,
                            onSuccess : function() {
                                    //kada korisnik glasa
                                    jSuccessBox('Vaša ocjena je pohranjena.');

                                    //kada korisnik glasa, još ćemo update-at njegovu ocjenu na ekran
                                    $.get(ajaxPhpDir,
                                    {
                                            action : 'KorisnikovaOcjenaEksponata',
                                            eksponat: $('.ProsjecnaOcjena.s' + idEksponata).attr('data-id')
                                    },
                                    function(data) {
                                            var ocjena = parseInt($(data).find('KorisnikovaOcjenaEksponata').text()) / 100;
                                            $('.KorisnikovaOcjena.s' + idEksponata).html('<b>Vaša ocjena: </b>' + ocjena + '<br>').after('<br>');
                                    });

                            }
                    });
                });
                
	});




	//dohvaćamo broj komentara
	$.get(ajaxPhpDir,
	{
		action : 'BrojKomentaraEksponata',
		//iz atributa o prosječnoj ocjeni možemo dohvatiti ID eksponata
		eksponat : $('.ProsjecnaOcjena.s' + idEksponata).attr('data-id')
	},
	function(data) {
		var brojKomentara = $(data).find('BrojKomentaraEksponata').text();
		$('.BrojKomentara.s' + idEksponata).html('<a class="BrojKomentaraLink s' + idEksponata + '" href="#">' + brojKomentara + ' Komentara</a>');


		//stvaramo dijalog s komentarima i prikazujemo komentare u njemu
		$('.BrojKomentaraLink.s' + idEksponata).on('click', function() {
			IspisiKomentare();
			function IspisiKomentare() {
				//najprije dohvaćamo komentare
				var komentari = "";
				$.get(ajaxPhpDir,
				{
					action : 'DohvatiKomentareEksponata',
					eksponat : $('.ProsjecnaOcjena.s' + idEksponata).attr('data-id')
				},
				function(data) {
					var naslov = new Array();
					var tekst = new Array();
					var datum = new Array();
					var korisnik = new Array();

					$(data).find('nazivKomentara').each(function(i) { naslov[i] = $(this).text(); });
					$(data).find('tekstKomentara').each(function(i) { tekst[i] = $(this).text(); });
					$(data).find('datumKomentiranja').each(function(i) { datum[i] = $(this).text(); });
					$(data).find('korime').each(function(i) { korisnik[i] = $(this).text(); });

					///popunjavamo varijablu komentari s komentarima i ostalim informacijama
					komentari += '<table class="TablicaSKomentarima s' + idEksponata + '">';
					komentari += '<thead><th></th></thead><tbody>';

					//uzimamo duljinu bilo kojeg od 4 polja (naslov, tekst, datum, korisnik) jer su im duljine iste
					var duljina = naslov.length;     
					for (j=0; j<duljina; j++) {
						komentari += '<tr><td>';
						komentari += '<table>';
						komentari += '<tr>';
							komentari += '<td width="25%">';
							komentari += 'Korisnik: <b>' + korisnik[j] + '</b>';
							komentari += '</td><td>';
							komentari += 'Naslov: <b>' + naslov[j] + '</b>';
						komentari += '</tr><tr>';
							komentari += '<td>';
							komentari += 'Datum: ' + datum[j];
							komentari += '</td><td>';
							komentari += tekst[j];
						komentari += '</tr>';
						komentari += '</table> <br>';
						komentari += '</td></tr>';
					}                           

					komentari += '</tbody></table>';


					/*
					 * Ispod svih komentara dodamo obrazac 
					 * za unos novog korisničkog komentara
					 */
					//ako je ispisan barem jedan komentar (tj. dohvaćen iz baze), postavit ćemo 2 nova retka i horizontalnu liniju, da napravimo razmak između postojećih komentara i ovog obrasca
					if (duljina > 0)
						komentari += '<br><br><hr>';


                                        $.get(ajaxPhpDir, {
                                            action: 'DohvatiTipKorisnika'
                                        }, function(data) {
                                            var tipKorisnika = $(data).find('tipKorisnika').text();
                                            
                                            if (tipKorisnika > 0) {
                                                komentari += '<table><tr><td>';
                                                komentari += 'Dodaj komentar: <br>';
                                                komentari += '</td></tr><tr><td>';
                                                komentari += '<input type="text" class="NaslovKomentara s' + idEksponata + '"\n\
                                                                                placeholder="Naslov komentara" size="20">';
                                                komentari += '</td></tr><tr><td>';
                                                komentari += '<textarea name="zivotopis" class="TekstKomentara s' + idEksponata + '"\n\
                                                                                placeholder="Tekst komentara" rows="5" cols="30"></textarea>';
                                                komentari += '</td></tr><tr><td>';
                                                komentari += '<button class="PosaljiKomentar s' + idEksponata + '">Komentiraj</button>';
                                                komentari += '</td></tr></table>';
                                            }
                                            
                                            /*
                                            * i na kraju popunjenu varijablu 'komentari' 
                                            * (koja sadrži sve informacije o svim kometarima u obliku tablice) 
                                            * prikazujemo u dialog box-u
                                            */
                                           UnesiUDialog(komentari);
                                           
                                           /*
                                            * Nakon što smo prikazali komentare i obrazac za komentiranje,
                                            * trebamo korisniku omogućiti da pošalje komentar 
                                            * (unos komentara u bazu podataka)
                                            */
                                           $('.PosaljiKomentar.s' + idEksponata).on('click', function() {
                                               var tekst = $('.TekstKomentara.s' + idEksponata).val();
                                               //ako nije unesen tekst komentara, obavještavamo korisnika
                                               if (tekst == '') {
                                                   jErrorBox('Niste unijeli tekst komentara');
                                               } else {
                                                   //ako tekst komentara JEST unešen, unosimo komentar u bazu
                                                   $.get(ajaxPhpDir, {
                                                           action : 'UnosKomentaraEksponataUBazu',
                                                           eksponat : $('.ProsjecnaOcjena.s' + idEksponata).attr('data-id'),
                                                           NaslovKomentara : $(".NaslovKomentara.s"+idEksponata).val(),
                                                           TekstKomentara : $('.TekstKomentara.s' + idEksponata).val()
                                                   },
                                                   function() {
                                                           //obavještavamo korisnika da je njegov komentar zabilježen
                                                           jSuccessBox('Komentar zabilježen');
                                                           //praznimo prozor od dosadašnjih komentara
                                                           UnesiUDialog('');
                                                           //osvježavamo postojeću listu komentara
                                                           IspisiKomentare();
                                                   });
                                               }
                                           });
                                        });


					function UnesiUDialog(komentari) {
						$('.ProzorSKomentarima.s' + idEksponata).html(komentari);
						$('.ProzorSKomentarima.s' + idEksponata).dialog({
							show : 'puff',
							hide : 'puff',
							modal : true,
							height : 400,
							width : 800,
							resizable : false,
							title : 'Komentari'
						});
						//tablice prikazujemo u ljepšem prikazu koristeći datatables plugin. Isključujemo sortiranje komentara!
						$('.TablicaSKomentarima.s' + idEksponata).dataTable({
							bSort : false
						});


					}

					
				}); 
			}
		});
	});
	


	/*
	* Korisnikova osobna galerija
	*/
	OsobnaGalerija();
	function OsobnaGalerija() {
		$.get(ajaxPhpDir, {
			action : 'JeLiEksponatUOsobnojGaleriji',
			eksponat : $('.ProsjecnaOcjena.s' + idEksponata).attr('data-id')
		},
		function (data) {
			//dohvaćamo podatak iz xml-a o tome je li eksponat već u korisnikovoj osobnoj galeriji
			var uGaleriji = $(data).find('eksponat').text();

			//ako eksponat jest u galeriji
			if(uGaleriji == 1)
				$('.OsobnaGalerija.s' + idEksponata).html('<a class="OsobnaGalerijaDodajUkloni s' + idEksponata + '" data-id="ukloni" href="#">Ukloni iz osobne galerije</a>');
			else
				$('.OsobnaGalerija.s' + idEksponata).html('<a class="OsobnaGalerijaDodajUkloni s' + idEksponata + '" data-id="dodaj" href="#">Dodaj u osobnu galeriju</a>');


			$('.OsobnaGalerijaDodajUkloni.s' + idEksponata).on('click', function() {
				$.get(ajaxPhpDir, {
					action : 'DodajUkloniIzOsobneGalerije',
					eksponat : $('.ProsjecnaOcjena.s' + idEksponata).attr('data-id'),
					//šaljemo još jedan parametar koji će specificirati radi li se o dodavanju eksponata u korisnikovu galeriju ili uklanjanju
					dodajUkloni : $('.OsobnaGalerijaDodajUkloni.s' + idEksponata).attr('data-id')
				}, function() {
					//nakon što se eksponat u galeriju doda ili ukloni iz nje, update-at će se link i ispisati odgovarajuća poruka
					var dodajUkloni = $('.OsobnaGalerijaDodajUkloni.s' + idEksponata).attr('data-id');

					//ako smo eksponat upravo dodali u bazu, ispisujemo poruku i update-amo link
					if (dodajUkloni == 'dodaj') {
						jSuccessBox('Eksponat dodan u osobnu galeriju.');
						OsobnaGalerija();
					} 
                                        //ako smo upravo uklonili iz baze
					else if (dodajUkloni == 'ukloni') {
						jSuccessBox('Eksponat uklonjen iz osobne galerije.');
						
						//ako smo u osobnoj galeriji, sakrit ćemo eksponat kojeg uklanjamo iz nje. U suprotnom, osvježavamo stranicu
						var osobnaGalerija = $('#'+IDDivaSaSadrzajem).hasClass('osobnaGalerija');
						if (osobnaGalerija == true) {
							var eksponat = $('.OsobnaGalerija.s' + idEksponata).parent().parent().fadeOut();
							//tek za 400 milisekundi uklanjamo eksponat jer u suprotnom fadeout animacija ne bi bila vidljiva
							setTimeout(function() { $(eksponat).remove(); }, 400);
						} else {
							OsobnaGalerija();
						}
					}
				});
			});
		});
	}
        
        //implementiramo radnje vezane za košaricu (evente i sl.). Tijelo funkcije u datoteci kosarica_lib.js
        //i to SAMO AKO stranica koja poziva ovu skriptu nije najpopularnije.php
        var url = window.location.pathname;
        var filename = url.substring(url.lastIndexOf('/')+1);
        
        if (filename != 'najpopularnije.php') {
            DodajKosaricu(idEksponata);
        }
}

function IzbrojEksponate(ajaxPhpDir, IDDivaSaSadrzajem, jRatingDir, jPagesItemsPerPage) {
    /* 
     * budući da se odjednom na stranici može prikazivati više eksponata, potrebno ih je razlikovati
     * Eksponate možemo razlikovati po ID-u, koji je prije početka izvršavanja javascripta
     * bio skriven u atributu 'data-id'
     */
    var eksponat = new Array;
    $('.ProsjecnaOcjena').each(function(i){ eksponat[i] = $(this).attr('data-id'); });


    for (i=0; i<eksponat.length; i++)
       Pocetna(eksponat[i], ajaxPhpDir, IDDivaSaSadrzajem, jRatingDir);

    /*
     * Dodajemo straničenje na eksponate
     */
    $('#stranice').jPages({
            containerID : IDDivaSaSadrzajem,
            perPage : jPagesItemsPerPage,
            animation : 'fadeInDown',
            previous : 'Prethodna',
            next : 'Sljedeća'
    });
}


$(document).ready(function() {
        /*
         * prvi argument: ajaxPhpDir. Putanja do ajax.php datoteke od datoteke koja koristi ovu skriptu
         * drugi argument: IDDivaSaSadrzajem. ID glavnog diva koji obuhvaća sadržaje (eksponate ili sobe ili odjele)
         * treći argument: jRatingDir. Putanja do direktorija jRating plugina, od datoteke koja koristi ovu skriptu 
         *      Mora biti sa slashom na kraju!!
         * četvrti argument: jPagesItemsPerPage. Koliko će jPages eksponata/soba/odjela prikazivati po stranici
         */
        
        //Ova se funkcija poziva SAMO ako ako ovu javascript datoteku poziva datoteka s imenom eksponati.php
        var url = window.location.pathname;
        var filename = url.substring(url.lastIndexOf('/')+1);
        
        if (filename == 'eksponati.php') {
                IzbrojEksponate('ajax.php','eksponati', '../js/jRating/', 3);
                //dodajemo evente na postojeće suvenire u sesiji. Ova funkcija se nalazi u "kosarica_lib.js"
                DodajEventeNaPostojeceSuvenireUSesiji();
                DodajEventZaGumbKupi();
        }
});