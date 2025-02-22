<?php
include 'db_connect.php';

// Insert new data if form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $aid = $_POST['aid'];
    $type = $_POST['type'];
    $name = $_POST['name'];
    $description = $_POST['description'];
    $calorie = $_POST['calorie'];

    $sql = "INSERT INTO ActInfoDb (aid, type, name, description, calorie) VALUES ('$aid', '$type', '$name', '$description', '$calorie')";

    if ($conn->query($sql) === TRUE) {
        echo "New record created successfully";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}

// Retrieve existing data
$sql = "SELECT aid, type, name, description, calorie FROM ActInfoDb";
$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ActInfoDb Input Form</title>
    <style>
        collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>ActInfoDb Input Form</h1>
    <form action="" method="post">
        <label for="aid">AID:</label><br>
        <input type="number" id="aid" name="aid" required><br><br>
        
        <label for="type">Type:</label><br>
        <input type="number" id="type" name="type" required><br><br>
        
        <label for="name">Name:</label><br>
        <input type="text" id="name" name="name" required><br><br>
        
        <label for="description">Description:</label><br>
        <input type="text" id="description" name="description" required><br><br>
        
        <label for="calorie">Calorie:</label><br>
        <input type="number" step="0.01" id="calorie" name="calorie" required><br><br>
        
        <input type="submit" value="Submit">
    </form>

    <h2>Existing Data</h2>
    <table>
        <tr>
            <th>AID</th>
            <th>Type</th>
            <th>Name</th>
            <th>Description</th>
            <th>Calorie</th>
        </tr>
        <?php
        if ($result->num_rows > 0) {
            // Output data of each row
            while($row = $result->fetch_assoc()) {
                echo "<tr>
                        <td>" . $row["aid"]. "</td>
                        <td>" . $row["type"]. "</td>
                        <td>" . $row["name"]. "</td>
                        <td>" . $row["description"]. "</td>
                        <td>" . $row["calorie"]. "</td>
                      </tr>";
            }
        } else {
            echo "<tr><td colspan='5'>No data found</td></tr>";
        }
        $conn->close();
        ?>
    </table>
</body>
</html>