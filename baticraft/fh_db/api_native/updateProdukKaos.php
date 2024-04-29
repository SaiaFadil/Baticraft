<?php
require('Koneksi.php');

// Mengambil data produk dari request
$nama = $_POST['nama'];
$deskripsi = $_POST['deskripsi'];
$harga = $_POST['harga'];
$stok = $_POST['stok'];
$ukuran = isset($_POST['ukuran']) ? $_POST['ukuran'] : null;
$bahan = isset($_POST['bahan']) ? $_POST['bahan'] : null;
$panjang_kain = $_POST['panjang_kain'];
$lebar_kain = $_POST['lebar_kain'];
$jenis_batik = $_POST['jenis_batik'];
$jenis_lengan = isset($_POST['jenis_lengan']) ? $_POST['jenis_lengan'] : null;
$id = $_POST['id_produk']; // ID produk yang akan diperbarui

// Memeriksa apakah ada gambar yang diunggah
if (isset($_FILES['images']) && !empty($_FILES['images']['name'])) {
    // Menghapus gambar produk yang lama dari direktori
    $sql_select_image = "SELECT image_path FROM image_products WHERE product_id=$id";
    $result_select_image = $konek->query($sql_select_image);
    if ($result_select_image->num_rows > 0) {
        while ($row_image = $result_select_image->fetch_assoc()) {
            unlink("images/" . $row_image['image_path']);
        }
    }

    // Menghapus gambar produk yang lama dari tabel image_products
    $sql_delete_image = "DELETE FROM image_products WHERE product_id=$id";
    $konek->query($sql_delete_image);

    // Memproses setiap gambar yang diunggah
    $total_images = count($_FILES['images']['name']);
    for ($i = 0; $i < $total_images; $i++) {
        $image_path = $_FILES['images']['name'][$i];
        // Direktori penyimpanan gambar
        $target_dir = "images/";
        // Path lengkap file gambar
        $target_file = $target_dir . basename($_FILES["images"]["name"][$i]);
        // Ekstensi file
        $imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));
        // Nama file gambar yang disimpan di database
        $image_name = "product_image_" . uniqid() . "." . $imageFileType;
        // Simpan gambar ke direktori
        if (move_uploaded_file($_FILES["images"]["tmp_name"][$i], $target_dir . $image_name)) {
            // Menyimpan informasi gambar ke tabel image_products
            $sql_image = "INSERT INTO image_products (product_id, image_path) VALUES ('$id', '$image_name')";
            $konek->query($sql_image);
        } else {
            echo "Maaf, terjadi kesalahan saat mengunggah gambar.";
        }
    }
}

// Memperbarui informasi produk di tabel products
$sql_update_product = "UPDATE products 
        SET  nama='$nama', deskripsi='$deskripsi', harga='$harga', stok='$stok', ukuran='$ukuran', bahan='$bahan', panjang_kain='$panjang_kain', lebar_kain='$lebar_kain', jenis_batik='$jenis_batik', jenis_lengan='$jenis_lengan' 
        WHERE id=$id";

if ($konek->query($sql_update_product) === TRUE) {
    // Menampilkan pesan sukses
    echo json_encode(array("message" => "Produk berhasil diperbarui."));
} else {
    // Jika terjadi kesalahan saat memperbarui produk
    echo json_encode(array("error" => "Terjadi kesalahan saat memperbarui produk: " . $konek->error));
}

// Menutup koneksi database
mysqli_close($konek);
?>
