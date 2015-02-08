<?php
    if (file_exists("smarty/Smarty.class.php")) {
        require_once('smarty/Smarty.class.php');
        $smarty = new Smarty();

        $smarty->setTemplateDir('smarty/templates');
        $smarty->setCompileDir('smarty/templates_c');
        $smarty->setCacheDir('smarty/cache');
        $smarty->setConfigDir('smarty/configs');
    } else {
        require_once('../smarty/Smarty.class.php');
        $smarty = new Smarty();

        $smarty->setTemplateDir('../smarty/templates');
        $smarty->setCompileDir('../smarty/templates_c');
        $smarty->setCacheDir('../smarty/cache');
        $smarty->setConfigDir('../smarty/configs');
    }
?>
