<?php
// Pastikan request adalah POST request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_FILES['image']) && $_FILES['image']['error'] === UPLOAD_ERR_OK) {
        $target_dir = "images/";

        $target_file = $target_dir . basename($_FILES["image"]["name"]);

        if (move_uploaded_file($_FILES["image"]["tmp_name"], $target_file)) {
            echo json_encode(["message" => "File berhasil diunggah", "file_path" => $target_file]);
        } else {
            echo json_encode(["error" => "Gagal menyimpan file"]);
        }
    } else {
        echo json_encode(["error" => "File tidak ditemukan atau terjadi kesalahan saat mengunggah"]);
    }
} else {
    echo json_encode(["error" => "Metode request harus POST"]);
}
?>
