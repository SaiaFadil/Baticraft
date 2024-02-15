<?php
require('Koneksi.php');

header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];

    $email = mysqli_real_escape_string($konek, $email);

    $sql = "SELECT * FROM users WHERE email = '$email' AND password = '$password' LIMIT 1";
    $result = $konek->query($sql);
    $response = [];
    $user = $result->fetch_assoc();
    if ($result->num_rows == 1) {
        $role_db = $user['role'];
        if ($role_db == 'pembeli') {
            $response = $user;
        } else {
            // $response = $user;
            $response =  Array();
        }
    } else {
        // $response = $user;
        $response =  Array();
    }
} else {
    die("Method is not post");
}

echo json_encode($response);
mysqli_close($konek);
?>