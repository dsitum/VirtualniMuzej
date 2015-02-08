{extends file="../std.tpl"}

{block "prethodniDir"}../{/block}

{block customNaslov}
    {if $smarty.get.action == 'dodaj'}
        {if $smarty.get.sadrzaj == 'odjel'}
            {$naslov="Dodavanje novog odjela" scope=parent}
        {/if}
        
        {if $smarty.get.sadrzaj == 'soba'}
            {$naslov="Dodavanje nove sobe" scope=parent}
        {/if}
        
        {if $smarty.get.sadrzaj == 'eksponat'}
            {$naslov="Dodavanje novog eksponata" scope=parent}
        {/if}
        
        {if $smarty.get.sadrzaj == 'izlozba'}
            {$naslov="Dodavanje nove izložbe" scope=parent}
        {/if}
    {/if}    
    
    {if $smarty.get.action == 'uredi'}
        {if $smarty.get.sadrzaj == 'odjel'}
            {$naslov="Uređivanje odjela" scope=parent}
        {/if}
        
        {if $smarty.get.sadrzaj == 'soba'}
            {$naslov="Uređivanje sobe" scope=parent}
        {/if}
        
        {if $smarty.get.sadrzaj == 'eksponat'}
            {$naslov="Uređivanje eksponata" scope=parent}
        {/if}
        
        {if $smarty.get.sadrzaj == 'izlozba'}
            {$naslov="Uređivanje izložbe" scope=parent}
        {/if}
    {/if}

    {if $smarty.get.action == 'obrisi'}
        {if $smarty.get.sadrzaj == 'odjel'}
            {$naslov="Brisanje odjela" scope=parent}
        {/if}
        
        {if $smarty.get.sadrzaj == 'soba'}
            {$naslov="Brisanje sobe" scope=parent}
        {/if}
        
        {if $smarty.get.sadrzaj == 'eksponat'}
            {$naslov="Brisanje eksponata" scope=parent}
        {/if}
        
        {if $smarty.get.sadrzaj == 'izlozba'}
            {$naslov="Brisanje izložbe" scope=parent}
        {/if}
    {/if}
{/block}

{block "naslov"}{$naslov}{/block}
{*{block klasa}okvir{/block}*}

{block "sadrzaj"}
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.ui.js"></script>

    <div class="okvir">
        {if $smarty.get.action == 'dodaj' || $smarty.get.action == 'uredi'}
            {if $smarty.get.sadrzaj == 'odjel'}
                <form method="post" action="">
                    <table>
                        <tr>
                            <td>Naziv odjela:</td>
                            <td><input type="text" name="nazivOdjela" value="{$odjel.nazivOdjela}" required size="30" maxlength="45" autofocus></td>
                        </tr>
                        
                        <tr>
                            <td>Opis odjela:</td>
                            <td><textarea rows="5" cols="30" name="opisOdjela" required>{$odjel.opisOdjela}</textarea></td>
                        </tr>
                        
                        <tr>
                            <td>Vidljivost odjela:</td>
                            <td>
                                {if $odjel.vidljivostOdjela == 0}
                                    <input type="radio" name="vidljivostOdjela" value="0" checked>Javno <br>
                                    <input type="radio" name="vidljivostOdjela" value="1">Samo registrirani korisnici <br>
                                    <input type="radio" name="vidljivostOdjela" value="2">Privatno
                                {/if}
                                
                                {if $odjel.vidljivostOdjela == 1}
                                    <input type="radio" name="vidljivostOdjela" value="0">Javno <br>
                                    <input type="radio" name="vidljivostOdjela" value="1" checked>Samo registrirani korisnici <br>
                                    <input type="radio" name="vidljivostOdjela" value="2">Privatno
                                {/if}
                                
                                {if $odjel.vidljivostOdjela == 2}
                                    <input type="radio" name="vidljivostOdjela" value="0">Javno <br>
                                    <input type="radio" name="vidljivostOdjela" value="1">Samo registrirani korisnici <br>
                                    <input type="radio" name="vidljivostOdjela" value="2" checked>Privatno
                                {/if}
                            </td>
                        </tr>
                        
                        <tr>
                            <td colspan="2">
                                <input type="submit" value="Pohrani promjene">
                            </td>
                        </tr>
                    </table>
                    
                    {* ovo polje govori da u bazi treba ažurirati zapis ili ga dodati (uređivanje ili dodavanje, ovisno o parametru koji smo primili kroz GET kad se obrazac učitavao) *}
                    <input type="hidden" name="action" value="{$smarty.get.action}">
                    {* ovo nam polje govori o kakvom se obrascu radi (odjeli, sobe, eksponati), budući da se svi oni šalju na isto mjesto *}
                    <input type="hidden" name="sadrzaj" value="odjel">
                    {* ovdje još šaljemo id odjela kako bi prema tom podatku znali koji ćemo odjel promijeniti / dodati u bazu *}
                    <input type="hidden" name="brojOdjela" value="{$odjel.brojOdjela}">
                </form>
            {/if}

            
            {if $smarty.get.sadrzaj == 'soba'}
                <form method="post" action="">
                    <table>
                        <tr>
                            <td>Naziv sobe:</td>
                            <td><input type="text" name="nazivSobe" value="{$soba.nazivSobe}" required size="30" maxlength="50" autofocus></td>
                        </tr>
                        
                        <tr>
                            <td>Odjel kojem pripada:</td>
                            <td>
                                <select name="Odjel">
                                    {foreach $odjeli as $odjel}
                                        <option name="Odjel" value="{$odjel.brojOdjela}" {if $odjel.brojOdjela == $soba.Odjel}selected{/if}>{$odjel.nazivOdjela}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        
                        <tr>
                            <td>Vidljivost sobe:</td>
                            <td>
                                {if $soba.vidljivostSobe == 0}
                                    <input type="radio" name="vidljivostSobe" value="0" checked>Javno <br>
                                    <input type="radio" name="vidljivostSobe" value="1">Samo registrirani korisnici <br>
                                    <input type="radio" name="vidljivostSobe" value="2">Privatno
                                {/if}
                                
                                {if $soba.vidljivostSobe == 1}
                                    <input type="radio" name="vidljivostSobe" value="0">Javno <br>
                                    <input type="radio" name="vidljivostSobe" value="1" checked>Samo registrirani korisnici <br>
                                    <input type="radio" name="vidljivostSobe" value="2">Privatno
                                {/if}
                                
                                {if $soba.vidljivostSobe == 2}
                                    <input type="radio" name="vidljivostSobe" value="0">Javno <br>
                                    <input type="radio" name="vidljivostSobe" value="1">Samo registrirani korisnici <br>
                                    <input type="radio" name="vidljivostSobe" value="2" checked>Privatno
                                {/if}
                            </td>
                        </tr>
                        
                        <tr>
                            <td colspan="2">
                                <input type="submit" value="Pohrani promjene">
                            </td>
                        </tr>
                    </table>
                            
                    {* ovo polje govori da u bazi treba ažurirati zapis ili ga dodati (uređivanje ili dodavanje, ovisno o parametru koji smo primili kroz GET kad se obrazac učitavao) *}
                    <input type="hidden" name="action" value="{$smarty.get.action}">
                    {* ovo nam polje govori o kakvom se obrascu radi (odjeli, sobe, eksponati), budući da se svi oni šalju na isto mjesto *}
                    <input type="hidden" name="sadrzaj" value="soba">
                    {* ovdje još šaljemo id sobe kako bi prema tom podatku znali koju ćemo sobu promijeniti / dodati u bazu *}
                    <input type="hidden" name="brojSobe" value="{$soba.brojSobe}">
                </form>
            {/if}

            
            {if $smarty.get.sadrzaj == 'eksponat'}
                <form method="post" action="" enctype="multipart/form-data">
                    <table>
                        <tr>
                            <td>Naziv eksponata:</td>
                            <td><input type="text" name="naziv" value="{$eksponat.naziv}" required size="30" maxlength="50" autofocus></td>
                        </tr>
                        
                        <tr>
                            <td>Opis eksponata:</td>
                            <td><textarea rows="5" cols="30" name="opisEksponata" required>{$eksponat.opisEksponata}</textarea></td>
                        </tr>
                        
                        <tr>
                            <td>Godina porijekla:</td>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <input type="text" name="godinaPorijekla" value="{$eksponat.godinaPorijekla}" size="5" maxlength="10">
                                        </td>
                                            
                                        <td>pr. Kr.:</td>
                                        <td>
                                            {if $eksponat.prijeKrista == 0}
                                                <input type="radio" name="prijeKrista" value="0" checked>Ne <br>
                                                <input type="radio" name="prijeKrista" value="1">Da
                                            {/if}

                                            {if $eksponat.prijeKrista == 1}
                                                <input type="radio" name="prijeKrista" value="0">Ne <br>
                                                <input type="radio" name="prijeKrista" value="1" checked>Da
                                            {/if}
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        
                        <tr>
                            <td>Slika eksponata:</td>
                            <td>
                                {* Dodati plugin jquery file upload. POSTAVITI NA REQUIRED *}
                                <input type="hidden" name="MAX_FILE_SIZE" value="5242880">  <!--5MB-->
                                
                                {* ako dodajemo novi eksponat, ovo polje je obavezno. U suprotnom, ako uređujemo postojeći eksponat, ovo polje nije obavezno, tj. ne moramo unijeti sliku jer ona već postoji *}
                                {if $smarty.get.action == 'dodaj'}
                                    <input type="file" name="slika" required>
                                {else}
                                    <input type="file" name="slika">
                                {/if}
                                
                                {if {$eksponat.slika} != ''}
                                    <br> Trenutna slika: 
                                    <img style="vertical-align: middle; margin-top: 5px;" src="../slike/thumbs/{$eksponat.slika}" width="50" alt="{$eksponat.naziv}">
                                {/if}
                                
                                {* U skriveno polje dodajemo ime stare slike. Ako je ono prazno, znači da stara slika ne postoji i da korisnik mora uploadati novu sliku za  *}
                                <input type="hidden" name="staraSlika" value="{$eksponat.slika}">
                            </td>
                        </tr>
                        
                        <tr>
                            <td>Soba kojoj pripada:</td>
                            <td>
                                <select name="soba">
                                    {foreach $sobe as $soba}
                                        <option name="soba" value="{$soba.brojSobe}" {if $soba.brojSobe == $eksponat.soba}selected{/if}>{$soba.nazivSobe}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        
                        <tr>
                            <td>Više o autoru:</td>
                            <td><textarea rows="5" cols="30" name="OAutoru">{$eksponat.OAutoru}</textarea></td>
                        </tr>
                        
                        <tr>
                            <td>Više o razdoblju:</td>
                            <td><textarea rows="5" cols="30" name="Orazdoblju">{$eksponat.Orazdoblju}</textarea></td>
                        </tr>
                        
                        <tr>
                            <td>Ključne riječi <br> (odvojene zarezom bez razmaka):</td>
                            <td><textarea rows="5" cols="30" name="kljucneRijeci">{$eksponat.kljucneRijeci}</textarea></td>
                        </tr>
                        
                        <tr>
                            <td>Vidljivost eksponata:</td>
                            <td>
                                {if $eksponat.vidljivostEksponata == 0}
                                    <input type="radio" name="vidljivostEksponata" value="0" checked>Javno <br>
                                    <input type="radio" name="vidljivostEksponata" value="1">Samo registrirani korisnici <br>
                                    <input type="radio" name="vidljivostEksponata" value="2">Privatno
                                {/if}
                                
                                {if $eksponat.vidljivostEksponata == 1}
                                    <input type="radio" name="vidljivostEksponata" value="0">Javno <br>
                                    <input type="radio" name="vidljivostEksponata" value="1" checked>Samo registrirani korisnici <br>
                                    <input type="radio" name="vidljivostEksponata" value="2">Privatno
                                {/if}
                                
                                {if $eksponat.vidljivostEksponata == 2}
                                    <input type="radio" name="vidljivostEksponata" value="0">Javno <br>
                                    <input type="radio" name="vidljivostEksponata" value="1">Samo registrirani korisnici <br>
                                    <input type="radio" name="vidljivostEksponata" value="2" checked>Privatno
                                {/if}
                            </td>
                        </tr>
                        
                        <tr>
                            <td colspan="2">
                                <input type="submit" value="Pohrani promjene">
                            </td>
                        </tr>
                    </table>
                            
                    {* ovo polje govori da u bazi treba ažurirati zapis ili ga dodati (uređivanje ili dodavanje, ovisno o parametru koji smo primili kroz GET kad se obrazac učitavao) *}
                    <input type="hidden" name="action" value="{$smarty.get.action}">
                    {* ovo nam polje govori o kakvom se obrascu radi (odjeli, sobe, eksponati), budući da se svi oni šalju na isto mjesto *}
                    <input type="hidden" name="sadrzaj" value="eksponat">
                    {* ovdje još šaljemo id sobe kako bi prema tom podatku znali koju ćemo sobu promijeniti / dodati u bazu *}
                    <input type="hidden" name="idEksponata" value="{$eksponat.idEksponata}">
                </form>
            {/if}
            
            {if $smarty.get.sadrzaj == 'izlozba'}
                <form method="post" action="">
                    <table>
                        <tr>
                            <td>Naziv izložbe:</td>
                            <td><input type="text" name="nazivIzlozbe" value="{$izlozba.nazivIzlozbe}" required size="30" maxlength="45" autofocus></td>
                        </tr>
                        
                        <tr>
                            <td>Vrijeme otvaranja:</td>
                            <td><input type="datetime-local" name="vrijemeOtvaranja" value="{$izlozba.vrijemeOtvaranja}" required size="30" maxlength="30"></td>
                        </tr>
                        
                        <tr>
                            <td>Vrijeme zatvaranja:</td>
                            <td><input type="datetime-local" name="vrijemeZatvaranja" value="{$izlozba.vrijemeZatvaranja}" required size="30" maxlength="30"></td>
                        </tr>
                        
                        <tr>
                            <td>Cijena izložbe:</td>
                            <td><input type="text" name="cijenaIzlozbe" value="{$izlozba.cijenaIzlozbe}" required size="30"></td>
                        </tr>
                        
                        <tr>
                            <td colspan="2">Odaberite barem jedan eksponat, sobu ili izložbu koji će biti vidljivi na izložbi</td>
                        </tr>
                        
                        <tr>
                            <td>Odaberite eksponate:</td>
                            <td>
                                <select name="eksponati[]" multiple size="5">
                                    {foreach $sadrzajIzlozbe.eksponati as $eksponat}
                                        <option value="{$eksponat.idEksponata}" {if $eksponat.dioIzlozbe}selected{/if}>{$eksponat.naziv}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        
                        <tr>
                            <td>Odaberite sobe:</td>
                            <td>
                                <select name="sobe[]" multiple size="4">
                                    {foreach $sadrzajIzlozbe.sobe as $soba}
                                        <option value="{$soba.brojSobe}" {if $soba.dioIzlozbe}selected{/if}>{$soba.nazivSobe}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        
                        <tr>
                            <td>Odaberite odjele:</td>
                            <td>
                                <select name="odjeli[]" multiple size="3">
                                    {foreach $sadrzajIzlozbe.odjeli as $odjel}
                                        <option value="{$odjel.brojOdjela}" {if $odjel.dioIzlozbe}selected{/if}>{$odjel.nazivOdjela}</option>
                                    {/foreach}
                                </select>
                            </td>
                        </tr>
                        
                        <tr>
                            <td colspan="2">
                                <input type="submit" value="Pohrani promjene">
                            </td>
                        </tr>
                    </table>
                    
                    {* ovo polje govori da u bazi treba ažurirati zapis ili ga dodati (uređivanje ili dodavanje, ovisno o parametru koji smo primili kroz GET kad se obrazac učitavao) *}
                    <input type="hidden" name="action" value="{$smarty.get.action}">
                    {* ovo nam polje govori o kakvom se obrascu radi (odjeli, sobe, eksponati, izložba), budući da se svi oni šalju na isto mjesto *}
                    <input type="hidden" name="sadrzaj" value="izlozba">
                    {* ovdje još šaljemo id izložbe kako bi prema tom podatku znali koju ćemo izložbu promijeniti / dodati u bazu *}
                    <input type="hidden" name="brojIzlozbe" value="{$izlozba.brojIzlozbe}">
                </form>
            {/if}
        {/if}
        
        
        
        {if $smarty.get.action == 'obrisi'}
            {if $smarty.get.sadrzaj == 'odjel'}
                Ova akcija je neporvatna i obrisat će sve pripadajuće sobe, eksponate, njihove suvenire, komentare i ocjene! <br>
                Jeste li sigurni da želite obrisati ovaj odjel? <br><br>
                
                <form method="post" action="">
                    <input type="hidden" name="action" value="obrisi">
                    <input type="hidden" name="sadrzaj" value="odjel">
                    <input type="hidden" name="brojOdjela" value="{$smarty.get.brojOdjela}">
                    <input type="submit" value="Potvrdi brisanje odjela">
                </form>
            {/if}
                
            {if $smarty.get.sadrzaj == 'soba'}
                Ova akcija je neporvatna i obrisat će sve pripadajuće eksponate, njihove suvenire, komentare i ocjene! <br>
                Jeste li sigurni da želite obrisati ovu sobu? <br><br>
                    
                <form method="post" action="">
                    <input type="hidden" name="action" value="obrisi">
                    <input type="hidden" name="sadrzaj" value="soba">
                    <input type="hidden" name="brojSobe" value="{$smarty.get.brojSobe}">
                    <input type="submit" value="Potvrdi brisanje sobe">
                </form>
            {/if}
            
            {if $smarty.get.sadrzaj == 'eksponat'}
                Ova akcija je nepovratna i obrisat će sve pripadajuće suvenire, komentare i ocjene! <br>
                Jeste li sigurni da želite obrisati ovaj eksponat? <br><br>
                
                <form method="post" action="">
                    <input type="hidden" name="action" value="obrisi">
                    <input type="hidden" name="sadrzaj" value="eksponat">
                    <input type="hidden" name="idEksponata" value="{$smarty.get.idEksponata}">
                    <input type="submit" value="Potvrdi brisanje eksponata">
                </form>
            {/if}
            
            {if $smarty.get.sadrzaj == 'izlozba'}
                Ova akcija je nepovratna i obrisat će sve pripadajuće ulaznice! <br>
                Jeste li sigurni da želite obrisati ovu izložbu? <br><br>
                
                <form method="post" action="">
                    <input type="hidden" name="action" value="obrisi">
                    <input type="hidden" name="sadrzaj" value="izlozba">
                    <input type="hidden" name="brojIzlozbe" value="{$smarty.get.brojIzlozbe}">
                    <input type="submit" value="Potvrdi brisanje izložbe">
                </form>
            {/if}
        {/if}
    </div>
{/block}