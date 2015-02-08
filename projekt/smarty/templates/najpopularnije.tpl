{extends file="std.tpl"}

{*{block "prethodniDir"}../{/block}*}

{block "naslov"}Najpopularniji sadržaji{/block}
        
{block "sadrzaj"}
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.ui.js"></script>
    <link rel="stylesheet" type="text/css" href="css/jquery.ui/jquery-ui-1.10.3.custom.min.css">
    <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/dataTables/jquery.dataTables.css">
    <script type="text/javascript" src="js/jRating/jRating.jquery.js"></script>
    <link rel="stylesheet" type="text/css" href="js/jRating/jRating.jquery.css">
    <script type="text/javascript" src="js/jNotify/jNotify.jquery.js"></script>
    <link rel="stylesheet" type="text/css" href="js/jNotify/jNotify.jquery.css">
    <script type="text/javascript" src="js/jPages/jPages.min.js"></script>
    <link rel="stylesheet" type="text/css" href="js/jPages/css/jPages.css">
    <link rel="stylesheet" type="text/css" href="js/jPages/css/animate.min.css">
    <link rel="stylesheet" type="text/css" href="js/highslide/highslide.css">
        <script type="text/javascript" src="js/highslide/highslide-with-gallery.js"></script>
        <script type="text/javascript">
            hs.graphicsDir = 'js/highslide/graphics/',
            hs.maxWidth = 800;
            hs.outlineType = 'outer-glow';
            hs.transitions = ['expand', 'crossfade'];
            hs.align = "center";
            hs.addSlideshow({
                repeat: true,
                useControls: true,
                fixedControls: true,
                overlayOptions: {
                        opacity: .6,
                        position: 'bottom right',
                        hideOnMouseOut: true
                }
            });
        </script>

    {* Skripta za funkcioniranje jednog dijela stranice vezanog za eksponate (ajax i ostalo) *}
    <script type="text/javascript" src="js/eksponati.js"></script>
    {* skripta za funkcioniranje košarice *}
    <script type="text/javascript" src="js/kosarica_lib.js"></script>
    {* skripta vezana za funkcioniranje dijela stranice vezanog uz odjele i sobe *}
    <script type="text/javascript" src="js/najpopularnije.js"></script>
    
    <noscript>
        <div id="noJavaScript" class="okvir">
            Za potpuni prikaz sadržaja ove stranice potrebno je uključiti javascript
        </div>
    </noscript>


    
    {* Odabir onoga čega ćemo prikazivati (uz pomoć radio buttons) *}
    <div id="odabirNajpopularnijeg" class="okvir">
        <div style="float:left; width:300px;">
            Najpopularniji: <br>
            <input type="radio" name="sadrzaj" value="eksponati" checked>Eksponati
            <input type="radio" name="sadrzaj" value="sobe">Sobe
            <input type="radio" name="sadrzaj" value="odjeli">Odjeli <br>
        </div>
        
        <div style="margin-left:300px;">
            Prema: <br>
            <input type="radio" name="sortiranje" value="posjecenost" checked>Posjećenosti
            <input type="radio" name="sortiranje" value="ocjena">Ocjeni
        </div>
    </div>
    
    
    {* okvir za jPages plugin (straničenje) *}
    <div id="stranice" class="holder desno okvir"></div>
    
    <div id="sadrzaji"></div> 
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