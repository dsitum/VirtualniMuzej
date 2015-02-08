{extends file="std.tpl"}


{block "naslov"}Odjeli muzeja s pripadajućim sobama{/block}
{block klasa}kontejner{/block}
{block wrapperID}{/block}
{block dodatneSkripte}<script type="text/javascript" src="js/prviDio.js"></script>{/block}

{block "sadrzaj"}
    <section class="standard okvir" id="logintekst">
        Molimo vas da se prijavite u e-muzej <br><br>
        Korisničko ime i lozinka moraju sadržavati najmanje pet znakova. <br><br>
        Ukoliko nemate korisnički račun, možete ga kreirati klikom na ovaj link: <a href="register.php">Registracija</a>. <br><br>
        Virtualni muzej (koriste se i pojmovi poput web muzej, <i>online</i> muzej, e-muzej) vrsta je muzeja koja egzistira samo u virtualnom prostoru (na Internetu). Izložbe prikazane u takvom muzeju nije moguće posjetiti u stvarnom svijetu, "one spajaju ono što u realnosti iz raznih razloga nije spojivo". Virtualni muzeji čini kolekcija digitaliziranih slika, crteža, fotografija, zvučnih i video zapisa, novinskih članaka i raznih muzejskih predmeta koji u fizičkom svijetu nisu povezani mjestom na kojem se nalaze "ali su na neki način povezani sa kontekstom realne baštine na koju upućuju".

    </section>

    <section class="login okvir">
        <form name="login" method="post" action="php/ulogiraj_se.php">
            <table>
                <tr>
                    <td>Korisničko ime:</td>
                    <td>
                        <input type="text" name="username"
                               placeholder="Unesite korisničko ime"
                               class="poljeForme" 
                               value = "{$username}"
                               size="20" required {literal}pattern=".{5,}"{/literal} autofocus>
                    </td>
                </tr>

                <tr>
                    <td>Lozinka:</td>
                    <td>
                        <input type="password" name="password"
                               placeholder="Unesite lozinku"
                               class="poljeForme"
                               size="20" required {literal} pattern=".{5,}" {/literal}>                        
                    </td>
                </tr>

                <tr>
                    <td colspan="2" style="text-align: right;">
                        Zapamti me 
                        <input type="checkbox" name="rememberme"
                        {$checked} >
                    </td>
                </tr>

                <tr>
                    <td colspan="2" style="text-align: right;">
                        <input type="submit" value="Submit">
                    </td>
                </tr>
            </table>
        </form>
    </section>
{/block}