<?php
// Establish a database connection
$con = new mysqli('localhost', 'root', 'LUPSroot2024', 'haskell_project_db');

// Check if the connection is successful
//if ($con->connect_error) {
//    die('Connection failed: ' . $con->connect_error);
//} else {
//    echo 'Connection successful!';
//}

// Close the database connection (optional but recommended)
//$con->close();
if(!$con){
    die(mysql_error($con));
}

?>
