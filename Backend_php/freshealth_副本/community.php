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


// 查询所有帖子
$stmt = $pdo->query("SELECT * FROM PostDb");
$posts = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>帖子列表</title>
</head>
<body>
    <h1>帖子列表</h1>
    <a href="createPost.php">发布新帖子</a>
    <ul>
        <?php foreach ($posts as $post): ?>
            <li>
                <a href="viewPost.php?postid=<?= $post['postid'] ?>">
                    <?= htmlspecialchars($post['title']) ?>
                </a>
                <p><?= htmlspecialchars($post['content']) ?></p>
                <small>发布时间: <?= $post['time'] ?></small>
            </li>
        <?php endforeach; ?>
    </ul>
</body>
</html>