{extends file="../std.tpl"}

{block "prethodniDir"}../{/block}

{block "naslov"}Dogodila se pogreška!{/block}

{block sadrzaj}
    <div class="okvir">
         {$poruka}
    </div>
{/block}