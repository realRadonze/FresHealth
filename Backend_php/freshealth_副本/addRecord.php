<?php
include 'db_connect.php';

// 获取POST请求中的参数
$data = json_decode(file_get_contents('php://input'), true);
$id = $data['id'];
$aid = $data['aid'];
$count = floatval($data['count']); // 将 count 转换为浮点数
$time = $data['time'];

// 获取当前最大的recID
$sql_max_recID = "SELECT MAX(recID) AS max_recID FROM ActDb";
$result_max_recID = $conn->query($sql_max_recID);
$row_max_recID = $result_max_recID->fetch_assoc();
$max_recID = $row_max_recID['max_recID'];
$new_recID = $max_recID + 1;

// 获取活动的卡路里值
$sql_activity = "SELECT calorie FROM ActInfoDb WHERE aid = ?";
$stmt_activity = $conn->prepare($sql_activity);
$stmt_activity->bind_param("i", $aid);
$stmt_activity->execute();
$result_activity = $stmt_activity->get_result();
$row_activity = $result_activity->fetch_assoc();
$activity_calorie = $row_activity['calorie'];

// 计算新记录的卡路里数
$new_calorie = $activity_calorie * $count;

// 获取当前用户的卡路里数
$sql_bio = "SELECT calorie FROM BioDb WHERE id = ?";
$stmt_bio = $conn->prepare($sql_bio);
$stmt_bio->bind_param("i", $id);
$stmt_bio->execute();
$result_bio = $stmt_bio->get_result();
$row_bio = $result_bio->fetch_assoc();
$current_calorie = $row_bio['calorie'];

// 计算更新后的卡路里数
$updated_calorie = $current_calorie + $new_calorie;

// 更新BioDb表中的卡路里数
$sql_update_bio = "UPDATE BioDb SET calorie = ? WHERE id = ?";
$stmt_update_bio = $conn->prepare($sql_update_bio);
$stmt_update_bio->bind_param("di", $updated_calorie, $id);
$stmt_update_bio->execute();

// 准备SQL语句
$sql_add_record = "INSERT INTO ActDb (recID, id, aid, count, time) VALUES (?, ?, ?, ?, ?)";
$stmt_add_record = $conn->prepare($sql_add_record);
$stmt_add_record->bind_param("iiids", $new_recID, $id, $aid, $count, $time);

// 执行SQL语句并检查结果
$response = array();
if ($stmt_add_record->execute()) {
    $response['status'] = 'success';
    $response['updated_calorie'] = $updated_calorie;
} else {
    $response['status'] = 'error';
    $response['message'] = $stmt_add_record->error;
}

header('Content-Type: application/json');
echo json_encode($response);

// 关闭连接
$stmt_add_record->close();
$conn->close();
?>
