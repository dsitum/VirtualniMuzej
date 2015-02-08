{extends file="std.tpl"}

{block "prethodniDir"}../{/block}
{block "naslov"}Popis korisnika{/block}
{block wrapperID}siriRegister{/block}

{block "sadrzaj"}
    <style type="text/css">
        td, th { border: solid thin #7A4438; } 
    </style>
    
    <div class="okvir">
        <table>
            <thead>
                <tr>
                    <th>Korisničko ime</th>
                    <th>Ime</th>
                    <th>Prezime</th>
                    <th>Lozinka</th>
                    <th>Tip Korisnika</th>
                </tr>
            </thead>
            <tbody>
                {if $smarty.get.contentType != 'xml' && $smarty.get.contentType != 'json'}
                    {section name="korisnik" loop=$korisnici}
                        <tr>
                            <td>{$korisnici[korisnik].korime}</td>
                            <td>{$korisnici[korisnik].ime}</td>
                            <td>{$korisnici[korisnik].prezime}</td>
                            <td>{$korisnici[korisnik].lozinka}</td>
                            <td>{$korisnici[korisnik].tip}</td>
                        </tr>
                    {/section}
                {/if}
            </tbody>
        </table>
    </div>
{/block}