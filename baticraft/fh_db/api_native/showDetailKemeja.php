<?php
require('Koneksi.php');

header("Content-Type: application/json");
$id_produk = $_POST['id_produk'];
$sql = "SELECT p.*, GROUP_CONCAT(ip.image_path) AS image_paths
        FROM products p
        LEFT JOIN image_products ip ON p.id = ip.product_id
        WHERE p.kategori = 'kemeja' AND p.id = '$id_produk'
        GROUP BY p.id LIMIT 1";

$result = $konek->query($sql);

$response = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        // Memisahkan path gambar menjadi array
        $image_paths = explode(',', $row['image_paths']);
        
        // Hanya mengambil 5 gambar pertama jika ada
        $image_paths = array_slice($image_paths, 0, 5);

        // Memformat data produk dan gambar ke dalam array
        $product = [
            'id' => $row['id'],
            'kode_product' => $row['kode_product'],
            'nama' => $row['nama'],
            'deskripsi' => $row['deskripsi'],
            'harga' => $row['harga'],
            'kategori' => $row['kategori'],
            'stok' => $row['stok'],
            'ukuran' => $row['ukuran'],
            'bahan' => $row['bahan'],
            'panjang_kain' => $row['panjang_kain'],
            'lebar_kain' => $row['lebar_kain'],
            'jenis_batik' => $row['jenis_batik'],
            'jenis_lengan' => $row['jenis_lengan'],
            'status' => $row['status'],
            'created_at' => $row['created_at'],
            'updated_at' => $row['updated_at'],
            'image_paths' => $image_paths // Mengirimkan array path gambar
        ];
        $response[] = $product;
    }
} else {
    // Jika tidak ada produk dengan kategori "kemeja" ditemukan, kirimkan pesan kesalahan
    $response = [
        'error' => 'Tidak ada produk kategori kemeja yang ditemukan'
    ];
}

echo json_encode($response);

mysqli_close($konek);
