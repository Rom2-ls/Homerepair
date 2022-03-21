class UserModel {
  String? email;
  String? firstname;
  String? lastname;
  bool? repair;

  UserModel({this.email, this.firstname, this.lastname, this.repair});

  //get data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      email: map['email'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      repair: map['repair'],
    );
  }

  //send data to server
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'repair': repair,
    };
  }
}
