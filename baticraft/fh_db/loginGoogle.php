<?php
require('Koneksi.php');

$email = $_POST['email'];

// Query untuk memeriksa apakah email ada dalam database
$sql_check_email = "SELECT * FROM users WHERE email = '$email'";
$result = $konek->query($sql_check_email);

if ($result->num_rows > 0) {
    // Jika email ditemukan, kirimkan data user sebagai respons
    $row = $result->fetch_assoc();
    echo json_encode($row);
} else {
    // Jika email tidak ditemukan, kirimkan respons kosong
    echo json_encode(array());
}

// Menutup koneksi database
mysqli_close($konek);
?>
