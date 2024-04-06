<?php
// Koneksi ke database
require_once('Koneksi.php');

// Query untuk mendapatkan kode produk terbaru dari database
$sql = "SELECT kode_product FROM products ORDER BY id DESC LIMIT 1";
$result = $konek->query($sql);

if ($result->num_rows > 0) {
    // Jika terdapat hasil dari query
    $row = $result->fetch_assoc();
    $lastProductCode = $row['kode_product'];

    // Mendapatkan angka dari kode produk terbaru
    $lastNumber = intval(substr($lastProductCode, 3));

    // Menambah 1 ke angka terakhir dan membuat kode produk baru
    $nextNumber = $lastNumber + 1;
    $nextProductCode = 'BTK' . str_pad($nextNumber, 3, '0', STR_PAD_LEFT);
} else {
    // Jika tidak ada produk di database, kode produk baru akan dimulai dari BTK001
    $nextProductCode = 'BTK001';
}

// Mengirimkan kode produk berikutnya sebagai respon
echo $nextProductCode;

// Menutup koneksi ke database
mysqli_close($konek);
