<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
include 'db_connect.php';
session_start();

// 获取用户名和密码
$user = $_POST['username'] ?? '';
$pass = $_POST['password'] ?? '';

// 验证输入是否为空
if (empty($user) || empty($pass)) {
    echo json_encode(["success" => false, "error" => "Username and password are required"]);
    exit();
}

// SQL 查询
$sql = "SELECT * FROM UserDb WHERE username = ? AND password = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ss", $user, $pass);
$stmt->execute();
$result = $stmt->get_result();

// 检查用户是否存在
if ($result->num_rows > 0) {
    // 用户验证成功
    $userData = $result->fetch_assoc();
    $_SESSION['userId'] = $userData['id'];
    $_SESSION['username'] = $userData['username'];

    // 获取用户的calorie和water值
    $bioSql = "SELECT calorie, water FROM BioDb WHERE id = ?";
    $bioStmt = $conn->prepare($bioSql);
    $bioStmt->bind_param("i", $userData['id']);
    $bioStmt->execute();
    $bioResult = $bioStmt->get_result();
    $bioData = $bioResult->fetch_assoc();

    echo json_encode([
        "success" => true,
        "userId" => $userData['id'],
        "username" => $userData['username'],
        "email" => $userData['email'],
        "height" => $userData['height'],
        "weight" => $userData['weight'],
        "expectWeight" => $userData['expectWeight'],
        "calorie" => $bioData['calorie'],
        "water" => $bioData['water']
    ]);
} else {
    // 用户验证失败
    echo json_encode(["success" => false, "error" => "Invalid username or password"]);
}

$stmt->close();
$conn->close();
?>
