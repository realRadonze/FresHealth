<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>发布新帖子</title>
</head>
<body>
    <h1>发布新帖子</h1>
    <form action="submitPost.php" method="post">
        <label for="title">标题:</label>
        <input type="text" id="title" name="title" required>
        <br>
        <label for="content">内容:</label>
        <textarea id="content" name="content" required></textarea>
        <br>
        <button type="submit">发布</button>
    </form>
    <a href="index.php">返回帖子列表</a>
</body>
</html>