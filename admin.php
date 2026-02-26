<?php
require "config.php";
requireLogin();
requireAdmin();
require "header.php";

// Ranking geral
$ranking = $conn->query("
    SELECT 
        c.codcandidatas,
        c.nome,
        c.empresa,
        ROUND(AVG((n.nota1_teorica + n.nota2_video + n.nota3_entrevista + n.nota4_desfile) / 4) * 2) / 2 AS media,
        COUNT(n.codnota) AS total_jurados
    FROM candidatas c
    LEFT JOIN nota n ON c.codcandidatas = n.candidata_id
    GROUP BY c.codcandidatas
    ORDER BY media DESC, c.nome ASC
");

// Notas por jurado (para a tabela detalhada)
$detalhe = $conn->query("
    SELECT 
        c.nome AS candidata,
        c.empresa,
        j.nome AS jurado,
        n.nota1_teorica,
        n.nota2_video,
        n.nota3_entrevista,
        n.nota4_desfile,
        ROUND(((n.nota1_teorica + n.nota2_video + n.nota3_entrevista + n.nota4_desfile) / 4) * 2) / 2 AS media_ind
    FROM nota n
    JOIN candidatas c ON n.candidata_id = c.codcandidatas
    JOIN jurados j    ON n.jurado_id    = j.codjurados
    ORDER BY c.nome ASC, j.nome ASC
");

// Total de jurados e candidatas
$total_jurados    = $conn->query("SELECT COUNT(*) AS t FROM jurados WHERE is_admin = 0 OR is_admin IS NULL")->fetch_assoc()["t"];
$total_candidatas = $conn->query("SELECT COUNT(*) AS t FROM candidatas")->fetch_assoc()["t"];
$total_notas      = $conn->query("SELECT COUNT(DISTINCT jurado_id, candidata_id) AS t FROM nota")->fetch_assoc()["t"];
$possivel         = $total_jurados * $total_candidatas;
?>

<div class="topbar">
    <a href="admin.php" class="topbar-brand">
        <span class="crown">👑</span>
        <span>Admin</span>
    </a>
    <div class="topbar-right">
        <a href="avaliacao.php" class="btn btn-secondary" style="font-size:13px; padding:6px 14px;">← Painel Jurado</a>
        <a href="logout.php" class="btn-logout">Sair</a>
    </div>
</div>

<div class="container">
    <h1 class="page-title">Painel do Administrador</h1>
    <p class="page-subtitle">Visão geral de todas as avaliações</p>
    <div class="gold-line"></div>

    <!-- Stats -->
    <div style="display:grid; grid-template-columns:repeat(auto-fit,minmax(180px,1fr)); gap:16px; margin-bottom:36px;">
        <div style="background:var(--surface); border:1px solid var(--border); border-radius:var(--radius); padding:20px;">
            <div style="font-size:11px; text-transform:uppercase; letter-spacing:0.08em; color:var(--text-muted); margin-bottom:8px;">Candidatas</div>
            <div style="font-size:32px; font-family:'Playfair Display',serif; color:var(--gold);"><?php echo $total_candidatas; ?></div>
        </div>
        <div style="background:var(--surface); border:1px solid var(--border); border-radius:var(--radius); padding:20px;">
            <div style="font-size:11px; text-transform:uppercase; letter-spacing:0.08em; color:var(--text-muted); margin-bottom:8px;">Jurados</div>
            <div style="font-size:32px; font-family:'Playfair Display',serif; color:var(--gold);"><?php echo $total_jurados; ?></div>
        </div>
        <div style="background:var(--surface); border:1px solid var(--border); border-radius:var(--radius); padding:20px;">
            <div style="font-size:11px; text-transform:uppercase; letter-spacing:0.08em; color:var(--text-muted); margin-bottom:8px;">Avaliações Realizadas</div>
            <div style="font-size:32px; font-family:'Playfair Display',serif; color:var(--gold);"><?php echo $total_notas; ?></div>
        </div>
        <div style="background:var(--surface); border:1px solid var(--border); border-radius:var(--radius); padding:20px;">
            <div style="font-size:11px; text-transform:uppercase; letter-spacing:0.08em; color:var(--text-muted); margin-bottom:8px;">Progresso</div>
            <div style="font-size:32px; font-family:'Playfair Display',serif; color:var(--gold);">
                <?php echo $possivel > 0 ? round(($total_notas / $possivel) * 100) : 0; ?>%
            </div>
        </div>
    </div>

    <!-- Ranking -->
    <h2 style="font-family:'Playfair Display',serif; font-size:20px; margin-bottom:16px; color:var(--text);">🏆 Ranking Final</h2>

    <div class="table-wrapper" style="margin-bottom:40px;">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Candidata</th>
                    <th>Empresa</th>
                    <th>Jurados que avaliaram</th>
                    <th>Média Final</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <?php $pos = 1; while ($r = $ranking->fetch_assoc()): ?>
                <tr>
                    <td>
                        <span class="rank-badge <?php
                            echo match($pos) {
                                1 => 'rank-1',
                                2 => 'rank-2',
                                3 => 'rank-3',
                                default => 'rank-other'
                            };
                        ?>"><?php echo $pos; ?></span>
                    </td>
                    <td style="font-weight:500;"><?php echo htmlspecialchars($r["nome"]); ?></td>
                    <td class="text-muted"><?php echo htmlspecialchars($r["empresa"]); ?></td>
                    <td>
                        <span style="font-size:13px; color:var(--text-muted);">
                            <?php echo (int)$r["total_jurados"]; ?> / <?php echo $total_jurados; ?>
                        </span>
                    </td>
                    <td>
                        <?php if ($r["media"] !== null): ?>
                            <span class="media-badge"><?php echo number_format((float)$r["media"], 1); ?></span>
                        <?php else: ?>
                            <span style="color:var(--text-dim); font-size:13px;">Sem notas</span>
                        <?php endif; ?>
                    </td>
                    <td>
                        <?php if ($r["media"] !== null): ?>
                        <div class="progress-wrap">
                            <div class="progress-fill" style="width:<?php echo (float)$r["media"] * 10; ?>%"></div>
                        </div>
                        <?php endif; ?>
                    </td>
                </tr>
                <?php $pos++; endwhile; ?>
            </tbody>
        </table>
    </div>

    <!-- Notas detalhadas -->
    <h2 style="font-family:'Playfair Display',serif; font-size:20px; margin-bottom:16px; color:var(--text);">📊 Notas por Jurado</h2>

    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>Candidata</th>
                    <th>Empresa</th>
                    <th>Jurado</th>
                    <th>Teórica</th>
                    <th>Vídeo</th>
                    <th>Entrevista</th>
                    <th>Desfile</th>
                    <th>Média ind.</th>
                </tr>
            </thead>
            <tbody>
                <?php while ($d = $detalhe->fetch_assoc()): ?>
                <tr>
                    <td style="font-weight:500;"><?php echo htmlspecialchars($d["candidata"]); ?></td>
                    <td class="text-muted"><?php echo htmlspecialchars($d["empresa"]); ?></td>
                    <td class="text-muted"><?php echo htmlspecialchars($d["jurado"]); ?></td>
                    <td><?php echo number_format((float)$d["nota1_teorica"], 1); ?></td>
                    <td><?php echo number_format((float)$d["nota2_video"], 1); ?></td>
                    <td><?php echo number_format((float)$d["nota3_entrevista"], 1); ?></td>
                    <td><?php echo number_format((float)$d["nota4_desfile"], 1); ?></td>
                    <td><strong style="color:var(--gold-light);"><?php echo number_format((float)$d["media_ind"], 1); ?></strong></td>
                </tr>
                <?php endwhile; ?>
            </tbody>
        </table>
    </div>
</div>

<?php require "footer.php"; ?>
