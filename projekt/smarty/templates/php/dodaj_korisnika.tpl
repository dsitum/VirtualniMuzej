{extends file="../std.tpl"}

{block "prethodniDir"}../{/block}

{block "naslov"}Registracija na sustav{/block}

{block sadrzaj}
    <div class="okvir">
        {$captchaKrivoUnesena}
        {$mailKrivoUnesen}
        {$poljaNisuPopunjena}
        {$porukaNakonRegistracije}
    </div>
{/block}