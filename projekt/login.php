<?php
    session_start();
    if (isset($_SESSION["username"])) {
        header("Location: ispis_korisnika.php");
    }
?>

<?php
    require_once 'prilozi/smarty.php';
    
    if (isset($_COOKIE['username'])) {
        $username = $_COOKIE['username'];
        $smarty->assign("username", $username);
        $smarty->assign("checked", "checked");
    }
    
    $smarty->display("login.tpl");       
?>