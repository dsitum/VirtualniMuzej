//http://www.99points.info/2010/06/live-availability-checking-with-ajax-and-jquery/


//funkcija koja uklanja element X
function Ukloni(id) {
    var x = document.getElementById(id);
    if(x) x.parentNode.removeChild(x);
}

//polje koje ima focus se uokviruje
var poljaRegistracije = document.getElementsByClassName("poljeForme");
for (var i=0; i<poljaRegistracije.length; i++)
{
    poljaRegistracije[i].addEventListener("focus", function() {
       this.setAttribute("class","oznacenoPolje"); 
    });
    poljaRegistracije[i].addEventListener("blur", function() {
       this.setAttribute("class","poljeForme"); 
    });
}


/////////////////////////////////////////Provera jesu li unesene lozinke jednake
var istaLozinka = true;
var lozinka = document.getElementById("password");
var lozinka2 = document.getElementById("password2");
if (lozinka) lozinka.addEventListener("blur", ProvjeriLozinku);
if (lozinka2) lozinka2.addEventListener("blur", ProvjeriLozinku2);

function ProvjeriLozinku() {
    if (lozinka.value === lozinka2.value) {
        istaLozinka = true;
        Ukloni("krivaLozinka");
        //lozinka.setAttribute("class","poljeForme");
        //lozinka2.setAttribute("class","poljeForme");
    } else {
        istaLozinka = false;
        //lozinka.setAttribute("class","kriviUnos");
        //lozinka2.setAttribute("class","kriviUnos");
    }
}

function ProvjeriLozinku2() {
    if (lozinka.value === lozinka2.value) {
        istaLozinka = true;
        Ukloni("krivaLozinka");
        lozinka.setAttribute("class","poljeForme");
        lozinka2.setAttribute("class","poljeForme");
    } else {
        Ukloni("krivaLozinka");
        istaLozinka = false;
        var text = "<img id='krivaLozinka' alt='Kriva lozinka' src='images/register/redx.png' />";
        lozinka2.insertAdjacentHTML("afterEnd", text);
        lozinka.setAttribute("class","kriviUnos");
        lozinka2.setAttribute("class","kriviUnos");
    }
}

/////////////////////////////////////////Provjera imena i prezimena: početno slovo veliko & sadrži samo slova
var imeValidno = true;
var prezimeValidno = true;
ime = document.getElementById("ime");
prezime = document.getElementById("prezime");

//Sadrži li ime samo slova i početno veliko slovo?
if(ime) 
    ime.addEventListener("blur", function() {
        if (/^(([A-Z]|[ČĆŠŽĐ]){1}([a-z]|[čćšžđ])+|())$/.test(this.value)) {    //Ako je početno slovo veliko & string sadrzi samo slova
            Ukloni("imePogreska");
            imeValidno = true;
            ime.setAttribute("class","poljeForme");
        } else {
            Ukloni("imePogreska");
            var text = "<i id='imePogreska' style='color: red; font-size:0.7em;'> Mora započinjati velikim slovom i sadržavati isključivo slova! </i>";
            this.insertAdjacentHTML("afterEnd", text);
            imeValidno = false;
            ime.setAttribute("class","kriviUnos");
        }
    });

//Sadrži li prezime samo slova i početno veliko slovo?
if (prezime) 
    prezime.addEventListener("blur", function() {
        if (/^(([A-Z]|[ČĆŠŽĐ]){1}([a-z]|[čćšžđ])+|())$/.test(this.value)) {    //Ako je početno slovo veliko & string sadrzi samo slova
            Ukloni("prezimePogreska");
            prezimeValidno = true;
            prezime.setAttribute("class","poljeForme");
        } else {
            Ukloni("prezimePogreska");
            var text = "<i id='prezimePogreska' style='color: red; font-size:0.7em;'> Mora započinjati velikim slovom i sadržavati isključivo slova! </i>";
            this.insertAdjacentHTML("afterEnd", text);
            prezimeValidno = false;
            prezime.setAttribute("class","kriviUnos");
        }
    });

/////////////////////////////////////////labela iznad koje je kursor mijenja klasu na hover
var notHover = document.getElementsByClassName("poljeForme");

for (var i=0; i<notHover.length; i++) {
    notHover[i].addEventListener("mouseover", postaviKlasuHover);
    notHover[i].addEventListener("mouseout", ukloniKlasuHover);
}

function postaviKlasuHover() {
    this.setAttribute("class","hover");
}

function ukloniKlasuHover() {
    this.setAttribute("class","poljeForme");
}


/////////////////////////////////////////Provjera je li spol odabran
var spol = document.getElementById("spol");
if (spol) 
{
    var odabraniSpol = spol.options[spol.selectedIndex].value;
    spol.addEventListener("change", function() {
        odabraniSpol = spol.options[spol.selectedIndex].value;
    });
}


/////////////////////////////////////////Provjera svega još jednom prije slanja obrsaca
var obrazac = document.forms[0];    //naš obrazac
obrazac.addEventListener("submit", function(slanje) {
    if (!imeValidno || !prezimeValidno || !istaLozinka || odabraniSpol == 0) {
        alert("Neki podaci nisu ispravno ili uopće uneseni.");
        slanje.preventDefault();
    }
});