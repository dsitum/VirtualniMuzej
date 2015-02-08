<?php
    session_start();
    
    require_once 'php/db_connect.php';
    require_once 'php/biljezenje_lib.php';
    
    //ako neregistrirani korisnik pokuša pristupiti izložbama
    if ($_SESSION['tip'] == 0) {
        header("Location: odjeli_sobe.php"); die();
    }
    
    //ako je korisnik kustos ili administrator, dohvaćamo SVE izložbe (kako bi ih se moglo uređivati)
    if ($_SESSION['tip'] >= 2) {
        $naredba = "SELECT * FROM kalendarizlozbi ORDER BY nazivIzlozbe";
    }
    //u suprotnom, dohvaćamo sve AKTIVNE izložbe
    else {
        $naredba = "SELECT * FROM kalendarizlozbi WHERE vrijemeOtvaranja < '". VrijemeSPomakom() ."' AND vrijemeZatvaranja > '". VrijemeSPomakom() ."' ORDER BY nazivIzlozbe";
    }
    $rezultat = Upit($naredba);
    
    $izlozbe = null;
    $i = 0;
    while ($izlozba = $rezultat->fetch_assoc()) {
        $izlozba['vrijemeOtvaranja'] = date('d.m.Y H:i:s', strtotime($izlozba['vrijemeOtvaranja']));
        $izlozba['vrijemeZatvaranja'] = date('d.m.Y H:i:s', strtotime($izlozba['vrijemeZatvaranja']));
        $izlozbe[$i]['podaciIzlozbe'] = $izlozba;
        
        //dohvaćamo izložbe za koje korisnik ima kupljene ulaznice (kojima ima pristup)
        $naredba = "SELECT izlozba FROM ulaznice WHERE kupac = {$_SESSION['idKorisnika']} AND izlozba = {$izlozba['brojIzlozbe']}";
        $rezultatPodupit = Upit($naredba);
        
        //ako kupac ima ulaznicu za izložbu, zapisujemo to u polje
        if ($rezultatPodupit->fetch_array()) {
            $izlozbe[$i]['imaUlaznicu'] = TRUE;
        } else {
            $izlozbe[$i]['imaUlaznicu'] = FALSE;
        }
        
        //za svaku izložbu dodajemo odjele koje ona uključuje
        $naredba = "SELECT nazivOdjela FROM odjeli JOIN pristupodjelima ON pristupodjelima.odjel = odjeli.brojOdjela WHERE pristupodjelima.izlozba = {$izlozba['brojIzlozbe']} ORDER BY 1";
        $rezultatPodupit = Upit($naredba);
        while ($odjel = $rezultatPodupit->fetch_assoc()) {
            $izlozbe[$i]['odjeli'][] = $odjel;
        }
        
        //za svaku izložbu dodajemo sobe koje ona uključuje
        $naredba = "SELECT nazivSobe FROM sobe JOIN pristupsobama ON pristupsobama.soba = sobe.brojSobe WHERE pristupsobama.izlozba = {$izlozba['brojIzlozbe']} ORDER BY 1";
        $rezultatPodupit = Upit($naredba);
        while ($soba = $rezultatPodupit->fetch_assoc()) {
            $izlozbe[$i]['sobe'][] = $soba;
        }
        
        //za svaku izložbu dodajemo eksponate koje ona uključuje
        $naredba = "SELECT naziv FROM eksponati JOIN pristupeksponatima ON pristupeksponatima.eksponat = eksponati.idEksponata WHERE pristupeksponatima.izlozba = {$izlozba['brojIzlozbe']} ORDER BY 1";
        $rezultatPodupit = Upit($naredba);
        while ($eksponat = $rezultatPodupit->fetch_assoc()) {
            $izlozbe[$i]['eksponati'][] = $eksponat;
        }
        
        $i++;
    }  
?>

<?php
    require_once 'prilozi/smarty.php';
    
    $smarty->assign('izlozbe', $izlozbe);
    
    $smarty->display('izlozbe.tpl');
?>