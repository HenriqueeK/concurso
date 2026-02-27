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

        <!-- Cabeçalho verde -->
        <div class="login-header">


            <!-- Brasão com cantos arredondados -->
            <div class="login-brasao-wrap">
                <img src="data:image/jpeg;base64,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"
                     class="login-brasao"
                     alt="Brasão de Santa Clara do Sul">
            </div>

            <!-- Título do concurso -->
            <div class="login-title">Concurso de Soberanas 2026</div>

            <!-- Cidade -->
            <div class="login-city">✿ &nbsp; Santa Clara do Sul &nbsp; ✿</div>

        </div>

        <!-- Formulário -->
        <div class="login-body">

            <!-- Slogan unificado -->
            <div class="login-slogan">
                Gestão que acolhe, desenvolvimento que conecta
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
</div>

<?php require "footer.php"; ?>
