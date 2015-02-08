{extends file="../std.tpl"}

{block "prethodniDir"}../{/block}
{block klasa}okvir{/block}

{block "naslov"}
    {if $smarty.get.logout == 1}
        Odjava Korisnika
    {else}
        Prijava
    {/if}
{/block}


{block "sadrzaj"}
    {if $smarty.get.logout == 1}
        {$odjava = 'Odjava sa stranice uspješna'}
    {else}
        {if $aktiviran == false}
            {$nijeAktiviran = 'Vaš korisnički račun nije aktiviran. Obratite se administratoru.'}
        {/if}

        {if $zakljucan == true}
            {$ZakljucanJe = 'Vaš korisnički račun je zaključan. Obratite se administratoru. <br>'}
        {else}
            {if $max_broj_prijava == true}
                {$maxPrijava = 'Iskoristili ste makismalni mogući broj prijava. Obratite se administratoru.'}
            {else}
                {if $brojNeuspjesnihPrijava > 0}
                    {$kriviPodaci = 'Upisali ste krivo korisničke podatke <br> Pokušaj prijave: '}
                {/if}
            {/if}       
        {/if}
    {/if}
    
    {* Ispis primljenih vrijednosti *}
    {* Nije potrebno ništa definirati sa IF jer se jednostavno ove varijable neće ispisati ako su prazne *}
    {$odjava}
    {$nijeAktiviran}
    {$ZakljucanJe}
    {$maxPrijava}
    
    {* Ako su uneseni krivi podaci. Ovo smo stavili u IF jer se ispisuje i broj neuspješnih prijava kao varijabla sesije. Ne želimo da se ta varijabla ispisuje ako ne treba! *}
    {if isset($kriviPodaci)}
        {$kriviPodaci}
        {$brojNeuspjesnihPrijava}/3<br>
    {/if}  
{/block}