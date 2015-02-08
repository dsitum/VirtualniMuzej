<?php
    session_start();
    
    require_once 'db_connect.php';
    
    $pomakxml = new SimpleXMLElement("http://arka.foi.hr/PzaWeb/PzaWeb2004/config/pomak.xml",NULL,TRUE);
    $pomak = $pomakxml->vrijeme->pomak['brojSati'];
    
    //najprije praznimo tablicu vremenskih pomaka, jer u njoj smijemo imati samo jedan zapis
    Upit("TRUNCATE pomakVremena");
    $pomak *= 3600;
    
    //pohranjujemo u tablicu pomakVremena pomak u sekundama
    Upit("INSERT INTO pomakVremena VALUES ($pomak)");
    
    header("Location: ../admin.php");
?>
