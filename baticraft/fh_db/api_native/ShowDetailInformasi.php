<?php
require 'Koneksi.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $sql = "SELECT * FROM informations;";
    $result = $konek->query($sql);
    $DetailInfo = $result->fetch_assoc();
    $response = $DetailInfo;
    echo json_encode($response);
    mysqli_close($konek);

} else {
    die ("Method is not GET");
}
