<?php
require('Koneksi.php');

header("Content-Type: application/json");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];

    $email = mysqli_real_escape_string($konek, $email);

    $sql = "SELECT * FROM users WHERE email = '$email' LIMIT 1";
    $result = $konek->query($sql);
    $response = [];

    if ($result->num_rows == 1) {
        $user = $result->fetch_assoc();
        $hashedPasswordFromDatabase = $user['password'];

        // Memeriksa apakah password yang dimasukkan oleh pengguna cocok dengan hash di database
        if (password_verify($password, $hashedPasswordFromDatabase)) {
            $role_db = $user['role'];
            if ($role_db == 'admin') {
                $response = $user;
            } else {
                $response = [
                    'error' => 'User bukan admin'
                ];
            }
        } else {
            $response = [
                'error' => 'Email atau Password Salah'
            ];
        }
    } else {
        $response = [
            'error' => 'User tidak ditemukan'
        ];
    }
} else {
    $response = [
        'error' => 'Metode tidak valid'
    ];
}

echo json_encode($response);
mysqli_close($konek);
