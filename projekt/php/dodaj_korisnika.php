<?php
    session_start();
    
    require_once 'biljezenje_lib.php';
    
    function ProvjeriCaptchu() {
        require_once('recaptchalib.php');
        $privatekey = "6Ld14eASAAAAANiPJIGBb-jAinnbXeHtLD4UJtJV";
        $resp = recaptcha_check_answer ($privatekey,
                                  $_SERVER["REMOTE_ADDR"],
                                  $_POST["recaptcha_challenge_field"],
                                  $_POST["recaptcha_response_field"]);

        if (!$resp->is_valid) {     //ako captcha nije dobro unesena
            return "Captcha nije dobro usesena!";
        } else {
            return 1;
        }
    }


    function ProvjeriMail() {
        $mailScheme = '/^.+@.+\.[A-Za-z]{2,}$/';    //ispred @ sadržava bilo koje slovo, najmanje jednom. Iza @ i ispred točke sadrzava bilo koje slovo najmanje 1. Iza točke moraju biti najmanje 2 slova
        $mailIspravan = preg_match($mailScheme, $_POST['email']);

        if (! $mailIspravan) {
            return 'Neispravno unesena e-mail adresa!';
        } else {
            return 1;
        }
    }


    function ProvjeriOstalaPolja() {
        foreach ($_POST as $kljuc => $polje) {
            if ($kljuc != 'recaptcha_challenge_field' && $kljuc != 'recaptcha_response_field') {    //provjeravaju se sva polja osim onih od captche
                if (empty($polje) && $kljuc != 'obavijest') {       //polje "mail obavijesti" (pretplatu) ne provjeravamo jer ono može imati vrijednost 0!
                    return 'Molimo vas da popunite sva prazna polja.';
                }
            }
        }
        
        return 1;
    }


    function DodajKorisnika() {
        require_once 'db_connect.php';
        
        //proveravamo postoji li korisničko ime već u bazi
        $rezultat = Upit("SELECT idKorisnika FROM korisnici WHERE korime = '{$_POST["username"]}'");
        if ( $rezultat->fetch_array() ) {
            header("Location: error.php?e=korisnickoImeVecPostoji"); die();
        }
        
        //provjeravamo postoji li mail adresa već u bazi
        $rezultat = Upit("SELECT idKorisnika FROM korisnici WHERE email = '{$_POST["email"]}'");
        if ($rezultat->fetch_array()) {
            header("Location: error.php?e=emailVecPostoji"); die();
        }
        
        //provjeravamo postoji li broj telefona već u bazi
        $rezultat = Upit("SELECT idKorisnika FROM korisnici WHERE telefon = '{$_POST["telefon"]}'");
        if ($rezultat->fetch_array()) {
            header("Location: error.php?e=telefonVecPostoji"); die();
        }
        
        
        
        $naredba = "INSERT INTO korisnici VALUES (DEFAULT, '" . $_POST["username"] . "', '". $_POST["password"] . 
                "', '" . $_POST["ime"] . "', '" . $_POST["prezime"] . "', '" . $_POST["email"]
                . "', '" . $_POST["telefon"] . "', '" . $_POST["grad"] . "', '" . $_POST["zivotopis"]
                . "', '" . $_POST["datumrodjenja"] . "', '" . $_POST["spol"]
                . "', '" . $_POST["obavijest"] . "', '" . date("Y-m-d H:i:s",time()+$_SESSION["pomak"]) . "', 0, 1, 0, 0, 0)"; 


        $upit = new Upit();
        $upit->Izvrsi($naredba);
        unset($upit);

        PosaljiMail();

        UpisiUDnevnik("Korisnik s korisničkim imenom: {$_POST['username']} ({$_POST['ime']} {$_POST['prezime']}) se registrirao na stranicu");
        return "Uspješno ste se registrirali. Na vašu adresu je poslan email s linkom za potvrdu registracije. \n
            Registraciju je potrebno potvrditi unutar 24 sata.";

    }


    function PosaljiMail() {
        $upit = new Upit();
        $naredba = "SELECT idKorisnika FROM korisnici WHERE korime = '" . $_POST["username"] . "'";
        $rezultat = $upit->Izvrsi($naredba);
        unset($upit);
        list($id) = $rezultat->fetch_array();

        $to = $_POST["email"];
        $subject = "Aktivacijski link za potvrdu registracije";
        $body = "
            <html>
            <head>
                <title>Aktivacijski link za potvrdu registracije</title>
            </head>
            <body>
            Pozdrav <b>" . $_POST["username"] . "</b>, \n
            Hvala vam na registraciji na naš virtualni muzej \n\n
            Kako biste potvrdili vašu registraciju, molimo vas da kliknete na link ispod: \n
            <a href='http://arka.foi.hr/WebDiP/2012_projekti/WebDiP2012_073/php/aktivacija_korisnika.php?id=" . $id . "'>Aktiviraj moj korisnički račun</a> \n\n
            Srdačan pozdrav, <br>
            Vaš virtualni muzej
            </body>
            </html>
            ";

        $headers  = 'MIME-Version: 1.0' . "\r\n";
        $headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";

        mail($to, $subject, $body, $headers);
    }
?>
<?php
    $captchaKrivoUnesena = ProvjeriCaptchu();
    $mailKrivoUnesen = ProvjeriMail();
    $poljaNisuPopunjena = ProvjeriOstalaPolja();
?>
<?php
    require_once '../prilozi/smarty.php';
    
    
    //ako je captcha krivo unesena tj. $captchaKrivoUnesena == true => porukaPogreške
    if ($captchaKrivoUnesena != 1) {
        $smarty->assign('captchaKrivoUnesena', $captchaKrivoUnesena);
    }     
    //ako je mail krivo unesen, tj. $mailKrivoUnesen == true => porukaPogreške
    elseif ($mailKrivoUnesen != 1) {
        $smarty->assign('mailKrivoUnesen', $mailKrivoUnesen);
    } 
    //ako ostala polja nisu popunjena (tj. ako je vraćena poruka pogreške)
    elseif ($poljaNisuPopunjena != 1) {
        $smarty->assign('poljaNisuPopunjena', $poljaNisuPopunjena);
    } else {
        $porukaNakonRegistracije = DodajKorisnika();
        $smarty->assign('porukaNakonRegistracije', $porukaNakonRegistracije);
    }
    
    
    $smarty->display('php/dodaj_korisnika.tpl');
?>