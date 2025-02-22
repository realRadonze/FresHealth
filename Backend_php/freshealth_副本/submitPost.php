<?php
// 连接数据库
$host = "localhost";
$username = "root";
$password = "root";
$dbname = "freshealth";

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("数据库连接失败: " . $e->getMessage());
}

// 获取表单数据
$title = $_POST['title'] ?? '';
$content = $_POST['content'] ?? '';
$userid = 1; // 假设当前用户 ID 为 1

if (empty($title) || empty($content)) {
    die("标题和内容不能为空");
}

// 插入新帖子
$stmt = $pdo->prepare("INSERT INTO PostDb (id, postid, title, content, like, time) VALUES (?, ?, ?, ?, 0, NOW())");
$stmt->execute([$userid, null, $title, $content]);

// 重定向到帖子列表
header("Location: community.php");
exit;