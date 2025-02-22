<?php
include 'db_connect.php';
session_start();
if (!isset($_SESSION['userId'])) {
    header("Location: login.html");
    exit();
}
$userId = $_SESSION['userId'];

// SQL 查询
$sql = "SELECT id, username, password, email, permission, avatar, weight, height, expectWeight FROM UserDb WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $userId);
$stmt->execute();
$result = $stmt->get_result();

// 检查用户是否存在
if ($result->num_rows > 0) {
    $userData = $result->fetch_assoc();
} else {
    echo "User not found.";
    exit();
}
$stmt->close();
$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Main Page</title>
</head>
<body>
    <h2>Welcome, <?php echo htmlspecialchars($userData['username']); ?></h2>
    <p>ID: <?php echo htmlspecialchars($userData['id']); ?></p>
    <p>Email: <?php echo htmlspecialchars($userData['email']); ?></p>
    <p>Permission: <?php echo htmlspecialchars($userData['permission']); ?></p>
    <p>Avatar: <?php echo htmlspecialchars($userData['avatar'] ?? '无'); ?></p>
    <p>Weight: <?php echo htmlspecialchars($userData['weight']); ?></p>
    <p>Height: <?php echo htmlspecialchars($userData['height']); ?></p>
    <p>Expected Weight: <?php echo htmlspecialchars($userData['expectWeight']); ?></p>
    
    <form action="logout.php" method="post">
        <input type="submit" value="Logout">
    </form>
</body>
</html>