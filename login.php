<?php
require "config.php";

if (isset($_SESSION["id"])) {
    header("Location: avaliacao.php");
    exit;
}

$erro = "";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $nome  = trim($_POST["nome"] ?? "");
    $senha = $_POST["senha"] ?? "";

    $stmt = $conn->prepare("SELECT * FROM jurados WHERE nome = ?");
    $stmt->bind_param("s", $nome);
    $stmt->execute();
    $res = $stmt->get_result();

    if ($res->num_rows === 1) {
        $user = $res->fetch_assoc();
        // Suporte a senha plain-text (sem hash) conforme banco atual
        if ($senha === $user["senha"]) {
            $_SESSION["id"]    = $user["codjurados"];
            $_SESSION["nome"]  = $user["nome"];
            $_SESSION["admin"] = !empty($user["is_admin"]);
            header("Location: avaliacao.php");
            exit;
        }
    }

    $erro = "Usuário ou senha incorretos.";
}

require "header.php";
?>

<div class="login-wrapper">
    <div class="login-box">
        <div class="login-logo">
            <span class="login-crown">👑</span>
            <div class="login-title">Sistema de Avaliação</div>
            <div class="login-sub">Painel dos Jurados</div>
        </div>

        <?php if ($erro): ?>
            <div class="alert alert-error"><?php echo htmlspecialchars($erro); ?></div>
        <?php endif; ?>

        <form method="POST" autocomplete="off">
            <div class="form-group">
                <label class="form-label">Usuário</label>
                <input
                    type="text"
                    name="nome"
                    class="form-input"
                    placeholder="Seu nome de jurado"
                    value="<?php echo htmlspecialchars($_POST['nome'] ?? ''); ?>"
                    autofocus
                    required>
            </div>

            <div class="form-group">
                <label class="form-label">Senha</label>
                <input
                    type="password"
                    name="senha"
                    class="form-input"
                    placeholder="••••••••"
                    required>
            </div>

            <button type="submit" class="btn btn-primary" style="width:100%; justify-content:center; margin-top:8px;">
                Entrar
            </button>
        </form>
    </div>
</div>

<?php require "footer.php"; ?>
