<?php
session_start();

$conn = new mysqli("localhost", "root", "", "concurso_db");

if ($conn->connect_error) {
    die("Erro na conexão com o banco de dados.");
}

$conn->set_charset("utf8mb4");

// Helper: redireciona se não estiver logado
function requireLogin() {
    if (!isset($_SESSION["id"])) {
        header("Location: login.php");
        exit;
    }
}

// Helper: redireciona se não for admin
function requireAdmin() {
    if (!isset($_SESSION["admin"]) || !$_SESSION["admin"]) {
        header("Location: avaliacao.php");
        exit;
    }
}
?>
