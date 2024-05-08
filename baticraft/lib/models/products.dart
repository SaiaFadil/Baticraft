class Products {
  static List<Products> productList = [];

  final String id;
  final String image;
  final String name;
  final int price;
  int quantity;

  Products({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    this.quantity = 0,
  });
  static void clearData() {
    productList.clear();
  }
 Map<String, dynamic> toMap() {
    return {
      'product_id': id,
      'nama_product': name,
      'jumlah': quantity,
      'harga_total': quantity * price,
    };
  // Metode untuk membersihkan semua data produk
}
}