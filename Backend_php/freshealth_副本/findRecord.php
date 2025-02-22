<?php
include 'db_connect.php';

// 获取请求中的用户ID
$user_id = isset($_POST['id']) ? intval($_POST['id']) : 0;

if ($user_id > 0) {
    // 查询ActDb表中与该用户ID相关的数据，并计算卡路里值
    $sql_act = "
        SELECT ActDb.recID, ActDb.id AS userID, ActDb.aid, ActDb.count, ActDb.time, 
               ActInfoDb.name, ActInfoDb.calorie AS calorie_per_unit,
               (ActDb.count * ActInfoDb.calorie) AS total_calorie
        FROM ActDb
        JOIN ActInfoDb ON ActDb.aid = ActInfoDb.aid
        WHERE ActDb.id = ?";
    $stmt_act = $conn->prepare($sql_act);
    $stmt_act->bind_param("i", $user_id);
    $stmt_act->execute();
    $result_act = $stmt_act->get_result();
    $records = array();
    if ($result_act->num_rows > 0) {
        while($row_act = $result_act->fetch_assoc()) {
            $row_act['recID'] = (int)$row_act['recID'];
            $row_act['userID'] = (int)$row_act['userID']; // Ensure userID is included
            $records[] = $row_act;
        }
    }
    // 将数据转换为JSON格式
    echo json_encode($records);
} else {
    echo json_encode([]);
}

// 关闭连接
$conn->close();
?>
