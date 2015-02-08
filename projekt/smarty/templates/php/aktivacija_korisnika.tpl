{extends file="../std.tpl"}

{block "prethodniDir"}../{/block}

{block "naslov"}Aktivacija korisničkog računa{/block}

{block sadrzaj}
    <div class="okvir">
        {$korisnikOtprijeAktiviran}
        {$korisnikNePostoji}
        {$vrijemeIsteklo}
        {$aktivacijaUspjesna}
    </div>
{/block}