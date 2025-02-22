<?php
include 'db_connect.php';

// 获取POST请求中的参数
$data = json_decode(file_get_contents('php://input'), true);
$id = $data['id'];

// 获取当前用户的 water 值
$sql_bio = "SELECT water FROM BioDb WHERE id = ?";
$stmt_bio = $conn->prepare($sql_bio);
$stmt_bio->bind_param("i", $id);
$stmt_bio->execute();
$result_bio = $stmt_bio->get_result();
$row_bio = $result_bio->fetch_assoc();
$current_water = $row_bio['water'];

// 增加 water 值
$new_water = $current_water + 1;

// 更新BioDb表中的 water 值
$sql_update_bio = "UPDATE BioDb SET water = ? WHERE id = ?";
$stmt_update_bio = $conn->prepare($sql_update_bio);
$stmt_update_bio->bind_param("ii", $new_water, $id);
$stmt_update_bio->execute();

// 准备响应
$response = array();
if ($stmt_update_bio->execute()) {
    $response['status'] = 'success';
} else {
    $response['status'] = 'error';
    $response['message'] = $stmt_update_bio->error;
}

header('Content-Type: application/json');
echo json_encode($response);

// 关闭连接
$stmt_update_bio->close();
$conn->close();
?>