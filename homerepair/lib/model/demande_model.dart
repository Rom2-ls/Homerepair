class DemandeModel {
  String? uid;
  String? idrepair;
  String? description;
  String? name;
  String? price;
  String? status;

  DemandeModel({
    this.uid,
    this.idrepair,
    this.description,
    this.name,
    this.price,
    this.status,
  });

  //get data from server
  factory DemandeModel.fromMap(map) {
    return DemandeModel(
      uid: map['uid'],
      idrepair: map['idrepair'],
      description: map['description'],
      name: map['name'],
      price: map['price'],
      status: map['status'],
    );
  }

  //send data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'idrepair': idrepair,
      'description': description,
      'name': name,
      'price': price,
      'status': status,
    };
  }
}
