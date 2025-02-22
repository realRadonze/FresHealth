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


// 获取帖子 ID
$postid = $_GET['postid'] ?? 0;

// 查询帖子
$stmt = $pdo->prepare("SELECT * FROM PostDb WHERE postid = ?");
$stmt->execute([$postid]);
$post = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$post) {
    die("帖子不存在");
}

// 查询评论
$stmt = $pdo->prepare("SELECT * FROM CommentDb WHERE postid = ?");
$stmt->execute([$postid]);
$comments = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title><?= htmlspecialchars($post['title']) ?></title>
</head>
<body>
    <h1><?= htmlspecialchars($post['title']) ?></h1>
    <p><?= htmlspecialchars($post['content']) ?></p>
    <small>发布时间: <?= $post['time'] ?></small>

    <h2>评论</h2>
    <ul>
        <?php foreach ($comments as $comment): ?>
            <li>
                <p><?= htmlspecialchars($comment['content']) ?></p>
                <small>评论时间: <?= $comment['time'] ?></small>
            </li>
        <?php endforeach; ?>
    </ul>

    <a href="community.php">返回帖子列表</a>
</body>
</html>