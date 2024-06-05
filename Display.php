<?php
include 'conn.php';
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HASKELL LTD</title>
    <link rel="stylesheet" href ="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
   body {
            background-image: url('image.jpg');
            /* Define how the background image should be displayed */
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed; /* Keeps the background fixed while scrolling */
            /* Add some fallback background color */
            background-color: #f5f5f5;
        }
    h1{
      color: black;
      text-align: center;
      text-shadow: 3px 3px gray; 
    }
  </style>
</head>
<body>
<h1>HASKELL LTD EMPLOYEE BARCODE GENERATOR</h1><br><br>
<div class="container">
    
    <table class="table table-dark table-hover">
  <thead>
    <tr>
      <th scope="col">F_Name</th>
      <th scope="col">L_Name</th>
      <th scope="col">Employee_ID_No</th>
      <th scope="col">Has_Barcode</th>
      <th scope="col">Operations</th>
    </tr>
  </thead>
  <tbody>
<?php
$sql="SELECT * FROM employees";
$result=mysqli_query($con,$sql);
if($result){
  while($row=mysqli_fetch_assoc($result)){
    $F_Name=$row['F_Name'];
   $L_Name=$row['L_Name'];
   $Employee_ID_No=$row['Employee_ID_No'];
   $Has_Barcode=$row['Has_Barcode'];
  
   echo '<tr>
   <th scope="row">'.$F_Name.'</th>
   <td>'.$L_Name.'</td>
   <td>'.$Employee_ID_No.'</td>
   <td>'.$Has_Barcode.'</td>
  
   <td>
   <form action="generate.php" method="get" style="display:inline;">
   <input type="hidden" name="barcode" value="' . $Employee_ID_No . '">
   <button type="submit" class="btn btn-primary">Generate</button>
</form>
</td>

 </tr>';
  }
}
?>

  </tbody>
</table>
</div>
<div class="btn">
        <button class="btn btn-primary"><a href="web1.html" class="text-light" >HOME</a></button><br><br>      
</div>
</body>
</html>