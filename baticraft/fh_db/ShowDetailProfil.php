<?php
require 'Koneksi.php';

$id_user = $_POST['id_user'];
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $sql = "SELECT * FROM users where id =  '$id_user'";
    $result = $konek->query($sql);
    $DetailUser = $result->fetch_assoc();
    $response = $DetailUser;
    echo json_encode($response);
    mysqli_close($konek);
} else {
    die ("Method is not POST");
}
