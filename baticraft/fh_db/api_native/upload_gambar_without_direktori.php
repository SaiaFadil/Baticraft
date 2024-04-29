<?php
require('Koneksi.php');

// Data ID produk dan daftar nama file gambar
$id_produk = $_POST['id_produk'];
$image_paths = $_POST['image_paths']; // Array berisi daftar nama file gambar
$response = [];

// Memeriksa apakah terdapat data nama file gambar yang akan ditambahkan
if (!empty($image_paths)) {
    foreach ($image_paths as $image_path) {
        // Memeriksa apakah nama file gambar sudah ada dalam database
        $sql_check_image = "SELECT COUNT(*) AS count FROM image_products WHERE product_id='$id_produk' AND image_path='$image_path'";
        $result_check_image = $konek->query($sql_check_image);
        $row = $result_check_image->fetch_assoc();
        if ($row['count'] == 0) {
            // Jika nama file gambar belum ada, maka tambahkan ke database
            $sql_insert_image = "INSERT INTO image_products (product_id, image_path) VALUES ('$id_produk', '$image_path')";
            if ($konek->query($sql_insert_image) !== TRUE) {
                $response['error'] = "Error: " . $sql_insert_image . "<br>" . $konek->error;
            } else {
                $response['message'] = "Data gambar berhasil ditambahkan.";
            }
        } else {
            $response['message'] = "Nama file gambar '$image_path' sudah ada dalam database.";
        }
    }
} else {
    $response['error'] = "Tidak ada nama file gambar yang ditambahkan.";
}

// Mengirimkan response dalam format JSON
header('Content-Type: application/json');
echo json_encode($response);

// Menutup koneksi database
mysqli_close($konek);
?>
