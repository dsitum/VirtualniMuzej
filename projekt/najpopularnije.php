<?php
    session_start();
    
    require_once 'prilozi/smarty.php';
    
    $smarty->assign('sadrzaji', $sadrzaji);
    
    $smarty->display('najpopularnije.tpl');
?>