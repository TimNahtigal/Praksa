<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        td{
            border: 1px solid black;
        }
    </style>
</head>
<body>
    
    <form method="POST">
        <input type="text" name="ip">
        <button type="submit">Pošlji</button>
    </form>
    <hr>

    <table style="border:1px solid black; border-collapse:collapse;">
        <tr>
            <td>ID</td>
            <td>TIMESTAMP</td>
            <td>IP</td>
            <td>DOMENA</td>
            <td>URL</td>
        </tr>

        <?php

        $conn = new mysqli("localhost", "prog", "pass", "praksa");

        
        if(isset($_POST["ip"])){
            $sql = "SELECT * FROM uservisits WHERE ip='$_POST[ip]'";
            $result = $conn->query($sql);
            if ($result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td> $row[idUserVisits] </td>";
            echo "<td> $row[timestamp] </td>";
            echo "<td> $row[ip]</td>";
            echo "<td> $row[domain]  </td>";
            echo "<td> $row[url]  </td>";
            echo "</tr>";
            }
        }

        }else{
            $sql = "SELECT * FROM uservisits";
            $result = $conn->query($sql);
            if ($result->num_rows > 0) {
                while($row = $result->fetch_assoc()) {
                echo "<tr>";
                echo "<td> $row[idUserVisits] </td>";
                echo "<td> $row[timestamp]  </td>";
                echo "<td> $row[ip]</td>";
                echo "<td> $row[url]  </td>";
                echo "<td> $row[domain]  </td>";
                echo "</tr>";
                }
            }
        }
        $conn->close();
        ?>

    </table>
</body>
</html>



