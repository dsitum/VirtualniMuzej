<?php 
    session_start();
    if (isset($_SESSION["username"]))
        header("Location: odjeli_sobe.php");
    
    
    require_once('php/recaptchalib.php');
    $publickey = "6Ld14eASAAAAAN8cZVr7LHITQFb0w9PU9SlDJYgm";
    $recaptcha = recaptcha_get_html($publickey);
?>
    
<?php
    require_once 'prilozi/smarty.php';
    
    $smarty->assign('recaptcha', $recaptcha);
    
    $smarty->display('register.tpl');
?>