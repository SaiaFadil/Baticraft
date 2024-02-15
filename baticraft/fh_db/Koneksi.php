<?php
$host = "localhost"; 
$username = "root"; 
$password = ""; 
$database = "fresh_harvest"; 

// Membuat koneksi
$konek = new mysqli($host, $username, $password, $database);

// Memeriksa koneksi
if ($konek->connect_error) {
    die("Koneksi gagal: " . $konek->connect_error);
}


?>
