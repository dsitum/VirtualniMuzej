{extends file="std.tpl"}

{*{block "prethodniDir"}../{/block}*}

{block "naslov"}Odjeli muzeja s pripadajućim sobama{/block}

{block "sadrzaj"}
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.ui.js"></script>
    <link rel="stylesheet" type="text/css" href="css/jquery.ui/jquery-ui-1.10.3.custom.min.css">
    {* skripta za funkcioniranje košarice *}
    <script type="text/javascript" src="js/kosarica_lib.js"></script>
    {* za prikaz košarice upisujemo ovo u novi script blok *}
    <script type="text/javascript">
        $(document).ready(function() {
            DodajEventeNaPostojeceSuvenireUSesiji();
            DodajEventZaGumbKupi();
        });
    </script>
    {* u skrpti ispod implementirat ćemo dialog kada se klikne na neku od soba. Tu će se moći odabrati eksponat za prikaz *}
    <script type="text/javascript" src="js/odjeli_sobe.js"></script>
    
    
    <div class="okvir">
        {foreach $odjeli_sobe as $odjel}
            {* ako je tip korisnika administrator ili kustos (tip >= 2), on može pregledavati sve odjele. Ako je tip korisnika registrirani korisnik, on može pregledavati samo one odjele koji imaju vidljivost <= 1 (normalnu ili javnu). U suprotnom (ako je korisnik neregistrirani, moći će pregledavati samo javne odjele (vidljivost = 0) *}
            {if $smarty.session.tip >= 2 && $odjel.vidljivostOdjela <= 2       ||      $smarty.session.tip == 1 && $odjel.vidljivostOdjela <= 1      ||      $odjel.vidljivostOdjela == 0}
                <a class="prikaziEksponateUOdjelu" href="#" data-id="{$odjel.brojOdjela}"><b>{$odjel.nazivOdjela}</b></a>
                ({$odjel.opisOdjela}) 
                
                {* ako je korisnik kustos ili administrator, dodajemo gumbe za brisanje i uređivanje odjela *}
                {if $smarty.session.tip >= 2}
                    <a href="php/uredi_sadrzaj.php?sadrzaj=odjel&action=uredi&brojOdjela={$odjel.brojOdjela}"><img style="vertical-align: middle;" src="images/sadrzajMuzeja/uredi.png" alt="Uredi odjel"></a> <a href="php/uredi_sadrzaj.php?sadrzaj=odjel&action=obrisi&brojOdjela={$odjel.brojOdjela}"><img style="vertical-align: middle;" src="images/sadrzajMuzeja/obrisi.png" alt="Obriši odjel"></a>
                {/if}
                <br>
                
                <ul>
                {foreach $odjel.sobe as $soba}
                    {* isto kao i ono gore, samo što se ovdje provjerava za sobe *}
                    {if $smarty.session.tip >= 2 && $soba.vidljivostSobe <= 2       ||      $smarty.session.tip == 1 && $soba.vidljivostSobe <= 1      ||      $soba.vidljivostSobe == 0}   
                        <li>
                            <a class="prikaziEksponateUSobi" href="#" data-id="{$soba.brojSobe}">{$soba.nazivSobe}</a>
                            
                            {* ako je korisnik kustos ili administrator, dodajemo gumbe za brisanje i uređivanje soba *}
                            {if $smarty.session.tip >= 2}
                                <a href="php/uredi_sadrzaj.php?sadrzaj=soba&action=uredi&brojSobe={$soba.brojSobe}"><img style="vertical-align: middle;" src="images/sadrzajMuzeja/uredi.png" alt="Uredi odjel"></a> <a href="php/uredi_sadrzaj.php?sadrzaj=soba&action=obrisi&brojSobe={$soba.brojSobe}"><img style="vertical-align: middle;" src="images/sadrzajMuzeja/obrisi.png" alt="Obriši odjel"></a>
                            {/if}
                        </li>
                    {/if}
                {/foreach}
                </ul> 
                <br>
            {/if}
        {/foreach}
        
        {* ako je korisnik kustos ili administrator, dodajemo 3 nova gumba za stvaranje odjela, soba i eksponata *}
        {if $smarty.session.tip >= 2}
            <form style="display: inline-block;" method="get" action="php/uredi_sadrzaj.php">
                <input type="hidden" name="action" value="dodaj">
                <input type="hidden" name="sadrzaj" value="odjel">
                <input type="submit" name="dodajOdjel" value="Dodaj odjel">
            </form>
            
            <form style="display: inline-block;" method="get" action="php/uredi_sadrzaj.php">
                <input type="hidden" name="action" value="dodaj">
                <input type="hidden" name="sadrzaj" value="soba">
                <input type="submit" value="Dodaj sobu">
            </form>
            
            <form style="display: inline-block;" method="get" action="php/uredi_sadrzaj.php">
                <input type="hidden" name="action" value="dodaj">
                <input type="hidden" name="sadrzaj" value="eksponat">
                <input type="submit" value="Dodaj eksponat">
            </form>
        {/if}
    </div>
{/block}


{block "dodatniDiv"}
    <div id="kosarica">
        <table>
            <thead>
                {if isset($smarty.session.kosarica)}
                    {$brojStavki={$smarty.session.kosarica.brojStavki}}
                    {$ukupnaCijena={$smarty.session.kosarica.ukupnaCijena}}
                {else}
                    {$brojStavki=0}
                    {$ukupnaCijena=0}
                {/if}
                <th colspan="3"><b>Košarica</b> (<span id="brojStavki">{$brojStavki}</span> stavki)</th>
            </thead>
            
            <tbody>
                {if isset($smarty.session.kosarica)}
                    {foreach $smarty.session.kosarica.stavke as $suvenir}
                        <tr id="SuvenirUKosarici{$suvenir.idSuvenira}" data-id="{$suvenir.idSuvenira}">
                            <td style="width: 15%;"><input type="text" size="1" value="{$suvenir.kolicinaSuvenira}"></td>
                            <td style="width: 65%;"><b>{$suvenir.nazivSuvenira}</b></td>
                            <td>
                                <b><span class="cijenaSuvenira">{$suvenir.cijenaSuvenira}</span> kn</b> <br>
                                <a class="UkloniIzKosarice" href="#">Ukloni</a>
                            </td>
                        </tr>
                    {/foreach}
                {/if}
            </tbody>
            
            <tfoot>
                <tr>
                    <td colspan="2">Ukupno: <b><span id="ukupnaCijena">{$ukupnaCijena}</span> kn</b></td>
                    <td><input type="button" value="Kupi"></td>
                </tr>
            </tfoot>
        </table>
    </div>
{/block}