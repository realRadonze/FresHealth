<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
include 'db_connect.php';

$user_username = isset($_POST['username']) ? $_POST['username'] : '';
$user_password = isset($_POST['password']) ? $_POST['password'] : '';
$user_email = isset($_POST['email']) ? $_POST['email'] : '';
$height = isset($_POST['height']) ? $_POST['height'] : '';
$weight = isset($_POST['weight']) ? $_POST['weight'] : '';
$expectWeight = isset($_POST['expectWeight']) ? $_POST['expectWeight'] : '';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (!empty($user_username) && !empty($user_password) && !empty($user_email)) {
        // 检查用户名是否已被使用
        $checkUsernameSql = "SELECT COUNT(*) AS count FROM UserDb WHERE username = ?";
        $checkUsernameStmt = $conn->prepare($checkUsernameSql);
        $checkUsernameStmt->bind_param("s", $user_username);
        $checkUsernameStmt->execute();
        $checkUsernameResult = $checkUsernameStmt->get_result();
        $checkUsernameData = $checkUsernameResult->fetch_assoc();

        if ($checkUsernameData['count'] > 0) {
            echo "Username already taken. Please choose another username.";
        } else {
            // 获取当前最大ID
            $sql = "SELECT MAX(id) AS max_id FROM UserDb";
            $result = $conn->query($sql);
            $row = $result->fetch_assoc();
            $max_id = $row['max_id'] + 1;
            $permission = 1;

            $stmt = $conn->prepare("INSERT INTO UserDb (id, username, password, email, permission, avatar, height, weight, expectWeight) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
            $null = NULL; // Use a variable to hold the NULL value
            $stmt->bind_param("isssissss", $max_id, $user_username, $user_password, $user_email, $permission, $null, $height, $weight, $expectWeight);

            if ($stmt->execute()) {
                // 注册成功后，为用户在 BioDb 创建一条新记录
                $bioStmt = $conn->prepare("INSERT INTO BioDb (id, calorie, water, passed, date) VALUES (?, 0, 0, 0, ?)");
                $currentDateTime = date('Y-m-d H:i:s');
                $bioStmt->bind_param("is", $max_id, $currentDateTime);
                $bioStmt->execute();
                $bioStmt->close();

                // 获取用户的 calorie 和 water 值
                $bioSql = "SELECT calorie, water FROM BioDb WHERE id = ?";
                $bioStmt = $conn->prepare($bioSql);
                $bioStmt->bind_param("i", $max_id);
                $bioStmt->execute();
                $bioResult = $bioStmt->get_result();
                $bioData = $bioResult->fetch_assoc();

                echo json_encode([
                    "success" => true,
                    "userId" => $max_id,
                    "username" => $user_username,
                    "email" => $user_email,
                    "height" => $height,
                    "weight" => $weight,
                    "expectWeight" => $expectWeight,
                    "calorie" => $bioData['calorie'],
                    "water" => $bioData['water']
                ]);
            } else {
                echo "Error: " . $stmt->error;
            }
            $stmt->close();
        }
        $checkUsernameStmt->close();
    } else {
        echo "All fields are required.";
    }
}
$conn->close();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
</head>
<body>
    <h1>User Registration</h1>
    <form action="register.php" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>
        <label for="email">Email:</label>
       email" id="email" name="email" required><br><br>
        <label for="height">Height (cm):</label>
        <input type="text" id="height" name="height" required><br><br>
        <label for="weight">Weight (kg):</label>
        <input type="text" id="weight" name="weight" required><br><br>
        <label for="expectWeight">Expected Weight (kg):</label>
        <input type="text" id="expectWeight" name="expectWeight" required><br><br>
        <input type="submit" value="Register">
    </form>
    <h2>Registration Result</h2>
    <ul>
        <li><strong>Username:</strong> <?php echo htmlspecialchars($user_username); ?></li>
        <li><strong>Email:</strong> <?php echo htmlspecialchars($user_email); ?></li>
    </ul>
</body>
</html>
