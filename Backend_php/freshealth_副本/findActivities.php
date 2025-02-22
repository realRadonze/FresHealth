<?php
include 'db_connect.php';

// 查询ActInfoDb表中的所有活动信息
$sql_act_info = "SELECT aid, type, name, description, calorie FROM ActInfoDb";
$result_act_info = $conn->query($sql_act_info);

$activities = array();
if ($result_act_info->num_rows > 0) {
    while($row_act_info = $result_act_info->fetch_assoc()) {
        $row_act_info['aid'] = (int)$row_act_info['aid']; 
        $row_act_info['type'] = (int)$row_act_info['type'];
        $row_act_info['calorie'] = (double)$row_act_info['calorie']; 
        $activities[] = $row_act_info;
    }
}

// 将数据转换为JSON格式
echo json_encode($activities);

// 关闭连接
$conn->close();
?>