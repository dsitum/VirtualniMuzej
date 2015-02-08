{extends file="../std.tpl"}

{block "prethodniDir"}../{/block}

{block customNaslov}
    {if isset($smarty.get.soba)}
        {$naslov="Eksponati sobe {$smarty.get.soba}" scope=parent}
    {/if}
{/block}

{block "naslov"}{$naslov}{/block}
        
{block "sadrzaj"}
        <script type="text/javascript" src="../js/jquery.min.js"></script>
        <script type="text/javascript" src="../js/jquery.ui.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/jquery.ui/jquery-ui-1.10.3.custom.min.css">
        <script type="text/javascript" src="../js/jquery.dataTables.min.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/dataTables/jquery.dataTables.css">
        <script type="text/javascript" src="../js/jRating/jRating.jquery.js"></script>
        <link rel="stylesheet" type="text/css" href="../js/jRating/jRating.jquery.css">
        <script type="text/javascript" src="../js/jNotify/jNotify.jquery.js"></script>
        <link rel="stylesheet" type="text/css" href="../js/jNotify/jNotify.jquery.css">
        <script type="text/javascript" src="../js/jPages/jPages.min.js"></script>
        <link rel="stylesheet" type="text/css" href="../js/jPages/css/jPages.css">
        <link rel="stylesheet" type="text/css" href="../js/jPages/css/animate.min.css">
        <script type="text/javascript" src="https://apis.google.com/js/plusone.js" async=true></script>     <!-- Potrebno za google share link -->
        <link rel="stylesheet" type="text/css" href="../js/highslide/highslide.css">
        <script type="text/javascript" src="../js/highslide/highslide-with-gallery.js"></script>
        <script type="text/javascript">
            hs.graphicsDir = '../js/highslide/graphics/',
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
        
        {* skripta za funkcioniranje košarice *}
        <script type="text/javascript" src="../js/kosarica_lib.js"></script>
        {* Skripta za funkcioniranje stranice (ajax i ostalo) *}
        <script type="text/javascript" src="../js/eksponati.js"></script>
        
        <noscript>
            <div id="noJavaScript" class="okvir">
                Za potpuni prikaz sadržaja ove stranice potrebno je uključiti javascript
            </div>
        </noscript>
    
        
        
        {* okvir za jPages plugin (straničenje) *}
        {if !is_null($eksponati) }
            <div id="stranice" class="holder desno okvir"></div>
        {/if}
            
        {* ako se radi o osobnoj galeriji, dodat ćemo na div s eksponatima dodatnu klasu. Ona će koristiti da se eksponati virtualno uklone s ekrana kada pregledamo osobnu galeriju i kad ih uklonimo iz galerije *}
        {if !is_null($smarty.get.osobnaGalerija)}
            {$dodatnaKlasa = 'osobnaGalerija'}
        {/if}
        

        <div id="eksponati" class="{$dodatnaKlasa}">
        {foreach $eksponati as $eksponat}
            <div class="okvir s{$eksponat.idEksponata}">
                <div class="podaciOEksponatu">
                    <span class="naslov">{$eksponat.naziv}</span>
                    {* ako je korisnik kustos ili administrator, dodajemo gumbe za brisanje i uređivanje eksponata *}
                    {if $smarty.session.tip > 2}
                        <a href="uredi_sadrzaj.php?sadrzaj=eksponat&action=uredi&idEksponata={$eksponat.idEksponata}"><img style="vertical-align: middle;" src="../images/sadrzajMuzeja/uredi.png" alt="Uredi eksponat"></a> <a href="uredi_sadrzaj.php?sadrzaj=eksponat&action=obrisi&idEksponata={$eksponat.idEksponata}"><img style="vertical-align: middle;" src="../images/sadrzajMuzeja/obrisi.png" alt="Obriši eksponat"></a>
                    {/if} 
                    <br><br>

                    {if !is_null($eksponat.godinaPorijekla)}
                        <b>Godina porijekla:</b> {$eksponat.godinaPorijekla} 
                        {if $eksponat.prijeKrista == 1}
                            pr. Kr.
                        {/if}
                        <br>
                    {/if}

                    {if !is_null($eksponat.opisEksponata)}
                        <b>Opis eksponata: </b> {$eksponat.opisEksponata} <br>
                    {/if}

                    {if !is_null($eksponat.OAutoru)}
                        <b>Više o autoru:</b> <br>
                        <a href={$eksponat.OAutoru} target="_blank">{$eksponat.OAutoru}</a> <br>
                    {/if}

                    {if !is_null($eksponat.Orazdoblju)}
                        <b>Više o razdoblju:</b> <br>
                        <a href={$eksponat.Orazdoblju} target="_blank">{$eksponat.Orazdoblju}</a> <br>
                    {/if}

                    <br>
                    <b>Ocjena:</b> <div class="ProsjecnaOcjena s{$eksponat.idEksponata}" data-average="" data-id="{$eksponat.idEksponata}"></div>       {* data-id je atribut plugina jRating. U ovom slučaju će mi označavati ID eksponata *}
                    <div class="KorisnikovaOcjena s{$eksponat.idEksponata}"></div>

                    {* ako je prva ključna riječ različita od NULL (tj ako bilo kakva ključna riječ postoji), ispiši sve ključne riječi *}
                    {if $eksponat.kljucneRijeci.0 != NULL}
                        <b>Ključne riječi:</b> 
                        {foreach $eksponat.kljucneRijeci as $kljucnaRijec}
                            <a href="eksponati.php?kljucnaRijec={$kljucnaRijec}">{$kljucnaRijec}</a> 
                        {/foreach}
                        <br>
                    {/if}

                    <b>Broj pregleda:</b> {$eksponat.brojPregleda}
                    <div class="BrojKomentara s{$eksponat.idEksponata}"></div>
                    <div class="ProzorSKomentarima s{$eksponat.idEksponata}"></div>

                    <br>
                    <div class="OsobnaGalerija s{$eksponat.idEksponata}"></div>
                </div>

                <div class="slikaEksponata">
                    <a href="../slike/{$eksponat.slika}" class="highslide" onclick="return hs.expand(this)"><img src="../slike/thumbs/{$eksponat.slika}" alt="eksponat"></a>
                </div>
            </div>
        {/foreach}
        </div>
        
        
        {* ako nije pronađen niti jedan eksponat u sobi ili odjelu, ispisat ćemo poruku *}
        {if is_null($eksponati)}
            <div class="okvir">U odabranoj kategoriji nema eksponata 
                {if $smarty.session.tip == 1 or !isset($smarty.session.tip)}
                    ili su skriveni
                {/if}
            </div>
        {/if}


        {if isset($smarty.get.osobnaGalerija)}
            <div class="okvir">
                Podijelite vašu galeriju na društvenim mrežama: <br><br>

                <!-- Facebook dugme -->
                <a href="http://www.facebook.com/sharer.php?s=100&p[url]=http://{$smarty.server.SERVER_NAME}{$smarty.server.REQUEST_URI}&p[images][0]=http://s14.postimg.org/679f82x1p/image.png&p[title]=Virtualni muzej&p[summary]=Moja galerija virtualnog muzeja. Postani član virtualnog muzeja i ti">
                    <img src="../images/osobnaGalerija/fb.png" alt="Podijeli na Facebooku">
                </a>

                <!-- Google plus dugme -->
                <div class="g-plus" data-action="share" data-height="55"></div>
            </div>
        {/if}
        
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