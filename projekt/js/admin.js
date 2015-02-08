$(document).ready(function() {
    //kada korisnik klikne na link s id-om "pregledajLog"
    $('#pregledajLog').on('click', function() {
        //najprije rekreiramo div LogZapisa, da se ne javljaju greške
        $('#LogZapisa').remove();
        $('#pregledajLog').after('<div id="LogZapisa">');
        
        $('#LogZapisa').dialog({
            show : 'puff',
            hide : 'puff',
            modal : true,
            height : 400,
            width : 800,
            resizable : false,
            title : 'Dnevnik zapisa'
        });
        
        //unutar diva "LogZapisa" stvorimo tablicu
        $('#LogZapisa').append('<table>');
        $('#LogZapisa table').append('<thead><tr><th>Korisničko ime</th><th>Aktivnost</th><th>Vrijeme</th><th>IP adresa</th><th>Preglednik</th></tr></thead>');
        $('#LogZapisa table').append('<tbody>');
        
        $.get('php/ajax.php', {
            action: 'DohvatiZapiseDnevnika'
        }, function(data) {
            $(data).find('zapis').each(function() {
                var korisnik = $(this).find('korisnik').text();
                var aktivnost = $(this).find('aktivnost').text();
                var vrijeme = $(this).find('vrijeme').text();
                var ipAdresa = $(this).find('ipAdresa').text();
                var preglednik = $(this).find('preglednik').text();
                
                $('#LogZapisa table tbody').append('<tr><td>'+korisnik+'</td><td>'+aktivnost+'</td><td>'+vrijeme+'</td><td>'+ipAdresa+'</td><td>'+preglednik+'</td></tr>')
            });
            $('#LogZapisa table').dataTable({ "sPaginationType": "full_numbers"});
        });
    });
    
    
    $('#pregledajKorisnike').on('click', function() {
        //najprije rekreiramo div "PopisKorisnika", da se ne javljaju greške
        $('#PopisKorisnika').remove();
        $('#pregledajKorisnike').after('<div id="PopisKorisnika">');
        
        $('#PopisKorisnika').dialog({
            show : 'puff',
            hide : 'puff',
            modal : true,
            height : 400,
            width : 900,
            resizable : false,
            title : 'Popis korisnika'
        });
        
        //unutar diva "PopisKorisnika" stvaramo tablicu
        $('#PopisKorisnika').append('<table>');
        $('#PopisKorisnika table').append('<thead><tr><th>Korisnik</th><th>Broj Prijava</th><th>Zaključan</th><th>Aktiviran</th><th>Detalji</th><th>Zaključan</th><th>Uredi</th></tr></thead>')
        $('#PopisKorisnika table').append('<tbody>');
        
        $.get('php/ajax.php', {
            action: 'DohvatiPopisKorisnika'
        }, function(data) {
            $(data).find('korisnik').each(function() {
                var idKorisnika = $(this).find('idKorisnika').text();
                var korime = $(this).find('korime').text();
                var brojPrijava = $(this).find('brojPrijava').text();
                var zakljucan = $(this).find('zakljucan').text();
                var aktiviran = $(this).find('aktiviran').text();
                var detalji = '<a href="php/ispis_detalja_korisnika.php?id=' + idKorisnika + '">Detalji</a>';
                var uredi = '<a href="php/uredi_korisnika.php?id=' + idKorisnika + '">Uredi</a>';
                
                $('#PopisKorisnika table tbody').append('<tr><td>'+korime+'</td><td>'+brojPrijava+'</td><td>'+zakljucan+'</td><td>'+aktiviran+'</td><td>'+detalji+'</td><td>'+uredi+'</td></tr>');
            });
            
            $('#PopisKorisnika table').dataTable({ "sPaginationType": "full_numbers"});
        });
    });
});


