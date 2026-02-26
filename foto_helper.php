<?php
/**
 * foto_helper.php
 * Fotos em: https://github.com/HenriqueeK/concurso/tree/main/fotos-candidatas
 */

define('FOTO_BASE', 'https://raw.githubusercontent.com/HenriqueeK/concurso/main/fotos-candidatas');

define('FOTO_MAPA', [
    1  => 'alice-fischer',
    2  => 'dienifer-maciel',
    3  => 'dieniffer-leal',
    4  => 'djenifer-hatmann',
    5  => 'emili-agnes',
    6  => 'emilyn-petry',
    7  => 'gabriele-alves',
    8  => 'isadora-immich',
    9  => 'jenifer-rodrigues',
    10 => 'milena-schulz',
    11 => 'monica-zanotteli',
    12 => 'paola-gomes',
    13 => 'rafaela-scherer',
    14 => 'sabrina-gottselig',
]);

function getFotoUrl(int $codigo): ?string {
    $mapa = FOTO_MAPA;
    if (!isset($mapa[$codigo])) return null;
    return FOTO_BASE . '/' . $mapa[$codigo] . '.png';
}

function renderFoto(int $codigo, string $alt = '', string $extraStyle = ''): void {
    $url     = getFotoUrl($codigo);
    $altSafe = htmlspecialchars($alt, ENT_QUOTES);

    if ($url) {
        $urlSafe = htmlspecialchars($url, ENT_QUOTES);
        echo '<img'
           . ' src="' . $urlSafe . '"'
           . ' alt="' . $altSafe . '"'
           . ' style="width:100%;height:100%;object-fit:cover;object-position:top center;border-radius:inherit;display:block;' . $extraStyle . '"'
           . ' loading="lazy"'
           . ' onerror="this.style.display=\'none\';this.parentElement.querySelector(\'.ph\').style.display=\'flex\'"'
           . '>';
    }
    echo '<span class="ph card-photo-placeholder" style="' . ($url ? 'display:none;' : '') . '">👤</span>';
}
