{extends file="std.tpl"}

{*{block "prethodniDir"}../{/block}*}
{block "naslov"}Admin panel{/block}
{block klasa}okvir centar{/block}

{block "sadrzaj"}
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.ui.js"></script>
    <link rel="stylesheet" type="text/css" href="css/jquery.ui/jquery-ui-1.10.3.custom.min.css">
    <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/dataTables/jquery.dataTables.css">
    <script type="text/javascript" src="js/admin.js"></script>
    
    {if $smarty.session.tip != 3}
        Ovoj rubrici ima pristup samo administrator!
    {else}
        Ukupan broj korisnika: {$ukupan_broj} (smeđe) <br>
        Broj neaktiviranih: {$broj_neaktiviranih} (crveno) <br>
        Broj zaključanih: {$broj_zakljucanih} (narančasto) <br><br>

        <canvas id="korisnici" width="200" height="300"></canvas>
        <script>
            var platno = document.getElementById("korisnici");
            var ctx = platno.getContext("2d");
            ctx.strokeStyle = "#FFF";
            ctx.strokeRect(0,0,200,300);
            ctx.fillStyle = "#78081B";
            ctx.fillRect(15,9,50,290);
            ctx.fillStyle = "#E61732";
            ctx.fillRect(75,{$yoffset_neaktivnih},50,{$visina_neaktivnih});
            ctx.fillStyle = "#E86F0C";
            ctx.fillRect(135,{$yoffset_zakljucanih},50,{$visina_zakljucanih});
        </script>
        <br><br>

        <a href="http://arka.foi.hr/PzaWeb/PzaWeb2004/config/vrijeme.html">Link na stranicu za pomak vremena</a>
        <br><br>

        <a href='php/pomak_vrememena.php'>Pomakni vrijeme</a>

        <br><br>
        
        <a id="pregledajLog" href="#">Pregledaj dnevnik / log zapisa</a> <br><br>
        <div id="LogZapisa"></div>
        
        <a id="pregledajKorisnike" href="#">Uvid u korisnike sustava</a>
        <div id="PopisKorisnika"></div>
    {/if}
{/block}