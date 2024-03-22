<?php
require 'Koneksi.php';

$id_user = $_GET['id_user'];
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $sql = "SELECT * FROM users";
    $result = $konek->query($sql);
    $DetailUser = $result->fetch_assoc();
    $response = $DetailUser;
    echo json_encode($response);
    mysqli_close($konek);

} else {
    die ("Method is not get");
}
