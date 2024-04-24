<?php
require('Koneksi.php');

header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Melakukan pemeriksaan koneksi
    if ($konek === false) {
        $response = [
            'error' => 'Koneksi database gagal'
        ];
        echo json_encode($response);
        exit;
    }

    // Melakukan pemeriksaan email
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $response = Array();
        echo json_encode($response);
        exit;
    }

    // Menggunakan prepared statement untuk mencegah SQL Injection
    $stmt = $konek->prepare("SELECT * FROM users WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();
    
    // Memeriksa apakah user ditemukan
    if ($result->num_rows == 1) {
        $user = $result->fetch_assoc();
        $hashedPassword = $user['password'];

        // Memeriksa apakah password yang dimasukkan oleh pengguna cocok dengan hash di database
        if (password_verify($password, $hashedPassword)) {
            $role_db = $user['role'];
            if ($role_db == 'admin') {
                $response = $user;
            } else {
                $response = Array();
            }
        } else {
            $response = Array();
        }
    } else {
        $response = Array();
    }
    // Menutup statement
    $stmt->close();
} else {
    $response = Array();
}

// Menutup koneksi database
mysqli_close($konek);

// Mengeluarkan respons sebagai JSON
echo json_encode($response);
