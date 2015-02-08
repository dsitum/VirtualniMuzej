<?php
    session_start();
    if ($_SESSION["tip"] == 3) {
        require_once 'php/db_connect.php';

        $naredba = "SELECT count(*) FROM korisnici";
        $upit = new Upit();
        $rezultat = $upit->Izvrsi($naredba);
        list($broj_ukupno) = $rezultat->fetch_array();

        $naredba = "SELECT count(*) FROM korisnici where aktiviran=0";
        $rezultat = $upit->Izvrsi($naredba);
        list($broj_neaktiviranih) = $rezultat->fetch_array();

        $naredba = "SELECT count(*) FROM korisnici where zakljucan=1";
        $rezultat = $upit->Izvrsi($naredba);
        list($broj_zakljucanih) = $rezultat->fetch_array();

        $visina_neaktivnih = $broj_neaktiviranih/$broj_ukupno*290;   //u canvasu
        $yoffset_neaktivnih = 300 - $visina_neaktivnih;

        $visina_zakljucanih = $broj_zakljucanih/$broj_ukupno*290;
        $yoffset_zakljucanih = 300 - $visina_zakljucanih;
    }
?>
            
            

<?php
    require_once 'prilozi/smarty.php';
    
    $smarty->assign('ukupan_broj', $broj_ukupno);
    $smarty->assign('broj_neaktiviranih', $broj_neaktiviranih);
    $smarty->assign('broj_zakljucanih', $broj_zakljucanih);
    $smarty->assign('yoffset_neaktivnih', $yoffset_neaktivnih-1);
    $smarty->assign('visina_neaktivnih', $visina_neaktivnih);
    $smarty->assign('yoffset_zakljucanih', $yoffset_zakljucanih-1);
    $smarty->assign('visina_zakljucanih', $visina_zakljucanih);
    
    
    
    $smarty->display("admin.tpl");
?>