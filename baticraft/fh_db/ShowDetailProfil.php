<?php
require 'Koneksi.php';

$id_user = $_POST['id_user'];

$sql = "SELECT * FROM users WHERE id_user = '$id_user';";
$result = $konek->query($sql);
$DetailUser = $result->fetch_assoc();
$response = $DetailUser;
echo json_encode($response);
mysqli_close($konek);

?>