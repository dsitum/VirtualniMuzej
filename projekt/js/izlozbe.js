$(document).ready(function() {
    $('.kupiUlaznicu').each(function() {
        $(this).on('click', function() {
            var idIzlozbe = $(this).attr('data-id');
            var klik = $(this);
            //najprije nakon posljednjeg diva "okvir" dodamo novi div "KupiUlaznicuDijalog"
            $('.okvir').last().after('<div id="KupiUlaznicuDijalog"></div>');

            //div "KupiUlaznicuDijalog" (u kojem se traži lozinka) pretvaramo u dialog
            $('#KupiUlaznicuDijalog').dialog({
                show : 'puff',
                hide : 'puff',
                modal : true,
                height : 300,
                width : 400,
                resizable : false,
                title : 'Kupovina ulaznice',
                //nakon što se zatvori ovaj dijalog brišemo div "KupiUlaznicuDijalog" kako bi izbjegli probleme
                close : function() { $('#KupiUlaznicuDijalog').remove(); }
            });

            //u div "KupiUlaznicuDijalog" dodamo polje za unos lozinke i potvrdu kupovine 
            $('#KupiUlaznicuDijalog').append('Upišite vašu lozinku: <br> <input type="password"> <br><br> <input type="button" value="Dovrši kupnju"> <br><br>');
            //kada u klikne na "dovrši kupnju"
            $('#KupiUlaznicuDijalog input[type=button]').on('click', function() {
                $.get('php/ajax.php', {
                    action: 'DohvatiLozinku'
                }, function(data) {
                    var unesenaLozinka = $('#KupiUlaznicuDijalog input[type=password]').val();
                    var pravaLozinka = $(data).find('lozinka').text();
                    //ako se unesena lozinka i lozinka u bazi ne poklapaju
                    if (unesenaLozinka != pravaLozinka) {
                        //najprije brišemo postojeći tekst o tome da se lozinke ne poklapaju
                        $('#KupiUlaznicuDijalog span').remove();
                        //ispisujemo tekst da se lozinke ne poklapaju
                        $('#KupiUlaznicuDijalog').append('<span style="color: red;">Lozinke se ne poklapaju!</span>');
                    }
                    //ako se lozinke poklapaju
                    else {
                        //najprije brišemo postojeći tekst o tome da se lozinke ne poklapaju
                        $('#KupiUlaznicuDijalog span').remove();
                        //Ispisujemo poruku o uspjehu
                        $('#KupiUlaznicuDijalog').append('<span style="color: green;">Zahvaljujemo na kupovini ulaznice!</span>');

                        //poslije div-a za kupnju ulaznice link (a href ...) za posjet izložbe
                        //prije toga, dohvaćamo ID izložbe iz postojećeg diva za kupnju ulaznice
                        //taj id iskoristimo u novom linku
                        klik.after('<a href="php/eksponati.php?izlozba=' + idIzlozbe + '">Posjeti izložbu</a>');
                        //uklanjamo div za kupnju ulaznice uz pripadajući efekt 
                        klik.fadeOut(400, function() { klik.remove(); });

                        //u bazu podataka dodajemo podatak da je korisnik kupio ulaznicu
                        $.get('php/ajax.php', {
                            action: 'KupiUlaznicu',
                            izlozba: idIzlozbe
                        });
                    }
                });
            });
        });
    });
});