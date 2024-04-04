
<?php

require 'Koneksi.php';

// Menangkap data yang dikirimkan dari form
$kode_product = $_POST['kode_product'];
$nama = $_POST['nama'];
$deskripsi = $_POST['deskripsi'];
$harga = $_POST['harga'];
$kategori = $_POST['kategori'];
$stok = $_POST['stok'];
$ukuran = $_POST['ukuran'];
$bahan = $_POST['bahan'];
$panjang_kain = $_POST['panjang_kain'];
$jenis_batik = $_POST['jenis_batik'];
$jenis_lengan = $_POST['jenis_lengan'];
$status = $_POST['status'];

// Membuat dan mengeksekusi query SQL untuk insert
$sql = "INSERT INTO nama_tabel (kode_product, nama, deskripsi, harga, kategori, stok, ukuran, bahan, panjang_kain,  jenis_batik, jenis_lengan, status) 
        VALUES ('$kode_product', '$nama', '$deskripsi', '$harga', '$kategori', '$stok', '$ukuran', '$bahan', '$panjang_kain',  '$jenis_batik', '$jenis_lengan', '$status')";

if ($konek->query($sql) === TRUE) {
    echo "Data berhasil ditambahkan";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

// Menutup koneksi database
$conn->close();

?>