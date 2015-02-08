<?php
$aResponse['error'] = false;
$aResponse['message'] = '';
	
	
if(isset($_POST['action']))
{
	if($_POST['action'] == 'rating')
	{
		/*
		* vars
		*/
		$id = intval($_POST['idBox']);
		$rate = floatval($_POST['rate']);
		
                
                
                
                //***********************************************************************************************
                
		// YOUR MYSQL REQUEST HERE or other thing :)        // unos ocjene u bazu podataka / ažuriranje postojeće ocjene
                session_start();
                require_once '../../../php/db_connect.php';
                require_once '../../../php/biljezenje_lib.php';
                
                //je li korisnik već glasao?
                $naredba = "SELECT * FROM ocjene WHERE korisnik = {$_SESSION['idKorisnika']} AND eksponat = $id";
		$rezultat = Upit($naredba);
                
                //dohvaćamo naziv eksponata iz ID-a kako bi ga mogli unijeti u dnevnik
                $rezultatPodupit = Upit("SELECT naziv FROM eksponati WHERE idEksponata = $id");
                $nazivEksponata = $rezultatPodupit->fetch_assoc();
		
                if (mysqli_num_rows($rezultat) == 1) {
                    $ocjena = $rate / 100;
                    $naredba = "UPDATE ocjene SET ocjena = $ocjena, datumOcjenjivanja = '" . VrijemeSPomakom() . "' WHERE korisnik = {$_SESSION['idKorisnika']} AND eksponat = $id";
                    Upit($naredba);
                    UpisiUDnevnik("Promijenio vlastitu ocjenu eksponata \"{$nazivEksponata['naziv']}\" u novu ocjenu: $ocjena");
                } else {
                    $ocjena = $rate / 100;
                    $naredba = "INSERT INTO ocjene (korisnik, eksponat, ocjena, datumOcjenjivanja) VALUES ({$_SESSION['idKorisnika']}, $id, $ocjena, '". VrijemeSPomakom() ."')";
                    Upit($naredba);
                    UpisiUDnevnik("Dodao novu ocjenu ($ocjena) na eksponat ({$nazivEksponata['naziv']})");
                }            
                
                // END OF MYSQL REQUEST
                
                //***********************************************************************************************    
                    
		// if request successful
		$success = true;
		// else $success = false;
		
		
		// json datas send to the js file
		if($success)
		{
			$aResponse['message'] = 'Your rate has been successfuly recorded. Thanks for your rate :)';
			
			echo json_encode($aResponse);
		}
		else
		{
			$aResponse['error'] = true;
			$aResponse['message'] = 'An error occured during the request. Please retry';
			
			
			echo json_encode($aResponse);
		}
	}
	else
	{
		$aResponse['error'] = true;
		$aResponse['message'] = '"action" post data not equal to \'rating\'';
			
		
		echo json_encode($aResponse);
	}
}
else
{
	$aResponse['error'] = true;
	$aResponse['message'] = '$_POST[\'action\'] not found';
	
	
	echo json_encode($aResponse);
}