<?php
require "config.php";
require "foto_helper.php";
requireLogin();

$candidata_id = (int) ($_GET["id"] ?? 0);

if (!$candidata_id) {
    header("Location: avaliacao.php");
    exit;
}

$stmt = $conn->prepare("SELECT * FROM candidatas WHERE codcandidatas = ?");
$stmt->bind_param("i", $candidata_id);
$stmt->execute();
$c = $stmt->get_result()->fetch_assoc();

if (!$c) {
    header("Location: avaliacao.php");
    exit;
}

$jurado_id = $_SESSION["id"];
$stmt2 = $conn->prepare("SELECT * FROM nota WHERE jurado_id = ? AND candidata_id = ?");
$stmt2->bind_param("ii", $jurado_id, $candidata_id);
$stmt2->execute();
$nota = $stmt2->get_result()->fetch_assoc();

$msg = $_GET["msg"] ?? "";

require "header.php";
?>

<div class="topbar">
    <a href="avaliacao.php" class="topbar-brand">
        <span class="crown">👑</span>
        <span>Avaliação</span>
    </a>
    <div class="topbar-right">
        <span class="topbar-user">Logado como <strong><?php echo htmlspecialchars($_SESSION["nome"]); ?></strong></span>
        <a href="logout.php" class="btn-logout">Sair</a>
    </div>
</div>

<div class="container">
    <!-- Candidata header -->
    <div class="candidata-header">
        <div class="candidata-avatar" style="width:80px;height:80px;border-radius:50%;overflow:hidden;padding:0;">
            <?php renderFoto((int)$c['codcandidatas'], $c['nome']); ?>
        </div>
        <div class="candidata-info">
            <h2><?php echo htmlspecialchars($c["nome"]); ?></h2>
            <p><?php echo htmlspecialchars($c["empresa"]); ?></p>
        </div>
        <div style="margin-left:auto;">
            <a href="avaliacao.php" class="btn btn-secondary">← Voltar</a>
        </div>
    </div>

    <?php if ($msg === "ok"): ?>
        <div class="alert alert-success">✓ Avaliação salva com sucesso!</div>
    <?php elseif ($msg === "err"): ?>
        <div class="alert alert-error">Erro ao salvar. Verifique as notas e tente novamente.</div>
    <?php endif; ?>

    <div class="eval-layout">

        <!-- Coluna esquerda: anotações (oculta em mobile se necessário) -->
        <div class="annotation-area">
            <h3>📝 Anotações</h3>
            <p style="font-size:13px; color:var(--text-dim); margin-bottom:12px;">
                Suas anotações ficam apenas neste dispositivo.
            </p>
            <textarea
                id="anotacoes"
                placeholder="Coloque suas anotações aqui..."
                oninput="salvarAnotacoes()"
            ><?php
                $chave = "jurado_{$jurado_id}_candidata_{$candidata_id}";
            ?></textarea>
            <p style="font-size:11px; color:var(--text-dim); margin-top:10px; text-align:right;" id="saved-indicator"></p>
        </div>

        <!-- Coluna direita: formulário de notas -->
        <div>
            <form method="POST" action="salvar_nota.php" id="form-notas">
                <input type="hidden" name="candidata_id" value="<?php echo $candidata_id; ?>">

                <?php
                $notas_config = [
                    ["n1", "Prova Teórica",      "nota1_teorica",   0, 10],
                    ["n2", "Prova de Vídeo",      "nota2_video",     5, 10],
                    ["n3", "Entrevista Pessoal",  "nota3_entrevista",5, 10],
                    ["n4", "Desfile",             "nota4_desfile",   5, 10],
                ];

                foreach ($notas_config as $idx => [$name, $label, $col, $min, $max]):
                    $val = $nota[$col] ?? "";
                    $filled = $val !== "";
                ?>
                <div class="nota-card <?php echo $filled ? 'filled' : ''; ?>" id="card-<?php echo $name; ?>">
                    <div class="nota-header">
                        <span class="nota-title">Nota <?php echo $idx+1; ?> — <?php echo $label; ?></span>
                        <span class="nota-range"><?php echo $min; ?> a <?php echo $max; ?></span>
                    </div>
                    <input
                        type="number"
                        name="<?php echo $name; ?>"
                        id="input-<?php echo $name; ?>"
                        class="form-input"
                        step="0.5"
                        min="<?php echo $min; ?>"
                        max="<?php echo $max; ?>"
                        placeholder="Ex: <?php echo $min + 2.5; ?>"
                        value="<?php echo htmlspecialchars($val); ?>"
                        oninput="onNotaChange('<?php echo $name; ?>')"
                        required>
                </div>
                <?php endforeach; ?>

                <div id="media-preview" style="display:none; background:var(--surface); border:1px solid rgba(201,168,76,0.2); border-radius:var(--radius); padding:16px 20px; margin-bottom:20px;">
                    <div style="font-size:12px; color:var(--text-muted); text-transform:uppercase; letter-spacing:0.06em; margin-bottom:4px;">Média Calculada</div>
                    <div id="media-valor" class="media-badge">—</div>
                </div>

                <div class="flex gap-3 items-center">
                    <button type="submit" id="btn-salvar" class="btn btn-primary" disabled>
                        💾 Salvar Avaliação
                    </button>
                    <span id="msg-validacao" style="font-size:13px; color:var(--text-dim);">
                        Preencha todas as notas para salvar.
                    </span>
                </div>
            </form>
        </div>

    </div>
</div>

<script>
// ── Anotações no localStorage ──
const CHAVE = "jurado_<?php echo $jurado_id; ?>_candidata_<?php echo $candidata_id; ?>";
const ta = document.getElementById("anotacoes");
const savedInd = document.getElementById("saved-indicator");

// Carrega
try {
    const saved = localStorage.getItem(CHAVE);
    if (saved) ta.value = saved;
} catch(e) {}

let saveTimeout;
function salvarAnotacoes() {
    clearTimeout(saveTimeout);
    savedInd.textContent = "Salvando...";
    saveTimeout = setTimeout(() => {
        try {
            localStorage.setItem(CHAVE, ta.value);
            savedInd.textContent = "✓ Salvo";
            setTimeout(() => savedInd.textContent = "", 2000);
        } catch(e) {}
    }, 800);
}

// ── Validação de notas ──
const campos = ["n1","n2","n3","n4"];
const limites = { n1:[0,10], n2:[5,10], n3:[5,10], n4:[5,10] };

function onNotaChange(campo) {
    const card = document.getElementById("card-" + campo);
    const inp = document.getElementById("input-" + campo);
    const v = parseFloat(inp.value);
    const [mn, mx] = limites[campo];

    const valido = !isNaN(v) && v >= mn && v <= mx && ((v * 10) % 5 === 0);
    card.classList.toggle("filled", valido);

    verificarTodos();
}

function verificarTodos() {
    let todas = true;
    let soma = 0;

    for (const campo of campos) {
        const inp = document.getElementById("input-" + campo);
        const v = parseFloat(inp.value);
        const [mn, mx] = limites[campo];
        const valido = !isNaN(v) && v >= mn && v <= mx && ((v * 10) % 5 === 0);
        if (!valido) { todas = false; break; }
        soma += v;
    }

    const btn = document.getElementById("btn-salvar");
    const msg = document.getElementById("msg-validacao");
    const mediaDiv = document.getElementById("media-preview");
    const mediaVal = document.getElementById("media-valor");

    btn.disabled = !todas;
    msg.textContent = todas ? "" : "Preencha todas as notas para salvar.";

    if (todas) {
        const media = soma / 4;
        // Arredonda para .0 ou .5
        const arredondado = Math.round(media * 2) / 2;
        mediaDiv.style.display = "block";
        mediaVal.textContent = arredondado.toFixed(1);
    } else {
        mediaDiv.style.display = "none";
    }
}

// Roda ao carregar para caso já haja valores preenchidos
window.addEventListener("DOMContentLoaded", () => {
    campos.forEach(c => onNotaChange(c));
});
</script>

<?php require "footer.php"; ?>
