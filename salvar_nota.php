<?php
require "config.php";
requireLogin();

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    header("Location: avaliacao.php");
    exit;
}

function validarNota($valor, $min, $max): bool {
    if (!is_numeric($valor)) return false;
    $v = (float) $valor;
    if ($v < $min || $v > $max) return false;
    // Aceita apenas .0 ou .5
    if (fmod(round($v * 10), 5) !== 0.0) return false;
    return true;
}

$n1 = $_POST["n1"] ?? null;
$n2 = $_POST["n2"] ?? null;
$n3 = $_POST["n3"] ?? null;
$n4 = $_POST["n4"] ?? null;
$candidata_id = (int) ($_POST["candidata_id"] ?? 0);
$jurado_id    = (int) $_SESSION["id"];

if (
    !$candidata_id ||
    !validarNota($n1, 0, 10) ||
    !validarNota($n2, 5, 10) ||
    !validarNota($n3, 5, 10) ||
    !validarNota($n4, 5, 10)
) {
    header("Location: candidata.php?id={$candidata_id}&msg=err");
    exit;
}

$sql = "
    INSERT INTO nota (jurado_id, candidata_id, nota1_teorica, nota2_video, nota3_entrevista, nota4_desfile)
    VALUES (?, ?, ?, ?, ?, ?)
    ON DUPLICATE KEY UPDATE
        nota1_teorica    = VALUES(nota1_teorica),
        nota2_video      = VALUES(nota2_video),
        nota3_entrevista = VALUES(nota3_entrevista),
        nota4_desfile    = VALUES(nota4_desfile)
";

$stmt = $conn->prepare($sql);
$stmt->bind_param("iidddd", $jurado_id, $candidata_id, $n1, $n2, $n3, $n4);

if ($stmt->execute()) {
    header("Location: candidata.php?id={$candidata_id}&msg=ok");
} else {
    header("Location: candidata.php?id={$candidata_id}&msg=err");
}
exit;
