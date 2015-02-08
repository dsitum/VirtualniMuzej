<!DOCTYPE HTML>
<html>
    <head>
        <meta charset="utf-8">
        {block "customNaslov"}{/block}
        <title>{block "naslov"}{/block}</title>
        {block meta}{/block}
        {block skripte}{/block}
        <link rel="stylesheet" type="text/css" href="{block "prethodniDir"}{/block}css/style.css">
    </head>
    <body class="standard">
        <span>Dobrodošli 
        {if isset($smarty.session.username)}
            <b><a href="{block "prethodniDir"}{/block}php/uredi_korisnika.php?id={$smarty.session.idKorisnika}">{$smarty.session.username}</a></b><br>
            <a href='{block "prethodniDir"}{/block}php/ulogiraj_se.php?logout=1'>Odjava</a>
        {else}
            <b>Gost</b>. <br>
            <a href='{block "prethodniDir"}{/block}login.php'>Prijava</a> / 
            <a href='{block "prethodniDir"}{/block}register.php'>Registracija</a>
        {/if}
        </span>
        
        <header id="zaglavlje">
            <h1>{block "naslov"}{/block}</h1>
        </header>
        
        <aside class="izbornik">
            <ul>
                <li><a href="{block "prethodniDir"}{/block}odjeli_sobe.php">Odjeli i sobe muzeja</a></li>
                {if $smarty.session.tip > 0}
                    <li><a href="{block "prethodniDir"}{/block}php/eksponati.php?osobnaGalerija={$smarty.session.idKorisnika}">Osobna Galerija</a></li>
                    <li><a href="{block "prethodniDir"}{/block}izlozbe.php">Izložbe</a></li>
                {/if}
                <li><a href="{block "prethodniDir"}{/block}najpopularnije.php">Najpopularnije</a></li>
                <li><a href="{block "prethodniDir"}{/block}privatno/korisnici.php">Popis korisnika (privatno)</a></li>
                
                {if $smarty.session.tip == 3} {* ako se radi o Administratoru, dodaj u izbornik njegovu opciju *}
                    <li><a href="{block "prethodniDir"}{/block}admin.php">ADMIN</a></li>
                {/if}
            </ul>
        </aside>
        
        <div id="{block wrapperID}register{/block}" class="{block klasa}{/block}">

        {block "sadrzaj"}{/block}    
            
        </div>
        
        {block "dodatniDiv"}{/block}
        
        <footer id="{block footerID}podnozje{/block}">
            <p>
                Copyright © Virtualni muzej 2013 <br>
                Sva prava pridržana <br>
                Niti jedan dio ove stranice ne smije biti redistribuiran <br>
                na drugim mjestima bez izričitog dopuštenja Virtualnog muzeja.
            </p>
        </footer>
        
        {block dodatneSkripte}{/block}
    </body>
</html>
