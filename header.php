<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Avaliação</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg: #0d0d14;
            --surface: #16161f;
            --surface2: #1e1e2a;
            --border: rgba(255,255,255,0.07);
            --gold: #c9a84c;
            --gold-light: #e8c97a;
            --gold-dim: rgba(201,168,76,0.15);
            --text: #f0ede8;
            --text-muted: #8a8799;
            --text-dim: #5a5768;
            --accent: #7c6af0;
            --accent-dim: rgba(124,106,240,0.15);
            --red: #e05c5c;
            --green: #5ccc8e;
            --radius: 14px;
            --radius-sm: 8px;
            --shadow: 0 20px 60px rgba(0,0,0,0.5);
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        html { scroll-behavior: smooth; }

        body {
            font-family: 'DM Sans', sans-serif;
            background: var(--bg);
            color: var(--text);
            min-height: 100vh;
            background-image:
                radial-gradient(ellipse 80% 50% at 50% -20%, rgba(201,168,76,0.08), transparent),
                radial-gradient(ellipse 60% 40% at 80% 80%, rgba(124,106,240,0.06), transparent);
        }

        /* ── Topbar ── */
        .topbar {
            position: sticky;
            top: 0;
            z-index: 100;
            background: rgba(13,13,20,0.85);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border);
            padding: 0 32px;
            height: 64px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .topbar-brand {
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }

        .topbar-brand .crown {
            font-size: 22px;
            filter: drop-shadow(0 0 8px rgba(201,168,76,0.6));
        }

        .topbar-brand span {
            font-family: 'Playfair Display', serif;
            font-size: 17px;
            font-weight: 600;
            color: var(--gold);
            letter-spacing: 0.02em;
        }

        .topbar-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .topbar-user {
            font-size: 13px;
            color: var(--text-muted);
        }

        .topbar-user strong {
            color: var(--text);
            font-weight: 500;
        }

        .btn-logout {
            font-size: 13px;
            color: var(--text-dim);
            text-decoration: none;
            padding: 6px 14px;
            border: 1px solid var(--border);
            border-radius: 99px;
            transition: all 0.2s;
        }

        .btn-logout:hover {
            color: var(--red);
            border-color: var(--red);
        }

        /* ── Container ── */
        .container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 40px 32px;
        }

        /* ── Page Title ── */
        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 600;
            color: var(--text);
            margin-bottom: 8px;
        }

        .page-subtitle {
            font-size: 14px;
            color: var(--text-muted);
            margin-bottom: 36px;
        }

        /* ── Gold divider ── */
        .gold-line {
            width: 48px;
            height: 3px;
            background: linear-gradient(90deg, var(--gold), transparent);
            border-radius: 2px;
            margin: 12px 0 32px;
        }

        /* ── Cards grid ── */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
        }

        .card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 20px;
            text-align: center;
            cursor: pointer;
            transition: transform 0.2s, border-color 0.2s, box-shadow 0.2s;
            position: relative;
            overflow: hidden;
        }

        .card::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, var(--gold-dim), transparent);
            opacity: 0;
            transition: opacity 0.3s;
        }

        .card:hover {
            transform: translateY(-4px);
            border-color: rgba(201,168,76,0.3);
            box-shadow: 0 12px 40px rgba(0,0,0,0.4), 0 0 0 1px rgba(201,168,76,0.1);
        }

        .card:hover::before { opacity: 1; }

        .card-photo {
            width: 100%;
            aspect-ratio: 3/4;
            background: var(--surface2);
            border-radius: 10px;
            margin-bottom: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
        }

        .card-photo-placeholder {
            font-size: 40px;
            opacity: 0.3;
        }

        .card-nome {
            font-weight: 600;
            font-size: 14px;
            color: var(--text);
            line-height: 1.4;
            margin-bottom: 4px;
        }

        .card-empresa {
            font-size: 12px;
            color: var(--text-muted);
            line-height: 1.3;
        }

        .card-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 10px;
            height: 10px;
            background: var(--green);
            border-radius: 50%;
            box-shadow: 0 0 8px var(--green);
        }

        /* ── Form styles ── */
        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-size: 13px;
            font-weight: 500;
            color: var(--text-muted);
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 0.06em;
        }

        .form-label span {
            font-size: 11px;
            color: var(--text-dim);
            text-transform: none;
            letter-spacing: 0;
            font-weight: 400;
        }

        .form-input {
            width: 100%;
            padding: 12px 16px;
            background: var(--surface2);
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            color: var(--text);
            font-size: 15px;
            font-family: 'DM Sans', sans-serif;
            transition: border-color 0.2s, box-shadow 0.2s;
            appearance: none;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--gold);
            box-shadow: 0 0 0 3px rgba(201,168,76,0.1);
        }

        .form-input::placeholder { color: var(--text-dim); }

        /* ── Buttons ── */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            border-radius: var(--radius-sm);
            font-size: 14px;
            font-weight: 500;
            font-family: 'DM Sans', sans-serif;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--gold), #a8841a);
            color: #0d0d14;
            font-weight: 600;
        }

        .btn-primary:hover {
            transform: translateY(-1px);
            box-shadow: 0 8px 24px rgba(201,168,76,0.3);
        }

        .btn-primary:disabled {
            opacity: 0.4;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .btn-secondary {
            background: var(--surface2);
            color: var(--text-muted);
            border: 1px solid var(--border);
        }

        .btn-secondary:hover {
            color: var(--text);
            border-color: rgba(255,255,255,0.15);
        }

        /* ── Nota inputs ── */
        .nota-card {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 20px;
            margin-bottom: 16px;
            transition: border-color 0.2s;
        }

        .nota-card.filled {
            border-color: rgba(201,168,76,0.25);
        }

        .nota-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }

        .nota-title {
            font-size: 14px;
            font-weight: 600;
            color: var(--text);
        }

        .nota-range {
            font-size: 12px;
            color: var(--text-dim);
            background: var(--surface2);
            padding: 3px 10px;
            border-radius: 99px;
        }

        /* ── Annotations ── */
        .annotation-area {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 20px;
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .annotation-area h3 {
            font-family: 'Playfair Display', serif;
            font-size: 16px;
            font-weight: 600;
            color: var(--text);
            margin-bottom: 14px;
        }

        .annotation-area textarea {
            flex: 1;
            width: 100%;
            min-height: 260px;
            background: var(--surface2);
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            font-size: 14px;
            padding: 14px;
            resize: vertical;
            transition: border-color 0.2s;
        }

        .annotation-area textarea:focus {
            outline: none;
            border-color: rgba(124,106,240,0.5);
        }

        .annotation-area textarea::placeholder { color: var(--text-dim); }

        /* ── Layout: avaliação ── */
        .eval-layout {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 28px;
        }

        @media (max-width: 900px) {
            .eval-layout { grid-template-columns: 1fr; }
            .annotation-area textarea { min-height: 120px; }
        }

        /* ── Table ── */
        .table-wrapper {
            overflow-x: auto;
            border-radius: var(--radius);
            border: 1px solid var(--border);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }

        thead tr {
            background: var(--surface2);
        }

        th {
            padding: 14px 20px;
            text-align: left;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: var(--text-muted);
            white-space: nowrap;
        }

        tbody tr {
            border-top: 1px solid var(--border);
            transition: background 0.15s;
        }

        tbody tr:hover { background: var(--surface); }

        td {
            padding: 14px 20px;
            color: var(--text);
        }

        .rank-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 28px;
            height: 28px;
            border-radius: 50%;
            font-size: 12px;
            font-weight: 700;
        }

        .rank-1 { background: rgba(201,168,76,0.2); color: var(--gold); border: 1px solid var(--gold); }
        .rank-2 { background: rgba(192,192,192,0.15); color: #c0c0c0; border: 1px solid rgba(192,192,192,0.4); }
        .rank-3 { background: rgba(176,107,60,0.2); color: #b06b3c; border: 1px solid rgba(176,107,60,0.5); }
        .rank-other { background: var(--surface2); color: var(--text-dim); border: 1px solid var(--border); }

        .media-badge {
            font-family: 'Playfair Display', serif;
            font-size: 18px;
            font-weight: 700;
            color: var(--gold);
        }

        .progress-wrap {
            background: var(--surface2);
            border-radius: 99px;
            height: 6px;
            overflow: hidden;
            width: 100px;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--gold), var(--gold-light));
            border-radius: 99px;
        }

        /* ── Alert/error ── */
        .alert {
            padding: 12px 16px;
            border-radius: var(--radius-sm);
            font-size: 14px;
            margin-bottom: 20px;
        }

        .alert-error {
            background: rgba(224,92,92,0.1);
            border: 1px solid rgba(224,92,92,0.3);
            color: var(--red);
        }

        .alert-success {
            background: rgba(92,204,142,0.1);
            border: 1px solid rgba(92,204,142,0.3);
            color: var(--green);
        }

        /* ── Login ── */
        .login-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-box {
            width: 100%;
            max-width: 400px;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 48px 40px;
            box-shadow: var(--shadow);
            animation: fadeUp 0.5s ease;
        }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(24px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .login-logo {
            text-align: center;
            margin-bottom: 36px;
        }

        .login-crown {
            font-size: 48px;
            display: block;
            margin-bottom: 12px;
            filter: drop-shadow(0 0 20px rgba(201,168,76,0.5));
        }

        .login-title {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            font-weight: 700;
            color: var(--text);
            margin-bottom: 4px;
        }

        .login-sub {
            font-size: 13px;
            color: var(--text-dim);
        }

        /* ── Candidata header ── */
        .candidata-header {
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 24px 28px;
            margin-bottom: 28px;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .candidata-avatar {
            width: 64px;
            height: 64px;
            background: var(--surface2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            flex-shrink: 0;
            border: 2px solid var(--border);
        }

        .candidata-info h2 {
            font-family: 'Playfair Display', serif;
            font-size: 22px;
            font-weight: 600;
            color: var(--text);
        }

        .candidata-info p {
            font-size: 14px;
            color: var(--text-muted);
            margin-top: 4px;
        }

        /* ── Scrollbar ── */
        ::-webkit-scrollbar { width: 6px; height: 6px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: var(--surface2); border-radius: 99px; }

        /* ── Utility ── */
        .text-muted { color: var(--text-muted); }
        .mt-2 { margin-top: 8px; }
        .mt-4 { margin-top: 16px; }
        .mt-6 { margin-top: 24px; }
        .flex { display: flex; }
        .gap-3 { gap: 12px; }
        .items-center { align-items: center; }
        .justify-between { justify-content: space-between; }
    </style>
</head>
<body>
