<?php
include 'koneksi.php';

// Pastikan request adalah POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Baca data yang dikirimkan dalam body permintaan
    $nama_pemilik = $_POST['nama_pemilik'];
    $alamat = $_POST['alamat'];
    $lokasi = $_POST['lokasi'];
    $deskripsi = $_POST['deskripsi'];
    $no_telpon = $_POST['no_telpon'];
    $email = $_POST['email'];
    $image = $_POST['image'];
    $akun_ig = $_POST['akun_ig'];
    $akun_fb = $_POST['akun_fb'];
    $akun_tiktok = $_POST['akun_tiktok'];

    // Siapkan pernyataan SQL untuk melakukan update data berdasarkan ID
    $sql = "UPDATE informations SET
            nama_pemilik = '$nama_pemilik',
            alamat = '$alamat',
            lokasi = '$lokasi',
            deskripsi = '$deskripsi',
            no_telpon = '$no_telpon',
            email = '$email',
            akun_ig = '$akun_ig',
            akun_fb ='$akun_fb',
            akun_tiktok = '$akun_tiktok'";

    // Tambahkan perubahan gambar jika data gambar tidak kosong
    if (!empty($image)) {
        $sql .= ", image = '$image'";
    }

    $sql .= " WHERE id = 1";

    // Jalankan pernyataan SQL
    if ($konek->query($sql) === TRUE) {
        echo json_encode(["message" => "Data berhasil diperbarui"]);
    } else {
        echo json_encode(["error" => "Gagal memperbarui data: " . $konek->error]);
    }
} else {
    echo json_encode(["error" => "Metode request harus POST"]);
}
?>
