{extends file="../std.tpl"}

{block "prethodniDir"}../{/block}
{block "naslov"}Promjena korisničkih podataka{/block}
{block klasa}okvir{/block}

{block sadrzaj}
    <form name="registracija" method="post" id="registracija"
      action="pohrani_promjene.php?id={$smarty.get.id}">
        <table>

            <tr>
                <td>Ime:</td>
                <td><input type="text" name="ime" placeholder="Vaše ime"
                           id="ime" value="{$podaci.ime}"
                           class="poljeForme" required size="30">
                </td>
            </tr>

            <tr>
                <td>Prezime:</td>
                <td>
                    <input type="text" name="prezime" 
                           id="prezime" value="{$podaci.prezime}"
                           placeholder="Vaše prezime" 
                           class="poljeForme"
                           required size="30">
                </td>
            </tr>

            <tr>
                <td>E-mail adresa:</td>
                <td>
                    <input type="email" name="email"
                           placeholder="name@example.com" 
                           class="poljeForme" value="{$podaci.email}"
                           required size="30">
                </td>
            </tr>

            <tr>
                <td>Korisničko ime:</td>
                <td>
                    <input type="text" name="username" value="{$podaci.korime}"
                           placeholder="Odaberite korisničko ime" 
                           class="poljeForme" id="username"
                           required size="30" pattern=".{literal}{5,}{/literal}">
                </td>
            </tr>

            {* Ovaj dio obrasca smiju uređivati samo administratori *}
            {if $smarty.session.tip == 3}
                <tr>
                    <td>Tip korisnika:</td>
                    <td>
                        {if $podaci.tipKorisnika == 1}
                            <input type="radio" name="tipKorisnika" value="1" checked>Obični korisnik <br>
                            <input type="radio" name="tipKorisnika" value="2">Kustos <br>
                            <input type="radio" name="tipKorisnika" value="3">Administrator
                        {elseif $podaci.tipKorisnika == 2}
                            <input type="radio" name="tipKorisnika" value="1">Obični korisnik <br>
                            <input type="radio" name="tipKorisnika" value="2" checked>Kustos <br>
                            <input type="radio" name="tipKorisnika" value="3">Administrator
                        {else}
                            <input type="radio" name="tipKorisnika" value="1">Obični korisnik <br>
                            <input type="radio" name="tipKorisnika" value="2">Kustos <br>
                            <input type="radio" name="tipKorisnika" value="3" checked>Administrator
                        {/if}
                    </td>
                </tr>
            {/if}

            <tr>
                <td>Lozinka:</td>
                <td>
                    <input type="password" name="password" 
                           id="password" value="{$podaci.lozinka}"
                           placeholder="Unesite lozinku" 
                           class="poljeForme" pattern=".{literal}{5,}{/literal}"
                           required size="30">
                </td>
            </tr>

            <tr>
                <td>Broj telefona:</td>
                <td>
                    <input type="text" name="telefon"
                           placeholder="Unesite broj telefona"
                           class="poljeForme" value="{$podaci.telefon}"
                           required size="30" pattern="09.{literal}{7,8}{/literal}">
                </td>
            </tr>

            <tr>
                <td>Grad:</td>
                <td>
                    <input type="text" name="grad"
                           placeholder="Unesite mjesto stanovanja"
                           id="grad" value="{$podaci.grad}"
                           class="poljeForme"
                           required size="30">
                </td>
            </tr>

            <tr>
                <td>Životopis:</td>
                <td>
                    <textarea name="zivotopis"
                           placeholder="Vaš kratki životopis"
                           class="poljeForme"
                           required rows="5" cols="30">{$podaci.zivotopis}</textarea>
                </td>
            </tr>

            <tr>
                <td>Datum rođenja:</td>
                <td>
                    <input type="date" name="datumrodjenja" required
                           value="{$podaci.datum_rodjenja}">
                </td>
            </tr>

            <tr>
                <td>Spol:</td>
                <td>
                    <select id="spol" name="spol">
                        {if $podaci.spol == 'z'}
                            <option value='z' selected>Ženski</option>
                            <option value='m'>Muški</option>
                        {else}
                            <option value='z'>Ženski</option>
                            <option value='m' selected>Muški</option>
                        {/if}
                    </select>
                </td>
            </tr>

            <tr>
                <td>Obavijesti putem E-maila:</td>
                <td>
                    {if $podaci.mailObavijesti == 1}
                        <input type="radio" name="obavijest" value="1" checked>Da <br>
                        <input type="radio" name="obavijest" value="0">Ne
                    {else}
                        <input type="radio" name="obavijest" value="1">Da <br>
                        <input type="radio" name="obavijest" value="0" checked>Ne
                    {/if}
                </td>
            </tr>

            {* Ovaj dio obrasca smiju uređivati samo administratori *}
            {if $smarty.session.tip == 3}
                <tr>
                    <td>Korisnik je aktiviran:</td>
                    <td>
                        {if $podaci.aktiviran == 1}
                            <input type="radio" name="aktiviran" value="1" checked>Da <br>
                            <input type="radio" name="aktiviran" value="0">Ne
                        {else}
                            <input type="radio" name="aktiviran" value="1">Da <br>
                            <input type="radio" name="aktiviran" value="0" checked>Ne
                        {/if}
                    </td>
                </tr>

                <tr>
                    <td>Korisnik je zaključan:</td>
                    <td>
                        {if $podaci.zakljucan == 1}
                            <input type="radio" name="zakljucan" value="1" checked>Da <br>
                            <input type="radio" name="zakljucan" value="0">Ne
                        {else}
                            <input type="radio" name="zakljucan" value="1" checked>Da <br>
                            <input type="radio" name="zakljucan" value="0" checked>Ne
                        {/if}
                    </td>
                </tr>
            {/if}

            <tr>
                <td colspan="2">
                    <button type="submit">Pohrani promjene</button>
                </td>
            </tr>
        </table>
    </form>
{/block}