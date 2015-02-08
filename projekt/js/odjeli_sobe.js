$(document).ready(function() {
    //kada korisnik klikne na link neke sobe, ova funkcija dohvaća eksponate za tu sobu i prikazuje ih u obliku dijaloga
    $('.prikaziEksponateUSobi').on('click', function() {
        var brojSobe = $(this).attr('data-id');
        var nazivSobe = $(this).text();
        $.get('php/ajax.php', {
            action: 'DohvatiEksponateIzSobe',
            brojSobe: brojSobe
        }, function(data) {
            //Stvaramo div s ID-em "EksponatiUSobi". U njega ćemo spremati sve eksponate koji se nalaze u određenoj sobi
            $('.okvir').after('<div id="EksponatiUSobi" class="standard"></div>');
            //ako je u sobi pronađen barem jedan eksponat, prikazat ćemo ga
            if ( $(data).find('eksponat').length > 0 ) {
                $('#EksponatiUSobi').append(' <a href="php/eksponati.php?soba=' + brojSobe + '"><span style="color: #AB976A; text-decoration:underline;">Pregledaj sve eksponate u sobi</span></a>' + '<hr>');

                $('#EksponatiUSobi').append('Za pregled pojedinog eksponata, kliknite na njegovo ime: <br> <ol></ol>');
                //ispisujemo sadržaj xml datoteke (sve eksponate u određenoj sobi)
                $(data).find('eksponat').each(function() {
                    var idEksponata = $(this).find('idEksponata').text()
                    var naziv = $(this).find('naziv').text();
                    $('#EksponatiUSobi ol').append('<li><a style="color: #AB976A; text-decoration:underline;" href="php/eksponati.php?eksponat=' + idEksponata + '" data-id="' + idEksponata + '">' + naziv + '</a></li>');
                    //ako je korisnik kustos ili administrator, pokraj linka svakog eksponata dodajemo ikone za uređivanje / brisanje eksponata
                    $.get('php/ajax.php', {
                        action: 'DohvatiTipKorisnika'
                    }, function(data) {
                        var tipKorisnika = $(data).find('tipKorisnika').text();
                        //ako je dohvaćeni tip korisinka kustos ili administrator, ispisujemo ikone za uređivanje / brisanje eksponata
                        if (tipKorisnika >= 2) {
                            $('#EksponatiUSobi a[data-id=' + idEksponata + ']').after(' <a href="php/uredi_sadrzaj.php?sadrzaj=eksponat&action=uredi&idEksponata=' + idEksponata + '"><img style="vertical-align: middle;" src="images/sadrzajMuzeja/uredi.png" alt="Uredi eksponat"></a> <a href="php/uredi_sadrzaj.php?sadrzaj=eksponat&action=obrisi&idEksponata=' + idEksponata + '"><img style="vertical-align: middle;" src="images/sadrzajMuzeja/obrisi.png" alt="Obriši eksponat"></a>');
                        }
                    });
                });
            }
            //ako u sobi nije pronađen niti jedan eksponat, ispisat ćemo poruku korisniku
            else {
                $('#EksponatiUSobi').append('U ovoj sobi nema eksponata');
            }
            
            $('#EksponatiUSobi').dialog({
                show : 'puff',
                hide : 'puff',
                modal : true,
                height : 400,
                width : 400,
                resizable : false,
                title : 'Eksponati sobe: ' + nazivSobe,
                //nakon što se zatvori ovaj dijalog brišemo div "EksponatiUSobi" kako bi izbjegli probleme
                close : function() { $('#EksponatiUSobi').remove(); }
            });
        });
    });
    
    
    //kada korisnik klikne na link nekog odjela, ova funkcija dohvaća eksponate za taj odjel i prikazuje ih u obliku dijaloga
    $('.prikaziEksponateUOdjelu').on('click', function() {
        var brojOdjela = $(this).attr('data-id');
        var nazivOdjela = $(this).text();
        $.get('php/ajax.php', {
            action: 'DohvatiEksponateIzOdjela',
            brojOdjela: brojOdjela
        }, function(data) {
            //Stvaramo div s ID-em "EksponatiUOdjelu". U njega ćemo spremati sve eksponate koji se nalaze u određenom odjelu
            $('.okvir').after('<div id="EksponatiUOdjelu" class="standard"></div>');
            //ako je u odjelu pronađen barem jedan eksponat, prikazat ćemo ga
            if ( $(data).find('eksponat').length > 0 ) {
                $('#EksponatiUOdjelu').append(' <a href="php/eksponati.php?odjel=' + brojOdjela + '"><span style="color: #AB976A; text-decoration:underline;">Pregledaj sve eksponate u odjelu</span></a>' + '<hr>');

                $('#EksponatiUOdjelu').append('Za pregled pojedinog eksponata, kliknite na njegovo ime: <br> <ol></ol>');
                //ispisujemo sadržaj xml datoteke (sve eksponate u određenom odjelu)
                $(data).find('eksponat').each(function() {
                    var idEksponata = $(this).find('idEksponata').text()
                    var naziv = $(this).find('naziv').text();
                    $('#EksponatiUOdjelu ol').append('<li><a style="color: #AB976A; text-decoration:underline;" href="php/eksponati.php?eksponat=' + idEksponata + '" data-id=' + idEksponata + '>' + naziv + '</a></li>');
                    //ako je korisnik kustos ili administrator, pokraj linka svakog eksponata dodajemo ikone za uređivanje / brisanje eksponata
                    $.get('php/ajax.php', {
                        action: 'DohvatiTipKorisnika'
                    }, function(data) {
                        var tipKorisnika = $(data).find('tipKorisnika').text();
                        //ako je dohvaćeni tip korisinka kustos ili administrator, ispisujemo ikone za uređivanje / brisanje eksponata
                        if (tipKorisnika >= 2) {
                            $('#EksponatiUOdjelu a[data-id=' + idEksponata + ']').after(' <a href="php/uredi_sadrzaj.php?sadrzaj=eksponat&action=uredi&idEksponata=' + idEksponata + '"><img style="vertical-align: middle;" src="images/sadrzajMuzeja/uredi.png" alt="Uredi eksponat"></a> <a href="php/uredi_sadrzaj.php?sadrzaj=eksponat&action=obrisi&idEksponata=' + idEksponata + '"><img style="vertical-align: middle;" src="images/sadrzajMuzeja/obrisi.png" alt="Obriši eksponat"></a>');
                        }
                    });
                });
            }
            //ako u odjelu nije pronađen niti jedan eksponat, ispisat ćemo poruku korisniku
            else {
                $('#EksponatiUOdjelu').append('U ovom odjelu nema eksponata');
            }
            
            $('#EksponatiUOdjelu').dialog({
                show : 'puff',
                hide : 'puff',
                modal : true,
                height : 400,
                width : 400,
                resizable : false,
                title : 'Eksponati odjela: ' + nazivOdjela,
                //nakon što se zatvori ovaj dijalog brišemo div "EksponatiUSobi" kako bi izbjegli probleme
                close : function() { $('#EksponatiUOdjelu').remove(); }
            });
        });
    });
});

