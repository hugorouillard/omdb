<?php

require_once 'connection.php';

$debugEnabled = filter_var($env['DEBUG'] ?? false, FILTER_VALIDATE_BOOLEAN);
$publicHost = parse_url($env['PUBLIC_URL'] ?? '', PHP_URL_HOST);
$sessionToken = $env['DEVELOPMENT_SESSION_TOKEN'] ?? '';
$isLocalDevelopment = $debugEnabled
    && $env['DATABASE_HOST'] === 'db'
    && in_array($publicHost, ['localhost', '127.0.0.1'], true)
    && $sessionToken !== '';

if (!$isLocalDevelopment) {
    http_response_code(404);
    exit();
}

$stmt = $conn->prepare('SELECT 1 FROM sessions WHERE SessionToken = ? AND ExpiresAt > NOW()');
$stmt->bind_param('s', $sessionToken);
$stmt->execute();
$sessionExists = $stmt->get_result()->num_rows === 1;
$stmt->close();

if (!$sessionExists) {
    http_response_code(503);
    echo 'Development session is unavailable. Restart Docker Compose to load fixtures.';
    exit();
}

setcookie('SessionToken', $sessionToken, [
    'expires' => time() + 30 * 24 * 3600,
    'path' => '/',
    'secure' => false,
    'httponly' => true,
    'samesite' => 'Lax',
]);

$redirect = $_GET['redirect'] ?? '/';
if (!is_string($redirect) || !str_starts_with($redirect, '/') || str_starts_with($redirect, '//')) {
    $redirect = '/';
}

header('Location: ' . $redirect);
