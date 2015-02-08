$(document).ready(function() {
    /*
     * Osnovne funkcije koje podržavaju funkcionalnost
     */
    function IspisiEksponate(posjecenostOcjena) {
        //na stranicu umećemo novi sadržaj (eksponate)
        $.get('php/ajax.php', {
            action : function() {
                if (posjecenostOcjena == 'posjecenost')
                    return 'DohvatiNajpopularnijeEksponatePoPosjecenosti';
                else if (posjecenostOcjena == 'ocjena')
                    return 'DohvatiNajpopularnijeEksponatePoOcjeni';
            }
        }, function(data) {            
            //najprije praznimo stranicu od postojećih sadržaja
            //mogao sam koristiti samo $('#sadrzaji').html(''), ali nisam jer prikaz ne bude 100% koretkan
            $('div').remove('#sadrzaji');
            $('#stranice').after('<div id="sadrzaji"></div>');
            
            //za svaki pronađeni eksponat iz xml-a
            $(data).find('eksponat').each(function () {
                //najprije za svaki eksponat stvaramo div i dodajemo svakom divu klasu s pripadajućim ID-em eksponata, kako bi te klase mogli razlikovati
                var idEksponata = $(this).find('idEksponata').text();
                $('#sadrzaji').append('<div class="okvir s' + idEksponata + '"></div>');
                $('.okvir.s'+idEksponata).append('<div class="podaciOEksponatu"></div>');
                $('.okvir.s'+idEksponata).append('<div class="slikaEksponata"></div>');
                
                //za svaki pronađeni eksponat uzimamo redom njegova svojstva i ispisujemo ih
                var naziv = $(this).find('naziv').text();
                
                $('.s'+idEksponata+' .podaciOEksponatu').append('<span class="naslov">' + naziv + '</span> <br><br>');
                
                //ako je korisnik kustos ili administrator, dodajemo gumbe za brisanje i uređivanje eksponata
                var tipKorisnika = 0;
                $.get('php/ajax.php', {
                    action: 'DohvatiTipKorisnika'
                }, function(data) {
                    tipKorisnika = $(data).find('tipKorisnika').text();
                    if (tipKorisnika >= 2) {
                        $('.s'+idEksponata+' .podaciOEksponatu .naslov').after(' <a href="php/uredi_sadrzaj.php?sadrzaj=eksponat&action=uredi&idEksponata=' + idEksponata + '"><img style="bottom: 15px;" src="images/sadrzajMuzeja/uredi.png" alt="Uredi eksponat"></a> <a href="php/uredi_sadrzaj.php?sadrzaj=eksponat&action=obrisi&idEksponata=' + idEksponata + '"><img style="bottom: 15px;" src="images/sadrzajMuzeja/obrisi.png" alt="Obriši eksponat"></a>');
                    }
                });
                
                var godinaPorijekla = $(this).find('godinaPorijekla').text();
                if (godinaPorijekla != '') {
                    $('.s'+idEksponata+' .podaciOEksponatu').append('<b>Godina porijekla:</b> ' + godinaPorijekla);
               
                    var prijeKrista = $(this).find('prijeKrista').text();
                    if (prijeKrista == 1)
                        $('.s'+idEksponata+' .podaciOEksponatu').append(' pr. Kr.');
                    
                    $('.s'+idEksponata+' .podaciOEksponatu').append('<br>');
                }
                
                var opisEksponata = $(this).find('opisEksponata').text();
                $('.s'+idEksponata+' .podaciOEksponatu').append('<b>Opis eksponata:</b> ' + opisEksponata + '<br>');
                
                var OAutoru = $(this).find('OAutoru').text();
                if (OAutoru != '')
                    $('.s'+idEksponata+' .podaciOEksponatu').append('<b>Više o autoru:</b> <br> <a href="' + OAutoru + '" target="_blank">' + OAutoru + '</a> <br>');
                
                var Orazdoblju = $(this).find('Orazdoblju').text();
                if (Orazdoblju != '')
                    $('.s'+idEksponata+' .podaciOEksponatu').append('<b>Više o razdoblju:</b> <br> <a href="' + Orazdoblju + '" target="_blank">' + Orazdoblju + '</a> <br>');

                
                $('.s'+idEksponata+' .podaciOEksponatu').append('<br>');
                $('.s'+idEksponata+' .podaciOEksponatu').append('<b>Ocjena:</b> <div class="ProsjecnaOcjena s' + idEksponata + '" data-average="" data-id="' + idEksponata + '"></div>');
                $('.s'+idEksponata+' .podaciOEksponatu').append('<div class="KorisnikovaOcjena s' + idEksponata + '"></div>');
                
                var kljucneRijeci = new Array();
                $(this).find('kljucnaRijec').each(function(i) {
                    kljucneRijeci[i] = $(this).text();
                });
                
                if (kljucneRijeci[0] != '') {
                    $('.s'+idEksponata+' .podaciOEksponatu').append('<b>Ključne riječi:</b> ');
                    for (i=0; i< kljucneRijeci.length; i++) {
                        $('.s'+idEksponata+' .podaciOEksponatu').append('<a href="eksponati.php?kljucnaRijec=' + kljucneRijeci[i] + '">' + kljucneRijeci[i] + '</a> ');
                    }
                    $('.s'+idEksponata+' .podaciOEksponatu').append('<br>');
                }
                
                var brojPregleda = $(this).find('brojPregleda').text();
                $('.s'+idEksponata+' .podaciOEksponatu').append('<b>Broj pregleda:</b> ' + brojPregleda);
                $('.s'+idEksponata+' .podaciOEksponatu').append('<div class="BrojKomentara s' + idEksponata + '"></div>');
                $('.s'+idEksponata+' .podaciOEksponatu').append('<div class="ProzorSKomentarima s' + idEksponata + '"></div> <br>');
                $('.s'+idEksponata+' .podaciOEksponatu').append('<div class="OsobnaGalerija s' + idEksponata + '"></div>');
                
                var slika = $(this).find('slika').text();
                $('.s'+idEksponata+' .slikaEksponata').append('<a href="slike/' + slika + '" class="highslide" onclick="return hs.expand(this)"><img src="slike/thumbs/' + slika + '" alt="eksponat"></a>');
                
                //implementiramo radnje vezane za košaricu (evente i sl.). Tijelo funkcije u datoteci kosarica_lib.js
                DodajKosaricu(idEksponata);
            });
            //pozivamo funkciju koja prikazuje komentare, ocjenu, itd korištenjem AJAX-a
            IzbrojEksponate('php/ajax.php','sadrzaji', 'js/jRating/', 3);
        });
    }
    
    
    
    function IspisiSobe(posjecenostOcjena) {
        //na stranicu umećemo novi sadržaj (sobe)
        $.get('php/ajax.php', {
            action : 'DohvatiNajpopularnijeSobe',
            sort : posjecenostOcjena
        }, function(data) {
            //najprije praznimo stranicu od postojećih sadržaja
            //mogao sam koristiti samo $('#sadrzaji').html(''), ali nisam jer prikaz ne bude 100% koretkan
            $('div').remove('#sadrzaji');
            $('#stranice').after('<div id="sadrzaji"></div>');
        
            //za svaku pronađenu sobu iz xml-a
            $(data).find('soba').each(function () {
                //najprije za svaku sobu stvaramo div i dodajemo svakom divu klasu s pripadajućim ID-em sobe, kako bi te klase mogli razlikovati
                var brojSobe = $(this).find('brojSobe').text();
                var nazivSobe = $(this).find('nazivSobe').text();
                $('#sadrzaji').append('<div class="okvir s' + brojSobe + '"></div>');
                
                //za svaki pronađeni eksponat uzimamo redom njegova svojstva i ispisujemo ih
                $('.s'+brojSobe).append('<span class="naslov">' + nazivSobe + '</span> <br><br>');
                
                //ako je korisnik kustos ili administrator, dodajemo gumbe za brisanje i uređivanje sobe
                var tipKorisnika = 0;
                $.get('php/ajax.php', {
                    action: 'DohvatiTipKorisnika'
                }, function(data) {
                    tipKorisnika = $(data).find('tipKorisnika').text();
                    if (tipKorisnika >= 2) {
                        $('.s'+brojSobe+' .naslov').after(' <a href="php/uredi_sadrzaj.php?sadrzaj=soba&action=uredi&brojSobe=' + brojSobe + '"><img style="bottom: 15px;" src="images/sadrzajMuzeja/uredi.png" alt="Uredi sobu"></a> <a href="php/uredi_sadrzaj.php?sadrzaj=soba&action=obrisi&brojSobe=' + brojSobe + '"><img style="bottom: 15px;" src="images/sadrzajMuzeja/obrisi.png" alt="Obriši sobu"></a>');
                    }
                });
                
                var nazivOdjela = $(this).find('nazivOdjela').text();
                $('.s'+brojSobe).append('Odjel kojem soba pripada: <b>' + nazivOdjela + '</b><br>');
               
                
                var brojEksponata = $(this).find('brojEksponata').text();
                //broj korisinku vidljivih eksponata u sobi
                $('.s'+brojSobe).append('Broj eksponata u sobi: <b>' + brojEksponata + '</b> <br>');
                
                
                var posjecenost = $(this).find('posjecenost').text();
                if (posjecenost != '')
                    $('.s'+brojSobe).append('Prosječno posjeta po eksponatu u sobi: <b>' + posjecenost + '</b> <br>');
                
                var ocjena = $(this).find('ocjena').text();
                if (ocjena != '')
                    $('.s'+brojSobe).append('Prosječna ocjena po eksponatu u sobi: <b>' + ocjena + '/5</b> <br>');

            });
            //pozivamo funkciju koja će prikazati sobe u obliku stranica (5 soba po stranici)
            IzbrojEksponate('php/ajax.php','sadrzaji', 'js/jRating/', 4);
        });
    }
    
    
    
    function IspisiOdjele(posjecenostOcjena) {
        //na stranicu umećemo novi sadržaj (sobe)
        $.get('php/ajax.php', {
            action : 'DohvatiNajpopularnijeOdjele',
            sort : posjecenostOcjena
        }, function(data) {
            //najprije praznimo stranicu od postojećih sadržaja
            //mogao sam koristiti samo $('#sadrzaji').html(''), ali nisam jer prikaz ne bude 100% koretkan
            $('div').remove('#sadrzaji');
            $('#stranice').after('<div id="sadrzaji"></div>');
            
        
            //za svaki pronađeni odjel iz xml-a
            $(data).find('odjel').each(function () {
                //najprije za svaki odjel stvaramo div i dodajemo svakom divu klasu s pripadajućim ID-em odjela, kako bi te klase mogli razlikovati
                var brojOdjela = $(this).find('brojOdjela').text();
                $('#sadrzaji').append('<div class="okvir s' + brojOdjela + '"></div>');
                
                //za svaki pronađeni eksponat uzimamo redom njegova svojstva i ispisujemo ih
                var nazivOdjela = $(this).find('nazivOdjela').text();
                $('.s'+brojOdjela).append('<span class="naslov">' + nazivOdjela + '</span> <br><br>');
                
                //ako je korisnik kustos ili administrator, dodajemo gumbe za brisanje i uređivanje sobe
                var tipKorisnika = 0;
                $.get('php/ajax.php', {
                    action: 'DohvatiTipKorisnika'
                }, function(data) {
                    tipKorisnika = $(data).find('tipKorisnika').text();
                    if (tipKorisnika >= 2) {
                        $('.s'+brojOdjela+' .naslov').after(' <a href="php/uredi_sadrzaj.php?sadrzaj=odjel&action=uredi&brojOdjela=' + brojOdjela + '"><img style="bottom: 15px;" src="images/sadrzajMuzeja/uredi.png" alt="Uredi odjel"></a> <a href="php/uredi_sadrzaj.php?sadrzaj=odjel&action=obrisi&brojOdjela=' + brojOdjela + '"><img style="bottom: 15px;" src="images/sadrzajMuzeja/obrisi.png" alt="Obriši odjel"></a>');
                    }
                });
                
                var opisOdjela = $(this).find('opisOdjela').text();
                $('.s'+brojOdjela).append('<b>Opis Odjela</b>: ' + opisOdjela + '<br><br>');
               
                
                var brojEksponata = $(this).find('brojEksponata').text();
                //broj korisinku vidljivih eksponata u odjelu
                $('.s'+brojOdjela).append('Broj eksponata u odjelu: <b>' + brojEksponata + '</b> <br>');
                
                
                var posjecenost = $(this).find('posjecenost').text();
                if (posjecenost != '')
                    $('.s'+brojOdjela).append('Prosječno posjeta po eksponatu u odjelu: <b>' + posjecenost + '</b> <br>');
                
                var ocjena = $(this).find('ocjena').text();
                if (ocjena != '')
                    $('.s'+brojOdjela).append('Prosječna ocjena po eksponatu u odjelu: <b>' + ocjena + '/5</b> <br>');

            });
            //pozivamo funkciju koja će prikazati sobe u obliku stranica (4 odjela po stranici)
            IzbrojEksponate('php/ajax.php','sadrzaji', 'js/jRating/', 4);
        });
    }
    
    /*
     * Ovo se pokreće odmah kada se skripta pokrene
     */
    IspisiEksponate('posjecenost');
    //dodajemo evente na postojeće suvenire u sesiji. Ova funkcija se nalazi u "kosarica_lib.js"
    DodajEventeNaPostojeceSuvenireUSesiji();
    DodajEventZaGumbKupi();
    
    $('input[name=sadrzaj], input[name=sortiranje]').on('change', function() {        
        //ako sortiramo prema posjećenosti
        if ($('input[name=sortiranje][value=posjecenost]:checked').val()) {
            //ako sortiramo prema eksponatima
            if ($('input[name=sadrzaj][value=eksponati]:checked').val()) {
                IspisiEksponate('posjecenost');
            }
            
            //ako sortiramo prema sobama
            if ($('input[name=sadrzaj][value=sobe]:checked').val()) {
                IspisiSobe('posjecenost');
            }
            
            //ako sortiramo prema odjelima
            if ($('input[name=sadrzaj][value=odjeli]:checked').val()) {
                IspisiOdjele('posjecenost');
            }
        }
        
        //ako sortiramo prema ocjeni
        if ($('input[name=sortiranje][value=ocjena]:checked').val()) {
            //ako sortiramo prema eksponatima
            if ($('input[name=sadrzaj][value=eksponati]:checked').val()) {
                IspisiEksponate('ocjena');
            }
            
            //ako sortiramo prema sobama
            if ($('input[name=sadrzaj][value=sobe]:checked').val()) {
                IspisiSobe('ocjena');
            }
            
            //ako sortiramo prema odjelima
            if ($('input[name=sadrzaj][value=odjeli]:checked').val()) {
                IspisiOdjele('ocjena');
            }
        }
    });
});


