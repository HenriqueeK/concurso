<?php
require "config.php";
requireLogin();
requireAdmin(); // Só admin pode lançar a nota teórica

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    header("Location: avaliacao.php");
    exit;
}

$candidata_id = (int) ($_POST["candidata_id"] ?? 0);
$nota_val     = $_POST["nota_teorica"] ?? "";
$forcar       = !empty($_POST["forcar"]); // admin corrigindo nota já lançada
$jurado_id    = (int) $_SESSION["id"];

if (!$candidata_id || $nota_val === "") {
    header("Location: candidata.php?id={$candidata_id}&msg=err");
    exit;
}

// Valida: 0-10, múltiplos de 0.5
$nota = (float) $nota_val;
if ($nota < 0 || $nota > 10 || fmod(round($nota * 10), 5) !== 0.0) {
    header("Location: candidata.php?id={$candidata_id}&msg=err");
    exit;
}

// Verifica se já foi lançada
$chk = $conn->prepare("SELECT candidata_id FROM nota_teorica_global WHERE candidata_id = ?");
$chk->bind_param("i", $candidata_id);
$chk->execute();
$existe = $chk->get_result()->num_rows > 0;

if ($existe && !$forcar) {
    // Já lançada e não está forçando → impede
    header("Location: candidata.php?id={$candidata_id}&msg=err");
    exit;
}

// Salva ou atualiza a nota teórica global
if ($existe) {
    $stmt = $conn->prepare("UPDATE nota_teorica_global SET nota = ?, lancada_por = ?, lancada_em = NOW() WHERE candidata_id = ?");
    $stmt->bind_param("dii", $nota, $jurado_id, $candidata_id);
} else {
    $stmt = $conn->prepare("INSERT INTO nota_teorica_global (candidata_id, nota, lancada_por) VALUES (?, ?, ?)");
    $stmt->bind_param("idi", $candidata_id, $nota, $jurado_id);
}

if ($stmt->execute()) {
    // Propaga nota teórica para todos os jurados
    $prop = $conn->prepare("
        INSERT INTO nota (jurado_id, candidata_id, nota1_teorica)
        SELECT j.codjurados, ?, ?
        FROM jurados j
        WHERE j.is_admin = 0
        ON DUPLICATE KEY UPDATE nota1_teorica = ?
    ");
    $prop->bind_param("iid", $candidata_id, $nota, $nota);
    $prop->execute();

    // Log
    $acao_log   = "teorica_lancada";
    $notas_json = json_encode(["nota1_teorica" => $nota]);
    $ip         = $_SERVER["REMOTE_ADDR"] ?? null;
    $log = $conn->prepare("INSERT INTO log_atividades (jurado_id, candidata_id, acao, notas_json, ip) VALUES (?, ?, ?, ?, ?)");
    $log->bind_param("iisss", $jurado_id, $candidata_id, $acao_log, $notas_json, $ip);
    $log->execute();

    header("Location: candidata.php?id={$candidata_id}&msg=ok_teorica");
} else {
    header("Location: candidata.php?id={$candidata_id}&msg=err");
}
exit;
