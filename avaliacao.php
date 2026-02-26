<?php
require "config.php";
require "foto_helper.php";
requireLogin();
require "header.php";

// Busca candidatas e verifica quais já foram avaliadas por este jurado
$jurado_id = $_SESSION["id"];

$candidatas = $conn->query("
    SELECT c.*, 
           (SELECT COUNT(*) FROM nota n 
            WHERE n.candidata_id = c.codcandidatas 
              AND n.jurado_id = $jurado_id) AS avaliada
    FROM candidatas c
    ORDER BY c.nome ASC
");
?>

<div class="topbar">
    <a href="avaliacao.php" class="topbar-brand">
        <span class="crown">👑</span>
        <span>Avaliação</span>
    </a>
    <div class="topbar-right">
        <span class="topbar-user">Logado como <strong><?php echo htmlspecialchars($_SESSION["nome"]); ?></strong></span>
        <?php if (!empty($_SESSION["admin"])): ?>
            <a href="admin.php" class="btn btn-secondary" style="font-size:13px; padding:6px 14px;">Painel Admin</a>
        <?php endif; ?>
        <a href="logout.php" class="btn-logout">Sair</a>
    </div>
</div>

<div class="container">
    <div>
        <h1 class="page-title">Selecione a Candidata</h1>
        <p class="page-subtitle">Clique em uma candidata para iniciar ou atualizar sua avaliação</p>
        <div class="gold-line"></div>
    </div>

    <div class="grid">
        <?php while ($c = $candidatas->fetch_assoc()): ?>
            <div class="card" onclick="location.href='candidata.php?id=<?php echo $c['codcandidatas']; ?>'">
                <?php if ($c['avaliada']): ?>
                    <div class="card-badge" title="Avaliada"></div>
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
