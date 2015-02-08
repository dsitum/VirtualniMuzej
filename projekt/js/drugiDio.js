var usernameAvailable;

$(document).ready(function() {
    $("#username").blur(CheckUsernameAvail);
    $("#grad").autocomplete({delay: 500, minLength:3, source: PripremaZaAutocomplete() });
    $("#registracija").on('submit', function() {
        if (usernameAvailable == false) {
            alert("Odaberite drugo korisničko ime.");
            return false;
        }
    });
});


function CheckUsernameAvail() {
    var korisnickoImeZauzeto = 0;
    $.get("php/ajax.php", {
        action: 'DohvatiPopisKorisnika'
    }, function(data) {
        $(data).find('korime').each( function() {
            if ( $(this).text() == $('#username').val() ) {
                korisnickoImeZauzeto = 1;
            }
        });
        
        if (korisnickoImeZauzeto == 1) {
            $("#username").css("background-color", "white");    //postavlja se zato da fade-out bude u bijelu boju, ne u transparentnu
            $("#username").effect("highlight", {color: "yellow"}, 1000);
            $("#korisnickoImeZauzeto").remove();
            $("<i id='korisnickoImeZauzeto' style='color: red; font-size:0.7em;'>Korisničko ime već postoji, odaberite drugo. </i>").insertAfter("#username");
            usernameAvailable = false;
        } else {
            $("#korisnickoImeZauzeto").remove();
            usernameAvailable = true;
        }
    });
    
    
}

function PripremaZaAutocomplete() {
    var gradovi = new Array();
    $.get("prilozi/gradovi.json").done(function(g) {
        $.each(g, function(i, val) {
            gradovi[i] = val;
        });
    });
    return gradovi;
}
