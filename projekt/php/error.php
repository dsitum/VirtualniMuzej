<?php
    if ( isset($_GET['e']) ) {
        switch ( $_GET['e'] ) {
            case 'prekoracenaVelicinaDatotekeServer': $poruka = 'Prekoračena dopuštena veličina datoteke zadana serverom'; break;
            case 'prekoracenaDopustenaVelicinaDatoteke': $poruka = 'Prekoračena dopuštena veličina datoteke od 5MB'; break;
            case 'datotekaNijePosveUploadana': $poruka = 'Datoteka nije uplodana u potpunosti. Pokušajte ponovno'; break;
            case 'datotekaNijeUploadana': $poruka = 'Datoteka nije uploadana'; break;
            case 'datotekaNijeSlika': $poruka = 'Datoteka koju ste odabrali nije slika. Dozvoljeni formati su JPEG, JPG, GIF i PNG'; break;
            case 'datotekuNemogucePremjestiti': $poruka = 'Datoteku nije moguće premjestiti u direktorij sa slikama. Je li u direktorij moguće pisati?'; break;
            case 'nijeUnesenSadrzajIzlozbe': $poruka = 'Za izložbu nije odabran niti jedan eskponat, soba ili odjel. Nikakve promjene nisu porhanjene'; break;
            case 'korisnickoImeVecPostoji': $poruka = 'Odabrano korisničko ime već postoji u bazi podataka. Molimo odaberite drugo.'; break;
            case 'emailVecPostoji': $poruka = 'Upisana e-mail adresa već postoji u bazi podataka. Molimo odaberite drugu.'; break;
            case 'telefonVecPostoji': $poruka = 'Korisnik s upisanim brojem telefona je već registriran. Molimo odaberite drugi broj telefona'; break;
        }
    }
?>
<?
    require_once '../prilozi/smarty.php';

    $smarty->assign('poruka', $poruka);
    
    $smarty->display('php/error.tpl');
?>