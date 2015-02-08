{extends file="std.tpl"}

{*{block "prethodniDir"}../{/block}*}

{block "naslov"}Registracija novog korisnika{/block}

{block "sadrzaj"}
    <div class="okvir">
        <form name="registracija" method="post" id="registracija"
            action="php/dodaj_korisnika.php">
            <table>
                <tr>
                    <td>Ime:</td>
                    <td><input type="text" name="ime" placeholder="Vaše ime"
                               id="ime"
                               class="poljeForme"
                               autofocus required size="30">
                    </td>
                </tr>

                <tr>
                    <td>Prezime:</td>
                    <td>
                        <input type="text" name="prezime" 
                               id="prezime"
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
                               class="poljeForme"
                               required size="30">
                    </td>
                </tr>

                <tr>
                    <td>Korisničko ime:</td>
                    <td>
                        <input type="text" name="username"
                               placeholder="Odaberite korisničko ime" 
                               class="poljeForme" id="username"
                               required size="30" pattern=".{literal}{5,}{/literal}">
                    </td>
                </tr>

                <tr>
                    <td>Lozinka:</td>
                    <td>
                        <input type="password" name="password"
                               id="password"
                               placeholder="Odaberite lozinku"
                               class="poljeForme"
                               required size="30" pattern=".{literal}{5,}{/literal}">
                    </td>
                </tr>

                <tr>
                    <td>Potvrdite lozinku:</td>
                    <td>
                        <input type="password" name="password2"
                               id="password2"
                               placeholder="Ponovno unesite lozinku"
                               class="poljeForme"
                               required size="30" pattern=".{literal}{5,}{/literal}">
                    </td>
                </tr>

                <tr>
                    <td>Broj telefona:</td>
                    <td>
                        <input type="text" name="telefon"
                               placeholder="Unesite broj telefona"
                               class="poljeForme"
                               required size="30" pattern="09+.{literal}{7,8}{/literal}">
                    </td>
                </tr>

                <tr>
                    <td>Grad:</td>
                    <td>
                        <input type="text" name="grad"
                               placeholder="Unesite mjesto stanovanja"
                               id="grad"
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
                               required rows="5" cols="30"></textarea>
                    </td>
                </tr>

                <tr>
                    <td>Datum rođenja:</td>
                    <td>
                        <input type="date" name="datumrodjenja" required>
                    </td>
                </tr>

                <tr>
                    <td>Spol:</td>
                    <td>
                        <select id="spol" name="spol">
                            <option value="0">--odaberi--</option>
                            <option value="z">Ženski</option>
                            <option value="m">Muški</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td>Želite li primati obavijesti putem E-maila?</td>
                    <td>
                        <input type="radio" name="obavijest" value="1">Želim <br>
                        <input type="radio" name="obavijest" value="0" checked>Ne želim
                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        {$recaptcha}                 
                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        Prihvaćam uvjete korištenja
                        <input type="checkbox" name="uvjeti" value="prihvacam" required>
                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        <button type="submit">Registriraj se</button>
                    </td>
                </tr>
            </table>
          </form>
    </div>
                               
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/jquery.ui.js"></script>
    <link rel="stylesheet" type="text/css" href="css/jquery.ui/jquery-ui-1.10.3.custom.min.css">
    <script type="text/javascript" src="js/prviDio.js"></script>
    <script type="text/javascript" src="js/drugiDio.js"></script>
{/block}