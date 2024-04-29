<?php
require('Koneksi.php');

header("Content-Type: application/json");

$sql = "SELECT p.*, MIN(ip.image_path) AS image_path
        FROM products p
        LEFT JOIN image_products ip ON p.id = ip.product_id
        WHERE p.kategori = 'kemeja'
        GROUP BY p.id";

$result = $konek->query($sql);

$response = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        // Memformat data produk dan gambar utama ke dalam array
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
            'image_path' => $row['image_path'] // Menampilkan satu gambar utama
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
