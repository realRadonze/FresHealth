<?php
include 'db_connect.php';
$userId = $_POST['id'];

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $data = json_decode(file_get_contents('php://input'), true);



    $target_dir = "photo/avatar/";
    $target_file = $target_dir . basename($_FILES["file"]["name"]);
    $uploadOk = 1;
    $imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));
    
    // 检查文件是否是图像
    $check = getimagesize($_FILES["file"]["tmp_name"]);
    if ($check !== false) {
        $uploadOk = 1;
    } else {
        echo json_encode(["status" => "error", "message" => "File is not an image."]);
        $uploadOk = 0;
    }
    
    // 限制文件大小
    if ($_FILES["file"]["size"] > 1000000) {
        echo json_encode(["status" => "error", "message" => "Sorry, your file is too large."]);
        $uploadOk = 0;
    }
    
    // 允许的文件格式
    if ($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg" && $imageFileType != "gif") {
        echo json_encode(["status" => "error", "message" => "Sorry, only JPG, JPEG, PNG & GIF files are allowed."]);
        $uploadOk = 0;
    }
    
    // 检查$uploadOk是否为0
    if ($uploadOk == 0) {
        echo json_encode(["status" => "error", "message" => "Sorry, your file was not uploaded."]);
    } else {
        // 如果文件已存在，直接覆盖
        if (move_uploaded_file($_FILES["file"]["tmp_name"], $target_file)) {
            $uploaded_file_url = "http://localhost:8888/freshealth/photo/avatar/" . basename($_FILES["file"]["name"]);
            
            // Update the avatar URL in the database
            if (isset($_POST['id'])) {
                

                $sql = "UPDATE UserDb SET avatar = ? WHERE id = ?";
                $stmt = $conn->prepare($sql);
                $stmt->bind_param("si", $uploaded_file_url, $userId);

                if ($stmt->execute()) {
                    echo json_encode(["status" => "success", "url" => $uploaded_file_url], JSON_UNESCAPED_SLASHES);
                } else {
                    echo json_encode(["status" => "error", "message" => "Database update failed."]);
                }

                $stmt->close();
                $conn->close();
            } else {
                echo json_encode(["status" => "error", "message" => "User ID not provided."]);
            }
        } else {
            echo json_encode(["status" => "error", "message" => "Sorry, there was an error uploading your file."]);
        }
    }
}
?>
