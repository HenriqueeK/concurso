<?php
require "config.php";
require "foto_helper.php";
requireLogin();
require "header.php";

$jurado_id = $_SESSION["id"];

$candidatas = $conn->query("
    SELECT c.*,
           (SELECT COUNT(*) FROM nota n
            WHERE n.candidata_id = c.codcandidatas
              AND n.jurado_id = $jurado_id
              AND (n.nota2_video IS NOT NULL OR n.nota3_entrevista IS NOT NULL OR n.nota4_desfile IS NOT NULL)
           ) AS avaliada
    FROM candidatas c
    ORDER BY c.nome ASC
");
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
        <?php if (!empty($_SESSION["admin"])): ?>
            <a href="admin.php" class="btn btn-secondary" style="font-size:13px;padding:6px 14px;">Painel Admin</a>
        <?php endif; ?>
        <a href="logout.php" class="btn-logout">Sair</a>
    </div>
</div>

<div class="container">
    <h1 class="page-title">Selecione a Candidata</h1>
    <p class="page-subtitle">Clique em uma candidata para iniciar ou atualizar sua avaliação</p>
    <div class="gold-line"></div>
    <div class="grid">
        <?php while ($c = $candidatas->fetch_assoc()): ?>
            <div class="card" onclick="location.href='candidata.php?id=<?php echo $c['codcandidatas']; ?>'">
                <?php if ($c['avaliada']): ?>
                    <div class="card-badge" title="Já avaliada"></div>
                <?php endif; ?>
                <div class="card-photo">
                    <?php renderFoto((int)$c['codcandidatas'], $c['nome']); ?>
                </div>
                <div class="card-nome"><?php echo htmlspecialchars($c['nome']); ?></div>
                <div class="card-empresa"><?php echo htmlspecialchars($c['empresa']); ?></div>
            </div>
        <?php endwhile; ?>
    </div>
</div>

<?php require "footer.php"; ?>
