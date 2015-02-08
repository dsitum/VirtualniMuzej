<?php
    session_start();
    if (!isset($_SESSION['tip']))
		$_SESSION['tip']= 0;
    header("Location: odjeli_sobe.php");
?>