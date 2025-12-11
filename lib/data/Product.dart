class Product{

  final String? name;
  final String? description;
  final String? foto;

  const Product({

    required this.name,
    required this.description,
    required this.foto
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(

      name: json['name'],
      description: json['description'],
      foto: json['foto_produk'],
    );
  }
}
