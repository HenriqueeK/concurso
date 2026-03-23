<?php
require "config.php";
requireLogin();

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    header("Location: avaliacao.php");
    exit;
}

function validarNota($valor, $min, $max): bool {
    if ($valor === null || $valor === "") return true; // vazio = null é permitido
    if (!is_numeric($valor)) return false;
    $v = (float) $valor;
    if ($v < $min || $v > $max) return false;
    if (fmod(round($v * 10), 5) !== 0.0) return false;
    return true;
}

$candidata_id = (int) ($_POST["candidata_id"] ?? 0);
$jurado_id    = (int) $_SESSION["id"];

// Lê valores e converte vazios para null
$n2 = isset($_POST["n2"]) && $_POST["n2"] !== "" ? $_POST["n2"] : null;
$n3 = isset($_POST["n3"]) && $_POST["n3"] !== "" ? $_POST["n3"] : null;
$n4 = isset($_POST["n4"]) && $_POST["n4"] !== "" ? $_POST["n4"] : null;

// Bloqueia se candidata inválida
if (!$candidata_id) {
    header("Location: avaliacao.php");
    exit;
}

// Bloqueia se TODAS forem nulas (não salvar vazio)
if ($n2 === null && $n3 === null && $n4 === null) {
    header("Location: candidata.php?id={$candidata_id}&msg=err");
    exit;
}

// Valida cada nota preenchida
if (
    !validarNota($n2, 5, 10) ||
    !validarNota($n3, 5, 10) ||
    !validarNota($n4, 5, 10)
) {
    header("Location: candidata.php?id={$candidata_id}&msg=err");
    exit;
}

// Verifica se já existe registro para determinar ação do log
$check = $conn->prepare("SELECT codnota FROM nota WHERE jurado_id = ? AND candidata_id = ?");
$check->bind_param("ii", $jurado_id, $candidata_id);
$check->execute();
$existe = $check->get_result()->num_rows > 0;

// Conta notas preenchidas
$preenchidas = count(array_filter([$n2, $n3, $n4], fn($v) => $v !== null));
if ($existe) {
    $acao = "atualizou";
} elseif ($preenchidas < 3) {
    $acao = "parcial";
} else {
    $acao = "inseriu";
}

// Salva / atualiza
$sql = "
    INSERT INTO nota (jurado_id, candidata_id, nota2_video, nota3_entrevista, nota4_desfile)
    VALUES (?, ?, ?, ?, ?)
    ON DUPLICATE KEY UPDATE
        nota2_video      = COALESCE(VALUES(nota2_video),      nota2_video),
        nota3_entrevista = COALESCE(VALUES(nota3_entrevista), nota3_entrevista),
        nota4_desfile    = COALESCE(VALUES(nota4_desfile),    nota4_desfile)
";

$stmt = $conn->prepare($sql);
$stmt->bind_param("iisss", $jurado_id, $candidata_id, $n2, $n3, $n4);

if ($stmt->execute()) {
    // Registra no log
    $notas_json = json_encode([
        "nota2_video"      => $n2,
        "nota3_entrevista" => $n3,
        "nota4_desfile"    => $n4,
    ]);
    $ip  = $_SERVER["REMOTE_ADDR"] ?? null;
    $log = $conn->prepare("INSERT INTO log_atividades (jurado_id, candidata_id, acao, notas_json, ip) VALUES (?, ?, ?, ?, ?)");
    $log->bind_param("iisss", $jurado_id, $candidata_id, $acao, $notas_json, $ip);
    $log->execute();

    header("Location: candidata.php?id={$candidata_id}&msg=ok");
} else {
    header("Location: candidata.php?id={$candidata_id}&msg=err");
}
exit;
