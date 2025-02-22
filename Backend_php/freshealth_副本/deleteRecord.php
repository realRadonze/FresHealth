<?php
include 'db_connect.php';

// 获取要删除的记录ID
$record_id = $_POST['id'];

// 删除记录
$sql_delete = "DELETE FROM ActDb WHERE recID = ?";
$stmt_delete = $conn->prepare($sql_delete);
$stmt_delete->bind_param("i", $record_id);

$response = array();
if ($stmt_delete->execute()) {
    if ($stmt_delete->affected_rows > 0) {
        $response['status'] = 'success';
    } else {
        $response['status'] = 'error';
        $response['message'] = 'No record found with the specified ID.';
    }
} else {
    $response['status'] = 'error';
    $response['message'] = $stmt_delete->error;
}

// 返回JSON响应
echo json_encode($response);

// 关闭连接
$conn->close();
?>