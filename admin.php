<?php
require "config.php";
requireLogin();
requireAdmin();
require "header.php";

// Ranking geral — média das 4 notas (teórica global + 3 notas por jurado)
// nota1_teorica já está propagada na tabela nota para todos os jurados
$ranking = $conn->query("
    SELECT
        c.codcandidatas,
        c.nome,
        c.empresa,
        ntg.nota                                           AS nota_teorica,
        ROUND(AVG(n.nota2_video),      2)                  AS media_video,
        ROUND(AVG(n.nota3_entrevista), 2)                  AS media_entrevista,
        ROUND(AVG(n.nota4_desfile),    2)                  AS media_desfile,
        ROUND((
            COALESCE(ntg.nota, 0) +
            COALESCE(AVG(n.nota2_video),      0) +
            COALESCE(AVG(n.nota3_entrevista), 0) +
            COALESCE(AVG(n.nota4_desfile),    0)
        ) / NULLIF(
            (ntg.nota IS NOT NULL) +
            (AVG(n.nota2_video)      IS NOT NULL) +
            (AVG(n.nota3_entrevista) IS NOT NULL) +
            (AVG(n.nota4_desfile)    IS NOT NULL)
        , 0), 2)                                           AS media_final,
        COUNT(DISTINCT n.jurado_id)                        AS total_jurados
    FROM candidatas c
    LEFT JOIN nota_teorica_global ntg ON ntg.candidata_id = c.codcandidatas
    LEFT JOIN nota n ON n.candidata_id = c.codcandidatas
    GROUP BY c.codcandidatas
    ORDER BY media_final DESC, c.nome ASC
");

// Notas detalhadas por jurado
$detalhe = $conn->query("
    SELECT
        c.nome    AS candidata,
        c.empresa,
        j.nome    AS jurado,
        ntg.nota  AS nota_teorica,
        n.nota2_video,
        n.nota3_entrevista,
        n.nota4_desfile,
        ROUND((
            COALESCE(ntg.nota, 0) +
            COALESCE(n.nota2_video, 0) +
            COALESCE(n.nota3_entrevista, 0) +
            COALESCE(n.nota4_desfile, 0)
        ) / NULLIF(
            (ntg.nota IS NOT NULL) +
            (n.nota2_video IS NOT NULL) +
            (n.nota3_entrevista IS NOT NULL) +
            (n.nota4_desfile IS NOT NULL)
        , 0), 2) AS media_ind
    FROM nota n
    JOIN candidatas c ON n.candidata_id = c.codcandidatas
    JOIN jurados j    ON n.jurado_id    = j.codjurados
    LEFT JOIN nota_teorica_global ntg ON ntg.candidata_id = c.codcandidatas
    ORDER BY c.nome ASC, j.nome ASC
");

// Stats
$total_jurados    = $conn->query("SELECT COUNT(*) AS t FROM jurados WHERE is_admin = 0")->fetch_assoc()["t"];
$total_candidatas = $conn->query("SELECT COUNT(*) AS t FROM candidatas")->fetch_assoc()["t"];
$total_notas      = $conn->query("SELECT COUNT(DISTINCT jurado_id, candidata_id) AS t FROM nota WHERE nota2_video IS NOT NULL OR nota3_entrevista IS NOT NULL OR nota4_desfile IS NOT NULL")->fetch_assoc()["t"];
$total_teoricas   = $conn->query("SELECT COUNT(*) AS t FROM nota_teorica_global")->fetch_assoc()["t"];
$possivel         = $total_jurados * $total_candidatas;

// Progresso real: conta campos preenchidos individualmente
// Máximo possível = (3 campos × 5 jurados × 13 candidatas) + (1 teórica × 13 candidatas)
$campos_jurados   = $conn->query("
    SELECT (
        COUNT(nota2_video IS NOT NULL OR NULL) +
        COUNT(nota3_entrevista IS NOT NULL OR NULL) +
        COUNT(nota4_desfile IS NOT NULL OR NULL)
    ) AS t FROM nota
")->fetch_assoc()["t"];
$max_campos       = ($total_jurados * $total_candidatas * 3) + $total_candidatas;
$total_campos     = (int)$campos_jurados + (int)$total_teoricas;
$progresso_real   = $max_campos > 0 ? round(($total_campos / $max_campos) * 100) : 0;


?>

<div class="topbar">
    <a href="admin.php" class="topbar-brand">
        <img src="data:image/jpeg;base64,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" class="topbar-brasao" alt="Santa Clara do Sul">
        <div class="topbar-brand-text">
            <span class="topbar-brand-title">Painel Administrativo</span>
            <span class="topbar-brand-sub">✿ Concurso de Soberanas 2026</span>
        </div>
    </a>
    <div class="topbar-right">
        <a href="avaliacao.php" class="btn btn-secondary" style="font-size:13px;padding:6px 14px;">← Painel Jurado</a>
        <a href="logout.php" class="btn-logout">Sair</a>
    </div>
</div>

<div class="container">
    <h1 class="page-title">Painel do Administrador</h1>
    <p class="page-subtitle">Visão geral de todas as avaliações</p>
    <div class="gold-line"></div>

    <!-- Stats -->
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:16px;margin-bottom:36px;">
        <?php foreach ([
            ["Candidatas", $total_candidatas],
            ["Jurados", $total_jurados],
            ["Avaliações salvas", $total_notas],
            ["Teóricas lançadas", $total_teoricas . " / " . $total_candidatas],
            ["Progresso geral", $progresso_real . "%"],
        ] as [$label, $val]): ?>
        <div style="background:var(--surface);border:1px solid var(--border);border-radius:var(--radius);padding:20px;">
            <div style="font-size:11px;text-transform:uppercase;letter-spacing:0.08em;color:var(--text-muted);margin-bottom:8px;"><?php echo $label; ?></div>
            <div style="font-size:32px;font-family:'Cormorant Garamond',serif;color:var(--dourado);"><?php echo $val; ?></div>
        </div>
        <?php endforeach; ?>
    </div>

    <!-- Ranking -->
    <h2 style="font-family:'Cormorant Garamond',serif;font-size:20px;margin-bottom:16px;color:var(--text);">🏆 Ranking Final</h2>
    <div class="table-wrapper" style="margin-bottom:40px;">
        <table>
            <thead>
                <tr>
                    <th>#</th><th>Candidata</th><th>Empresa</th>
                    <th>Teórica</th><th>Vídeo</th><th>Entrevista</th><th>Desfile</th>
                    <th>Jurados</th><th>Média Final</th><th></th>
                </tr>
            </thead>
            <tbody>
                <?php $pos = 1; while ($r = $ranking->fetch_assoc()): ?>
                <tr>
                    <td><span class="rank-badge <?php echo match($pos){1=>'rank-1',2=>'rank-2',3=>'rank-3',default=>'rank-other'}; ?>"><?php echo $pos; ?></span></td>
                    <td style="font-weight:500;"><?php echo htmlspecialchars($r["nome"]); ?></td>
                    <td class="text-muted"><?php echo htmlspecialchars($r["empresa"]); ?></td>
                    <td><?php echo $r["nota_teorica"] !== null ? number_format((float)$r["nota_teorica"],1) : '<span style="color:var(--text-dim)">—</span>'; ?></td>
                    <td><?php echo $r["media_video"] !== null ? number_format((float)$r["media_video"],2) : '<span style="color:var(--text-dim)">—</span>'; ?></td>
                    <td><?php echo $r["media_entrevista"] !== null ? number_format((float)$r["media_entrevista"],2) : '<span style="color:var(--text-dim)">—</span>'; ?></td>
                    <td><?php echo $r["media_desfile"] !== null ? number_format((float)$r["media_desfile"],2) : '<span style="color:var(--text-dim)">—</span>'; ?></td>
                    <td style="font-size:13px;color:var(--text-muted);"><?php echo (int)$r["total_jurados"]; ?> / <?php echo $total_jurados; ?></td>
                    <td><?php if ($r["media_final"] !== null): ?><span class="media-badge"><?php echo number_format((float)$r["media_final"],2); ?></span><?php else: ?><span style="color:var(--text-dim);font-size:13px;">Sem notas</span><?php endif; ?></td>
                    <td><?php if ($r["media_final"] !== null): ?><div class="progress-wrap"><div class="progress-fill" style="width:<?php echo (float)$r["media_final"]*10; ?>%"></div></div><?php endif; ?></td>
                </tr>
                <?php $pos++; endwhile; ?>
            </tbody>
        </table>
    </div>

    <!-- Notas por jurado -->
    <h2 style="font-family:'Cormorant Garamond',serif;font-size:20px;margin-bottom:16px;color:var(--text);">📊 Notas por Jurado</h2>
    <div class="table-wrapper" style="margin-bottom:40px;">
        <table>
            <thead>
                <tr><th>Candidata</th><th>Empresa</th><th>Jurado</th><th>Teórica</th><th>Vídeo</th><th>Entrevista</th><th>Desfile</th></tr>
            </thead>
            <tbody>
                <?php while ($d = $detalhe->fetch_assoc()): ?>
                <tr>
                    <td style="font-weight:500;"><?php echo htmlspecialchars($d["candidata"]); ?></td>
                    <td class="text-muted"><?php echo htmlspecialchars($d["empresa"]); ?></td>
                    <td class="text-muted"><?php echo htmlspecialchars($d["jurado"]); ?></td>
                    <?php foreach (["nota_teorica","nota2_video","nota3_entrevista","nota4_desfile"] as $col): ?>
                    <td><?php echo $d[$col] !== null ? number_format((float)$d[$col],1) : '<span style="color:var(--text-dim)">—</span>'; ?></td>
                    <?php endforeach; ?>
                </tr>
                <?php endwhile; ?>
            </tbody>
        </table>
    </div>

</div>

<?php require "footer.php"; ?>
