function DodajEventZaGumbKupi() {
    var url = window.location.pathname;
    //ako ovu biblioteku poziva datoteka iz mape "php", morat ćemo se vratit u jedan direktorij natrag
    //indexOf vraća indeks prvog pojavljivanja argumenta. U suprotnom vraća -1
    var phpDir = url.indexOf('/php/');
    var prefiks = '';
    //ako biblioteku poziva datoteka iz mape "php", promijenit ćemo prefiks
    if ( phpDir != -1 )
        prefiks = '../';
        
    $('input[value=Kupi]').on('click', function() { 
        //najprije na kraj diva "kosarica" dodamo novi div "KupiSuvenire"
        $('#kosarica').append('<div id="KupiSuvenire"></div>');
        //najprije provjeravamo je li košarica prazna. Ako jest:
        if ( $('#brojStavki').text() == 0) {
            $('#KupiSuvenire').append('Košarica je prazna! Dodajte barem jedan suvenir u nju');
        }
        // Ako košarica nije prazna
        else {
            //najprije dohvaćamo tip korisnika. To radimo da bi spriječili neregistriranog korisnika da kupuje!
            var tipKorisnika = null;

            $.get(prefiks+'php/ajax.php', {
                action: 'DohvatiTipKorisnika'
            }, function(data) {
                tipKorisnika = $(data).find('tipKorisnika').text();
                
                //ako je korisnik nije ulogiran na sustav
                if (tipKorisnika > 0) {
                    //u div "KupiSuvenire" dodamo polje za unos lozinke i potvrdu kupovine 
                    $('#KupiSuvenire').append('Upišite vašu lozinku: <br> <input type="password"> <br><br> <input type="button" value="Dovrši kupnju"> <br><br>');
                }
                //ako korisnik nije ulogiran
                else {
                    $('#KupiSuvenire').append('Morate se registrirati na stranicu da bi mogli kupovati suvenire. Hvala na razumijevanju');
                }
                
                //kada u klikne na "dovrši kupnju"
                $('#KupiSuvenire input[type=button]').on('click', function() {
                    $.get(prefiks+'php/ajax.php', {
                        action: 'DohvatiLozinku'
                    }, function(data) {
                        var unesenaLozinka = $('#KupiSuvenire input[type=password]').val();
                        var pravaLozinka = $(data).find('lozinka').text();
                        //ako se unesena lozinka i lozinka u bazi ne poklapaju
                        if (unesenaLozinka != pravaLozinka) {
                            //najprije brišemo postojeći tekst o tome da se lozinke ne poklapaju
                            $('#KupiSuvenire span').remove();
                            //ispisujemo tekst da se lozinke ne poklapaju
                            $('#KupiSuvenire').append('<span style="color: red;">Lozinke se ne poklapaju!</span>');
                        }
                        //ako se lozinke poklapaju
                        else {
                            //najprije brišemo postojeći tekst o tome da se lozinke ne poklapaju
                            $('#KupiSuvenire span').remove();
                            //Ispisujemo poruku o uspjehu
                            $('#KupiSuvenire').append('<span style="color: green;">Zahvaljujemo na kupovini!</span>');
                            //brišemo košaricu iz sesije
                            $.get(prefiks+'php/ajax.php', {
                                action: 'IzbrisiKosaricuIzSesije'
                            });
                            //brišemo prezentacijski sadržaj košarice (suvenire koji se prikazuju u tablici)
                            $('#kosarica tbody').html('');
                            //postavljamo ukupnu cijenu i količinu u košarici (tablici) na nulu
                            $('#brojStavki').html('0');
                            $('#ukupnaCijena').html('0');
                        }
                    });
                });
            });
            
            
            
        }
        
        //div "KupiSuvenire" (u kojem se traži lozinka) pretvaramo u dialog
        $('#KupiSuvenire').dialog({
            show : 'puff',
            hide : 'puff',
            modal : true,
            height : 300,
            width : 400,
            resizable : false,
            title : 'Kupovina suvenira',
            //nakon što se zatvori ovaj dijalog brišemo div "KupiSuvenire" kako bi izbjegli probleme
            close : function() { $('#KupiSuvenire').remove(); }
        });
    });
}

function DodajEventeNaPostojeceSuvenireUSesiji() {
    //Dodajemo evente na sve suvenire iz sesije koji su dodani prije nego što je ovaj javascript pokrenut (dodani putem smartyja)
    $('tr[data-id]').each(function() {
        var idSuvenira = $(this).attr('data-id');
        var cijena = $(this).find('.cijenaSuvenira').text();
        //kada se klikne na link ukloni, uklanjamo stavke iz košarice 
        $('#SuvenirUKosarici'+idSuvenira+' .UkloniIzKosarice').on('click', function() {
            //najprije ažuriramo ukupni broj stavki i ukupnu cijenu u košarici
            var noviBrojStavki = $('#brojStavki').text() - $('#SuvenirUKosarici' + idSuvenira + ' input').val()
            $('#brojStavki').text(noviBrojStavki);
            var novaUkupnaCijena = $('#ukupnaCijena').text() - cijena * $('#SuvenirUKosarici' + idSuvenira + ' input').val();
            $('#ukupnaCijena').text(novaUkupnaCijena);
            //potom dodamo uklanjamo suvenir s prikaza
            $('#SuvenirUKosarici'+idSuvenira+' td').fadeOut(400);
            setTimeout(function() { $('#SuvenirUKosarici'+idSuvenira).remove(); }, 400);
            UkloniSuvenirIzSesije(idSuvenira, novaUkupnaCijena, noviBrojStavki);
        });
        
        //kada se promijeni vrijednost količine, ažuriramo cijenu
        $('#SuvenirUKosarici'+idSuvenira+' input').on('change', function() {
            //najprije pročitamo staru količinu iz atributa value
            var staraKolicina = $(this).attr('value');
            //umanjimo ukupnu količinu i ukupnu cijenu za stare vrijednosti suvenira (staru količinu)
            var umanjeniBrojStavki = $('#brojStavki').text() - staraKolicina;
            var umanjenaUkupnaCijena = $('#ukupnaCijena').text() - staraKolicina * cijena;
            //postavimo novu ukupnu cijenu i ukupnu količinu
            var noviBrojStavki = umanjeniBrojStavki + parseInt($(this).val());
            var novaUkupnaCijena = umanjenaUkupnaCijena + $(this).val() * cijena;
            //zapišemo postavljenu novu ukupnu cijenu i novu ukupnu količinu u tablicu
            $('#brojStavki').text(noviBrojStavki);
            $('#ukupnaCijena').text(novaUkupnaCijena);
            //u atribut value inputa koji je označavao količinu stavke zapišemo novu vrijednost
            $(this).attr('value', $(this).val());
            //ažuriramo suvenir u sesiji
            AzurirajSuvenirUSesiji(idSuvenira, $(this).val(), novaUkupnaCijena, noviBrojStavki);
        });
    });
}

function DodajSuvenirUSesiju(idSuvenira, nazivSuvenira, cijenaSuvenira, novaUkupnaCijena, noviBrojStavki) {
    var url = window.location.pathname;
    //ako ovu biblioteku poziva datoteka iz mape "php", morat ćemo se vratit u jedan direktorij natrag
    //indexOf vraća indeks prvog pojavljivanja argumenta. U suprotnom vraća -1
    var phpDir = url.indexOf('/php/');
    var prefiks = '';
    //ako biblioteku poziva datoteka iz mape "php", promijenit ćemo prefiks
    if ( phpDir != -1 )
        prefiks = '../';
    
    
    $.get(prefiks+'php/ajax.php',{
        action: 'DodajSuvenirUSesiju',
        idSuvenira: idSuvenira,
        nazivSuvenira: nazivSuvenira,
        cijenaSuvenira: cijenaSuvenira,
        novaUkupnaCijena: novaUkupnaCijena,
        noviBrojStavki: noviBrojStavki
    });
}

function AzurirajSuvenirUSesiji(idSuvenira, kolicinaSuvenira, novaUkupnaCijena, noviBrojStavki) {
    var url = window.location.pathname;
    //ako ovu biblioteku poziva datoteka iz mape "php", morat ćemo se vratit u jedan direktorij natrag
    //indexOf vraća indeks prvog pojavljivanja argumenta. U suprotnom vraća -1
    var phpDir = url.indexOf('/php/');
    var prefiks = '';
    //ako biblioteku poziva datoteka iz mape "php", promijenit ćemo prefiks
    if ( phpDir != -1 )
        prefiks = '../';
    
    
    $.get(prefiks+'php/ajax.php', {
        action: 'AzurirajSuvenirUSesiji',
        idSuvenira: idSuvenira,
        kolicinaSuvenira: kolicinaSuvenira,
        novaUkupnaCijena: novaUkupnaCijena,
        noviBrojStavki: noviBrojStavki
    });
}

function UkloniSuvenirIzSesije(idSuvenira, novaUkupnaCijena, noviBrojStavki) {
    var url = window.location.pathname;
    //ako ovu biblioteku poziva datoteka iz mape "php", morat ćemo se vratit u jedan direktorij natrag
    //indexOf vraća indeks prvog pojavljivanja argumenta. U suprotnom vraća -1
    var phpDir = url.indexOf('/php/');
    var prefiks = '';
    //ako biblioteku poziva datoteka iz mape "php", promijenit ćemo prefiks
    if ( phpDir != -1 )
        prefiks = '../';
    
    
    $.get(prefiks+'php/ajax.php', {
        action: 'UkloniSuvenirIzSesije',
        idSuvenira: idSuvenira,
        novaUkupnaCijena: novaUkupnaCijena,
        noviBrojStavki: noviBrojStavki
    });
}

function DodajKosaricu(idEksponata) {
    var url = window.location.pathname;
    //ako ovu biblioteku poziva datoteka iz mape "php", morat ćemo se vratit u jedan direktorij natrag
    //indexOf vraća indeks prvog pojavljivanja argumenta. U suprotnom vraća -1
    var phpDir = url.indexOf('/php/');
    var prefiks = '';
    //ako biblioteku poziva datoteka iz mape "php", promijenit ćemo prefiks
    if ( phpDir != -1 )
        prefiks = '../';
    
    
    //ako postoje suveniri, postavljamo link na prikaz suvenira
    $.get(prefiks+'php/ajax.php', {
        action : 'DohvatiSuvenire',
        eksponat : idEksponata
    }, function(data) {
        //ako postoji bar jedan suvenir
        if ( $(data).find('suvenir').length > 0) {
            $('.s'+idEksponata+' .podaciOEksponatu').append('<a class="pregledajSuvenire" href="#">Pregledaj suvenire</a>');

            $('.s'+idEksponata+' .pregledajSuvenire').on('click', function() {
                //dodaj div u koji ćemo spremati suvenire (koji će biti zapravo dijalog)
                $('.s'+idEksponata+' .podaciOEksponatu').append('<div class="ProzorSaSuvenirima"></div>');
                $(data).find('suvenir').each(function() {
                    //ispisujemo u dijalog podatke o svim suvenirima
                    var idSuvenira = $(this).find('idSuvenira').text();
                    var naziv = $(this).find('naziv').text();
                    var opis = $(this).find('opis').text();
                    var cijena = $(this).find('cijena').text();
                    $('.s'+idEksponata+' .ProzorSaSuvenirima').append('<div id="suvenir' + idSuvenira + '"></div>');
                    $('#suvenir'+idSuvenira).append('<b>Naziv suvenira:</b> ' + naziv + '<br>');
                    if (opis != '')
                        $('#suvenir'+idSuvenira).append('<b>Opis suvenira:</b> ' + opis + '<br>');
                    $('#suvenir'+idSuvenira).append('<b>Cijena suvenira:</b> ' + cijena + ' kn <br> <br>');
                    $('#suvenir'+idSuvenira).append('<input type="button" value="Dodaj u košaricu"> <br><hr><br>');

                    //na klik gumba "Dodaj u košaricu", dodajemo suvenir u košaricu
                    $('#suvenir'+idSuvenira+' input').on('click', function() {
                        //naprije provjeravamo je li suvenir već u košarici. Ako nije:
                        if ( $('#SuvenirUKosarici'+idSuvenira).length == 0 ) {
                            //stvaramo novi redak za novi suvenir u tablici košarice
                            $('#kosarica tbody').append('<tr id="SuvenirUKosarici'+idSuvenira+'"></tr>');
                            //u stvorenom retku (prethodna linija) dodajemo ćelije
                            $('#SuvenirUKosarici'+idSuvenira).append('<td style="width: 15%;"><input type="text" size="1" value="1"></td>');
                            $('#SuvenirUKosarici'+idSuvenira).append('<td style="width: 65%;"><b>' + naziv + '</b></td>');
                            //za ovo polje nam trebaju 2 reda pa radi jednostavnosti stvaramo još jednu tablicu unutar postojeće
                            $('#SuvenirUKosarici'+idSuvenira).append('<td><b>' + cijena + ' kn</b><br> <a class="UkloniIzKosarice" href="#">Ukloni</a></td>');
                            
                            //kada dodamo suvenir u košaricu, ažuriramo broj stavki i ukupnu cijenu
                            var noviBrojStavki = parseInt($('#brojStavki').text()) + 1;
                            $('#brojStavki').text(noviBrojStavki);
                            var novaUkupnaCijena = parseInt($('#ukupnaCijena').text()) + cijena * $('#SuvenirUKosarici' + idSuvenira + ' input').val();
                            $('#ukupnaCijena').text(novaUkupnaCijena);
                            //zapisujemo suvenir u sesiju kako bi ostao u tablici kada se prozor refresh-a
                            DodajSuvenirUSesiju(idSuvenira, naziv, cijena, novaUkupnaCijena, noviBrojStavki);
                        } 
                        // Ako je suvenir već u košarici a pokušavamo ga ponovno dodati, potrebno je povećati samo količinu u tekstualnom polju
                        else {
                            var staraKolicina = $('#SuvenirUKosarici'+idSuvenira+' input').val();
                            var novaKolicina = parseInt(staraKolicina) + 1;
                            //postavljamo novu vrijednost direktno za prikaz
                            $('#SuvenirUKosarici'+idSuvenira+' input').val(novaKolicina);
                            //budući da polje količine nije promijenio korisnik, nego jquery, mort ćemo okinuti (trigger) event promjene
                            $('#SuvenirUKosarici'+idSuvenira+' input').trigger('change');
                        }
                        

                        //kada se klikne na link ukloni, uklanjamo stavke iz košarice 
                        $('#SuvenirUKosarici'+idSuvenira+' .UkloniIzKosarice').on('click', function() {
                            //najprije ažuriramo ukupni broj stavki i ukupnu cijenu u košarici
                            var noviBrojStavki = $('#brojStavki').text() - $('#SuvenirUKosarici' + idSuvenira + ' input').val()
                            $('#brojStavki').text(noviBrojStavki);
                            var novaUkupnaCijena = $('#ukupnaCijena').text() - cijena * $('#SuvenirUKosarici' + idSuvenira + ' input').val();
                            $('#ukupnaCijena').text(novaUkupnaCijena);
                            //potom dodamo uklanjamo suvenir s prikaza
                            $('#SuvenirUKosarici'+idSuvenira+' td').fadeOut(400);
                            setTimeout(function() { $('#SuvenirUKosarici'+idSuvenira).remove(); }, 400);
                            UkloniSuvenirIzSesije(idSuvenira, novaUkupnaCijena, noviBrojStavki);
                        });
                        
                        //kada se promijeni vrijednost količine, ažuriramo cijenu
                        $('#SuvenirUKosarici'+idSuvenira+' input').on('change', function() {
                            //najprije pročitamo staru količinu iz atributa value
                            var staraKolicina = $(this).attr('value');
                            //umanjimo ukupnu količinu i ukupnu cijenu za stare vrijednosti suvenira (staru količinu)
                            var umanjeniBrojStavki = $('#brojStavki').text() - staraKolicina;
                            var umanjenaUkupnaCijena = $('#ukupnaCijena').text() - staraKolicina * cijena;
                            //postavimo novu ukupnu cijenu i ukupnu količinu
                            var noviBrojStavki = umanjeniBrojStavki + parseInt($(this).val());
                            var novaUkupnaCijena = umanjenaUkupnaCijena + $(this).val() * cijena;
                            //zapišemo postavljenu novu ukupnu cijenu i novu ukupnu količinu u tablicu
                            $('#brojStavki').text(noviBrojStavki);
                            $('#ukupnaCijena').text(novaUkupnaCijena);
                            //u atribut value inputa koji je označavao količinu stavke zapišemo novu vrijednost
                            $(this).attr('value', $(this).val());
                            //ažuriramo suvenir u sesiji
                            AzurirajSuvenirUSesiji(idSuvenira, $(this).val(), novaUkupnaCijena, noviBrojStavki);
                        });
                    });
                });

                $('.s'+idEksponata+' .ProzorSaSuvenirima').dialog({
                    show : 'puff',
                    hide : 'puff',
                    modal : true,
                    height : 400,
                    width : 400,
                    resizable : false,
                    title : 'Suveniri'
                });
            });
        }
    });
}