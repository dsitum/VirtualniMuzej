<?php
    /*
     * U ovom php bloku saznajemo ukupan broj odjela
     */
    session_start();
    require_once 'php/db_connect.php';
    
    $odjeli = null;
    
    //najprije uzmemo indekse odjela sortirane prema imenu odjela
    $naredba = "SELECT * FROM odjeli ORDER BY nazivOdjela";
    $upit1 = new Upit();
    $rezultat1 = $upit1->Izvrsi($naredba);
    unset($upit1);
    
    while ($odjel = $rezultat1->fetch_assoc()) {
        $odjeli[] = $odjel;
    }
?>

<?php
    /*
     * Nakon što smo saznali ukupan broj odjela,
     * taj broj koristimo kako bi mogli grupirati sobe po odjelima.
     * To činimo kako bi nam ispis bio što jednostavniji
     * (kako bi mogli ispisivati sobe po odjelima, budući da sql
     * ne vraća podatke hijerarhijski nego linearno)
     */

    $odjeli_sobe = NULL;
    
    //kada imamo indekse odjela sortirane prema imenu odjela, redom za njih ispisujemo sobe
    //provjeravamo najprije postoji li ijedan odjel
    if (!empty($odjeli))
        foreach ($odjeli as $odjel) {
        {
            $brojOdjela = $odjel['brojOdjela'];

            $odjeli_sobe[$brojOdjela]['brojOdjela'] = $brojOdjela;
            $odjeli_sobe[$brojOdjela]['nazivOdjela'] = $odjel['nazivOdjela'];
            $odjeli_sobe[$brojOdjela]['opisOdjela'] = $odjel['opisOdjela'];
            $odjeli_sobe[$brojOdjela]['vidljivostOdjela'] = $odjel['vidljivostOdjela'];

            $naredba = "SELECT brojSobe, nazivSobe, brojOdjela, nazivOdjela, opisOdjela, vidljivostOdjela, vidljivostSobe FROM odjeli JOIN sobe ON odjel = brojOdjela WHERE brojOdjela = $brojOdjela ORDER BY nazivSobe";
            $upit = new Upit();
            $rezultat = $upit->Izvrsi($naredba);
            unset($upit);


            while ($odjel_soba = $rezultat->fetch_array()) {
                $odjeli_sobe[$brojOdjela]['sobe'][] = $odjel_soba;
            }
        }
    }
?>

<?php
    require_once 'prilozi/smarty.php';
    
    $smarty->assign('odjeli_sobe', $odjeli_sobe);
    
    $smarty->display('odjeli_sobe.tpl');
?>
