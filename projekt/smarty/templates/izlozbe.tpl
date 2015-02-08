{extends file="std.tpl"}

{*{block "prethodniDir"}../{/block}*}

{block "naslov"}Izložbe muzeja{/block}

{block sadrzaj}
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.ui.js"></script>
    <link rel="stylesheet" type="text/css" href="css/jquery.ui/jquery-ui-1.10.3.custom.min.css">
    <script type="text/javascript" src="js/izlozbe.js"></script>
    
    {if $smarty.session.tip >= 2}
        <div class="okvir">
            <form method="get" action="php/uredi_sadrzaj.php">
                <input type="hidden" name="action" value="dodaj">
                <input type="hidden" name="sadrzaj" value="izlozba">
                <input type="submit" value="Stvori novu izložbu">
            </form>
        </div>
    {/if}
    
    {if count($izlozbe) == 0}
        <div class="okvir">
            Trenutno ne postoji niti jedna izložba
        </div>
    {/if}
    
    {foreach $izlozbe as $izlozba}
        {* ako je korisnik kustos ili administrator, dodajemo mogućnost dodavanja nove izložbe *}        
        <div class="okvir">
            <span class="naslov">{$izlozba.podaciIzlozbe.nazivIzlozbe}</span> 
            {* ako je korisnik kustos ili administrator, dodajemo gumbe za brisanje i uređivanje eksponata *}
            {if $smarty.session.tip >= 2}
                <a href="php/uredi_sadrzaj.php?sadrzaj=izlozba&action=uredi&brojIzlozbe={$izlozba.podaciIzlozbe.brojIzlozbe}"><img style="bottom: 15px;" src="images/sadrzajMuzeja/uredi.png" alt="Uredi izložbu"></a> <a href="php/uredi_sadrzaj.php?sadrzaj=izlozba&action=obrisi&brojIzlozbe={$izlozba.podaciIzlozbe.brojIzlozbe}"><img style="bottom: 15px;" src="images/sadrzajMuzeja/obrisi.png" alt="Obriši izložbu"></a>
            {/if} 
            <br><br>
            
            <b>Vrijeme otvaranja:</b> {$izlozba.podaciIzlozbe.vrijemeOtvaranja} <br>
            <b>Vrijeme zatvaranja:</b> {$izlozba.podaciIzlozbe.vrijemeZatvaranja} <br><br>
            
            {* ako izložba obuhvaća potpune odjele ili sobe, ispisati ih *}
            {if count($izlozba.odjeli) > 0 or count($izlozba.sobe) > 0}
                Izložba obuhvaća sve eksponate iz navedenih: <br>
            {/if}
            
            {if count($izlozba.odjeli) > 0}
                <span style="margin-left: 10px;">
                    <b>odjela:</b> 
                    {foreach $izlozba.odjeli as $odjel}
                        {$odjel.nazivOdjela}, 
                    {/foreach}
                </span>
                <br>
            {/if}
            
            {if count($izlozba.sobe) > 0}
                <span style="margin-left: 10px;">
                    <b>soba:</b> 
                    {foreach $izlozba.sobe as $soba}
                        {$soba.nazivSobe}, 
                    {/foreach}
                </span>
                <br>
            {/if}
            
            {if count($izlozba.eksponati) > 0}
                {if count($izlozba.odjeli) > 0 or count($izlozba.sobe) > 0}
                    <b>i eksponate:</b> 
                {else}
                    <b>Eskponati izložbe:</b> 
                {/if}
                <br>
                <span style="margin-left: 10px;">
                    {foreach $izlozba.eksponati as $eksponat}
                        {$eksponat.naziv}, 
                    {/foreach}
                </span>
                <br>
            {/if}
            <br>
            
            {if $izlozba.imaUlaznicu}
                <div id="posjetiIzlozbu" data-id="{$izlozba.podaciIzlozbe.brojIzlozbe}">
                    <a href="php/eksponati.php?izlozba={$izlozba.podaciIzlozbe.brojIzlozbe}">Posjeti izložbu</a> <br>
                </div>
            {else}
                <div class="kupiUlaznicu" data-id="{$izlozba.podaciIzlozbe.brojIzlozbe}">
                    <b>Cijena izložbe:</b> {$izlozba.podaciIzlozbe.cijenaIzlozbe} kn <br>
                    <a href="#">Kupi ulaznicu</a>
                </div>
            {/if}
        </div>
    {/foreach}
{/block}