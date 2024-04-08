<?php
require('Koneksi.php');

$id_produk = $_POST['id_produk'];

// Hapus data gambar dari tabel image_products
$sql_delete_images = "DELETE FROM image_products WHERE product_id='$id_produk'";
if ($konek->query($sql_delete_images) === TRUE) {
    // Hapus data produk dari tabel products
    $sql_delete_product = "DELETE FROM products WHERE id='$id_produk'";
    if ($konek->query($sql_delete_product) === TRUE) {
        echo json_encode(array("message" => "Data produk dan gambar berhasil dihapus."));
    } else {
        echo json_encode(array("error" => "Terjadi kesalahan saat menghapus data produk: " . $konek->error));
    }
} else {
    echo json_encode(array("error" => "Terjadi kesalahan saat menghapus data gambar: " . $konek->error));
}

// Menutup koneksi database
mysqli_close($konek);
?>
