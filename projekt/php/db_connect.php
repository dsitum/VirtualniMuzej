<?php
    //klasa za izvršavanje upita nad bazom
    define("HOST", "localhost");
    define("USER", "WebDiP2012_073");
    define("PASS", "admin_hv9m");
    define("BAZA", "WebDiP2012_073");

    class Upit {
        private $conn;

        function __construct() {
            $this->conn = new mysqli(HOST, USER, PASS, BAZA);
            if ($this->conn->connect_errno) {
                die('Pogreška pri spajanju na bazu podataka. Jesu li podaci ispravno uneseni? MySQL kaže: <br>'
                    . $this->conn->connect_error);
            } 
            $this->conn->set_charset("utf8");
        }

        function Izvrsi($upit) {
            $rezultat = $this->conn->query($upit);

            if(! $rezultat) {
                die("Problem pri uonsu u bazu. MySQL kaže: <br>" . $this->conn->error);
            } else {
                return $rezultat;
            }
        }

        function __destruct() {
            $this->conn->close();
        }
    }
    
//******************************************************************************************************************//
    //Ova funkcija služi za brže izvršavanje sql upita
    function Upit($naredba) {
        $upit = new Upit();
        $rezultat = $upit->Izvrsi($naredba);
        unset($upit);
        return $rezultat;
    }
?>