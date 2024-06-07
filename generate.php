<?php
include_once 'conn.php';

if ($_SERVER['REQUEST_METHOD'] == 'GET' && isset($_GET['barcode'])) {
    $barcode = $_GET['barcode'];

    // Validate the input barcode number
    if (preg_match('/^\d{13}$/', $barcode)) {
        // Path to the Haskell executable
        $haskellExecutable = 'generateBarcode.exe';  // Ensure this is the correct path to the executable

        // Check if the executable exists
        if (!file_exists($haskellExecutable)) {
            echo "<h1>Error</h1>";
            echo "<p>The Haskell executable was not found at $haskellExecutable.</p>";
            exit;
        }

        // Run the Haskell program via cmd.exe for Windows
        $command = escapeshellcmd("cmd /c \"$haskellExecutable $barcode\"");
        $output = shell_exec("$command 2>&1");

        // Check if the barcode image was created
        if (file_exists('ean13.bmp')) {
            echo "<h1>Barcode Generated</h1>";
            echo "<img src='ean13.bmp' alt='EAN-13 Barcode'>";

            // Update the Has_Barcode field in the database
            $updateQuery = "UPDATE employees SET Has_Barcode = 1 WHERE Employee_ID_No = ?";
            $stmt = $con->prepare($updateQuery);
            $stmt->bind_param("s", $barcode);
            if ($stmt->execute()) {
                echo "<p>Database updated successfully.</p>";
            } else {
                echo "<p>Error updating database: " . $stmt->error . "</p>";
            }
            $stmt->close();
        } else {
            echo "<h1>Error</h1>";
            echo "<p>Failed to generate the barcode image.</p>";
            echo "<pre>$output</pre>"; // Display Haskell program output for debugging
        }
    } else {
        echo "<h1>Invalid Input</h1>";
        echo "<p>Please enter a valid 13-digit EAN-13 barcode number.</p>";
    }
} else {
    echo "<h1>Invalid Request</h1>";
    echo "<p>Please use the form to submit the barcode number.</p>";
}

$con->close();
?>
