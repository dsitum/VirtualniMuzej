{extends file="../std.tpl"}

{block "prethodniDir"}../{/block}
{block "naslov"}Ispis detalja korisnika{/block}
{block klasa}okvir centar{/block}

{block "sadrzaj"}
    <style type="text/css">
        td, th { border: solid thin #7A4438; } 
    </style>
    
    <table>
        <tr>
            <td colspan="2"><u>Detaljni podaci o korisniku <i>{$korime}</i></u></td>
        </tr>
        
        <tr>
            <td><b>Korisničko ime:</b></td>
            <td>{$korime}</td>
        </tr>
        
        <tr>
            <td><b>Ime:</b></td>
            <td>{$ime}</td>
        </tr>

        <tr>
            <td><b>Prezime:</b></td>
            <td>{$prezime}</td>
        </tr>

        <tr>
            <td><b>E-mail adresa:</b></td>
            <td>{$email}</td>
        </tr>

        <tr>
            <td><b>Telefon:</b></td>
            <td>{$telefon}</td>
        </tr>
        
        <tr>
            <td><b>Grad:</b></td>
            <td>{$grad}</td>
        </tr>
        
        <tr>
            <td><b>Životopis:</b></td>
            <td>{$zivotopis}</td>
        </tr>
        
        <tr>
            <td><b>Datum Rođenja:</b></td>
            <td>{$datum_rodjenja}</td>
        </tr>
        
        <tr>
            <td><b>Spol:</b></td>
            <td>{$spol}</td>
        </tr>
        
        <tr>
            <td><b>Datum Registracije:</b></td>
            <td>{$datum_registracije}</td>
        </tr>
        
        <tr>
            <td><b>Aktiviran:</b></td>
            <td>{$aktiviran}</td>
        </tr>
        
        <tr>
            <td><b>Tip Korisnika:</b></td>
            <td>{$tipKorisnika}</td>
        </tr>
        
        <tr>
            <td><b>Zaključan:</b></td>
            <td>{$zakljucan}</td>
        </tr>
    </table>
{/block}