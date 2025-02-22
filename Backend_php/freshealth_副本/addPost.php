<?php
include 'db_connect.php';

// 获取POST请求中的参数
$data = json_decode(file_get_contents('php://input'), true);
$id = $data['id'];
$title = $data['title'];
$content = $data['content'];
$time = $data['time'];
$photo = $data['photoURL'];

// 获取当前最大的postid
$sql_max_postID = "SELECT MAX(postid) AS max_postID FROM PostDb";
$result_max_postID = $conn->query($sql_max_postID);
$row_max_postID = $result_max_postID->fetch_assoc();
$max_postID = $row_max_postID['max_postID'];
$new_postID = $max_postID + 1;

// 更新BioDb表中的卡路里数
$sql_update_bio = "UPDATE BioDb SET calorie = ? WHERE id = ?";
$stmt_update_bio = $conn->prepare($sql_update_bio);
$stmt_update_bio->bind_param("di", $updated_calorie, $id);
$stmt_update_bio->execute();

// 准备SQL语句
$sql_add_post = "INSERT INTO PostDb (id, postid, title, content, like, time, photo)";
$stmt_add_post = $conn->prepare($sql_add_post);
$stmt_add_post->bind_param("iissids", $new_recID, $id, $postid, $title, $content, $like, $time, $photo);

// 执行SQL语句并检查结果
$response = array();
if ($stmt_add_post->execute()) {
    $response['status'] = 'success';
    $response['updated_calorie'] = $updated_calorie;
} else {
    $response['status'] = 'error';
    $response['message'] = $stmt_add_post->error;
}

header('Content-Type: application/json');
echo json_encode($response);

// 关闭连接
$stmt_add_post->close();
$conn->close();
?>
