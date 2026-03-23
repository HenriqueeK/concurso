<?php
require "config.php";
require "foto_helper.php";
requireLogin();

$candidata_id = (int) ($_GET["id"] ?? 0);
if (!$candidata_id) { header("Location: avaliacao.php"); exit; }

$stmt = $conn->prepare("SELECT * FROM candidatas WHERE codcandidatas = ?");
$stmt->bind_param("i", $candidata_id);
$stmt->execute();
$c = $stmt->get_result()->fetch_assoc();
if (!$c) { header("Location: avaliacao.php"); exit; }

$jurado_id = $_SESSION["id"];
$is_admin  = !empty($_SESSION["admin"]);

// Nota teórica global (lançada pelo admin, igual para todos)
$ntg = $conn->query("SELECT nota FROM nota_teorica_global WHERE candidata_id = $candidata_id")->fetch_assoc();
$nota_teorica_global = $ntg ? $ntg["nota"] : null;

// Notas do jurado para esta candidata (notas 2,3,4)
$stmt2 = $conn->prepare("SELECT * FROM nota WHERE jurado_id = ? AND candidata_id = ?");
$stmt2->bind_param("ii", $jurado_id, $candidata_id);
$stmt2->execute();
$nota = $stmt2->get_result()->fetch_assoc();

$msg = $_GET["msg"] ?? "";

require "header.php";
?>

<div class="topbar">
    <a href="avaliacao.php" class="topbar-brand">
        <img src="data:image/jpeg;base64,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" class="topbar-brasao" alt="Santa Clara do Sul">
        <div class="topbar-brand-text">
            <span class="topbar-brand-title">Concurso de Soberanas 2026</span>
            <span class="topbar-brand-sub">✿ Santa Clara do Sul</span>
        </div>
    </a>
    <div class="topbar-right">
        <span class="topbar-user">Logado como <strong><?php echo htmlspecialchars($_SESSION["nome"]); ?></strong></span>
        <a href="logout.php" class="btn-logout">Sair</a>
    </div>
</div>

<div class="container">
    <div class="candidata-header">
        <div class="candidata-avatar" style="width:80px;height:80px;border-radius:12px;overflow:hidden;padding:0;">
            <?php renderFoto((int)$c['codcandidatas'], $c['nome'], 'border-radius:12px;'); ?>
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
    <?php elseif ($msg === "ok_teorica"): ?>
        <div class="alert alert-success">✓ Nota teórica lançada com sucesso!</div>
    <?php elseif ($msg === "err"): ?>
        <div class="alert alert-error">Erro ao salvar. Verifique as notas e tente novamente.</div>
    <?php endif; ?>

    <div class="eval-layout">
        <!-- Anotações -->
        <div class="annotation-area">
            <h3>📝 Anotações</h3>
            <p style="font-size:13px;color:var(--text-dim);margin-bottom:12px;">Ficam apenas neste dispositivo.</p>
            <textarea id="anotacoes" placeholder="Coloque suas anotações aqui..." oninput="salvarAnotacoes()"></textarea>
            <p style="font-size:11px;color:var(--text-dim);margin-top:10px;text-align:right;" id="saved-indicator"></p>
        </div>

        <!-- Formulário de notas -->
        <div>

            <!-- NOTA TEÓRICA — Admin lança, jurados visualizam -->
            <div class="nota-card <?php echo $nota_teorica_global !== null ? 'filled locked' : 'locked'; ?>">
                <div class="nota-header">
                    <span class="nota-title">Nota 1 — Prova Teórica</span>
                    <div style="display:flex;gap:8px;align-items:center;">
                        <span class="nota-range">0 a 10</span>
                        <?php if ($nota_teorica_global !== null): ?>
                            <span class="nota-locked-badge">🔒 Lançada</span>
                        <?php elseif ($is_admin): ?>
                            <span class="nota-locked-badge" style="background:rgba(91,143,201,0.1);color:var(--azul);border-color:var(--azul-light);">✏ Admin</span>
                        <?php else: ?>
                            <span class="nota-locked-badge">⏳ Aguardando</span>
                        <?php endif; ?>
                    </div>
                </div>

                <?php if ($is_admin && $nota_teorica_global === null): ?>
                    <!-- Admin pode lançar -->
                    <form method="POST" action="salvar_teorica.php" style="display:flex;gap:10px;align-items:center;">
                        <input type="hidden" name="candidata_id" value="<?php echo $candidata_id; ?>">
                        <input type="number" name="nota_teorica" id="input-teorica" class="form-input"
                               step="0.5" min="0" max="10" placeholder="0 a 10"
                               style="max-width:160px;" required>
                        <button type="submit" class="btn btn-primary" style="padding:10px 20px;font-size:13px;">
                            📌 Lançar para todas
                        </button>
                    </form>
                    <p style="font-size:12px;color:var(--text-muted);margin-top:10px;">
                        ⚠️ Esta nota vale para <strong>todas as candidatas com o mesmo resultado</strong>.
                        Após lançar, não poderá ser alterada pelos jurados.
                    </p>
                <?php elseif ($nota_teorica_global !== null): ?>
                    <!-- Nota já lançada — apenas visualização -->
                    <div style="font-family:'Cormorant Garamond',serif;font-size:28px;font-weight:600;color:var(--dourado);padding:8px 0;">
                        <?php echo number_format((float)$nota_teorica_global, 1); ?>
                    </div>
                    <p style="font-size:12px;color:var(--text-muted);margin-top:4px;">Nota única para todos os jurados. Somente o admin pode alterar.</p>
                    <?php if ($is_admin): ?>
                        <form method="POST" action="salvar_teorica.php" style="display:flex;gap:10px;align-items:center;margin-top:12px;">
                            <input type="hidden" name="candidata_id" value="<?php echo $candidata_id; ?>">
                            <input type="hidden" name="forcar" value="1">
                            <input type="number" name="nota_teorica" class="form-input" step="0.5" min="0" max="10"
                                   placeholder="Nova nota" style="max-width:140px;" value="<?php echo htmlspecialchars($nota_teorica_global); ?>">
                            <button type="submit" class="btn btn-secondary" style="padding:8px 16px;font-size:12px;">
                                ✏ Corrigir
                            </button>
                        </form>
                    <?php endif; ?>
                <?php else: ?>
                    <p style="font-size:13px;color:var(--text-dim);padding:8px 0;">Aguardando lançamento pelo administrador.</p>
                <?php endif; ?>
            </div>

            <!-- NOTAS DO JURADO (2, 3 e 4) -->
            <form method="POST" action="salvar_nota.php" id="form-notas">
                <input type="hidden" name="candidata_id" value="<?php echo $candidata_id; ?>">

                <?php
                $notas_config = [
                    ["n2", "Prova de Vídeo",     "nota2_video",     5, 10],
                    ["n3", "Entrevista Pessoal",  "nota3_entrevista",5, 10],
                    ["n4", "Desfile",             "nota4_desfile",   5, 10],
                ];

                foreach ($notas_config as $idx => [$name, $label, $col, $min, $max]):
                    $val    = $nota[$col] ?? "";
                    $filled = $val !== "" && $val !== null;
                    $num    = $idx + 2;
                ?>
                <div class="nota-card <?php echo $filled ? 'filled' : ''; ?>" id="card-<?php echo $name; ?>">
                    <div class="nota-header">
                        <span class="nota-title">Nota <?php echo $num; ?> — <?php echo $label; ?></span>
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
                        value="<?php echo htmlspecialchars((string)$val); ?>"
                        oninput="onNotaChange('<?php echo $name; ?>')">
                </div>
                <?php endforeach; ?>

                <div id="media-preview" style="display:none;background:var(--surface);border:1px solid rgba(201,168,76,0.2);border-radius:var(--radius);padding:16px 20px;margin-bottom:20px;">
                    <div style="font-size:12px;color:var(--text-muted);text-transform:uppercase;letter-spacing:0.06em;margin-bottom:4px;">Média Parcial (suas 3 notas)</div>
                    <div id="media-valor" class="media-badge">—</div>
                    <div style="font-size:11px;color:var(--text-dim);margin-top:4px;">A média final inclui a nota teórica (lançada pelo admin)</div>
                </div>

                <div class="flex gap-3 items-center">
                    <button type="submit" id="btn-salvar" class="btn btn-primary" disabled>
                        💾 Salvar Avaliação
                    </button>
                    <span id="msg-validacao" style="font-size:13px;color:var(--text-dim);">
                        Preencha ao menos uma nota para salvar.
                    </span>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
// Anotações no localStorage
const CHAVE = "jurado_<?php echo $jurado_id; ?>_candidata_<?php echo $candidata_id; ?>";
const ta = document.getElementById("anotacoes");
const savedInd = document.getElementById("saved-indicator");
try { const s = localStorage.getItem(CHAVE); if (s) ta.value = s; } catch(e) {}

let saveTimeout;
function salvarAnotacoes() {
    clearTimeout(saveTimeout);
    savedInd.textContent = "Salvando...";
    saveTimeout = setTimeout(() => {
        try { localStorage.setItem(CHAVE, ta.value); savedInd.textContent = "✓ Salvo"; setTimeout(() => savedInd.textContent = "", 2000); } catch(e) {}
    }, 800);
}

// Validação
const campos  = ["n2","n3","n4"];
const limites = { n2:[5,10], n3:[5,10], n4:[5,10] };

function onNotaChange(campo) {
    const card = document.getElementById("card-" + campo);
    const inp  = document.getElementById("input-" + campo);
    const v    = parseFloat(inp.value);
    const [mn, mx] = limites[campo];
    const valido = !isNaN(v) && v >= mn && v <= mx && ((v * 10) % 5 === 0);
    card.classList.toggle("filled", valido);
    verificarTodos();
}

function verificarTodos() {
    let alguma = false, soma = 0, count = 0;
    for (const campo of campos) {
        const inp = document.getElementById("input-" + campo);
        const v   = parseFloat(inp.value);
        const [mn, mx] = limites[campo];
        const valido = !isNaN(v) && v >= mn && v <= mx && ((v * 10) % 5 === 0);
        if (inp.value !== "" && !valido) {
            document.getElementById("btn-salvar").disabled = true;
            document.getElementById("msg-validacao").textContent = "Nota inválida em um dos campos.";
            document.getElementById("media-preview").style.display = "none";
            return;
        }
        if (valido) { alguma = true; soma += v; count++; }
    }
    const btn = document.getElementById("btn-salvar");
    const msg = document.getElementById("msg-validacao");
    const mediaDiv = document.getElementById("media-preview");
    const mediaVal = document.getElementById("media-valor");
    btn.disabled = !alguma;
    msg.textContent = alguma ? "" : "Preencha ao menos uma nota para salvar.";
    if (alguma) {
        mediaDiv.style.display = "block";
        mediaVal.textContent = count === 3 ? (soma / 3).toFixed(2) : "— (" + count + "/3 preenchidas)";
    } else {
        mediaDiv.style.display = "none";
    }
}

window.addEventListener("DOMContentLoaded", () => { campos.forEach(c => onNotaChange(c)); });
</script>

<?php require "footer.php"; ?>
