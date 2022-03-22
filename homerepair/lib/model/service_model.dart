class ServiceModel {
  String? idrepair;
  String? namerepair;
  String? name;
  String? price;
  String? description;

  ServiceModel({
    this.idrepair,
    this.namerepair,
    this.name,
    this.price,
    this.description,
  });

  //get data from server
  factory ServiceModel.fromMap(map) {
    return ServiceModel(
      idrepair: map['id_repair'],
      namerepair: map['name_repair'],
      name: map['name'],
      price: map['price'],
      description: map['description'],
    );
  }

  //send data to server
  Map<String, dynamic> toMap() {
    return {
      'id_repair': idrepair,
      'name_repair': namerepair,
      'name': name,
      'price': price,
      'description': description,
    };
  }
}
