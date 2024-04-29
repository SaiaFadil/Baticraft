<?php
require ('Koneksi.php');

// Mengambil data produk dari request
$kode_product = $_POST['kode_product'];
$nama = $_POST['nama'];
$deskripsi = $_POST['deskripsi'];
$harga = $_POST['harga'];
$kategori = $_POST['kategori'];
$stok = $_POST['stok'];
$ukuran = isset($_POST['ukuran']) ? $_POST['ukuran'] : null;
$bahan = isset($_POST['bahan']) ? $_POST['bahan'] : null;
$panjang_kain = $_POST['panjang_kain'];
$lebar_kain = $_POST['lebar_kain'];
$jenis_batik = $_POST['jenis_batik'];
$jenis_lengan = isset($_POST['jenis_lengan']) ? $_POST['jenis_lengan'] : null;
$status = $_POST['status'];

// Menyimpan informasi produk ke tabel products
$sql = "INSERT INTO products (kode_product, nama, deskripsi, harga, kategori, stok, ukuran, bahan, panjang_kain, lebar_kain, jenis_batik, jenis_lengan, status) 
        VALUES ('$kode_product', '$nama', '$deskripsi', '$harga', '$kategori', '$stok', '$ukuran', '$bahan', '$panjang_kain', '$lebar_kain', '$jenis_batik', '$jenis_lengan', '$status')";

if ($konek->query($sql) === TRUE) {
    // Jika produk berhasil disimpan, ambil id produk yang baru saja disimpan
    $last_product_id = $konek->insert_id;

    // Memeriksa apakah ada gambar yang diunggah
    if (isset($_FILES['images']) && !empty($_FILES['images']['name'])) {
        // Memproses setiap gambar yang diunggah
        $total_images = count($_FILES['images']['name']);
        for ($i = 0; $i < $total_images; $i++) {
            $image_path = $_FILES['images']['name'][$i];
            // Direktori penyimpanan gambar
            $target_dir = "images/";
            // Path lengkap file gambar
            $target_file = $target_dir . basename($_FILES["images"]["name"][$i]);
            // Ekstensi file
            $imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));
            // Nama file gambar yang disimpan di database
            $image_name = "product_image_" . uniqid() . "." . $imageFileType;
            // Simpan gambar ke direktori
            if (move_uploaded_file($_FILES["images"]["tmp_name"][$i], $target_dir . $image_name)) {
                // Menyimpan informasi gambar ke tabel image_products
                $sql_image = "INSERT INTO image_products (product_id, image_path) VALUES ('$last_product_id', '$image_name')";
                $konek->query($sql_image);
            } else {
                echo "Maaf, terjadi kesalahan saat mengunggah gambar.";
            }
        }
    }
    // Menampilkan pesan sukses
    echo json_encode(array("message" => "Produk dan gambar berhasil disimpan."));
} else {
    // Jika terjadi kesalahan saat menyimpan produk
    echo json_encode(array("error" => "Terjadi kesalahan saat menyimpan produk: " . $konek->error));
}

// Menutup koneksi database
mysqli_close($konek);
