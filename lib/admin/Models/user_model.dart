class UserModel {
  String? email;
  String? userName;
  String? password;
  String? fatherName;
  String? motherName;
  String? bloodType;
  String? phoneNumber;
  String? birthDate;
  String? NationalID;
  String? id;

  UserModel({
    this.email,
    this.userName,
    this.password,
    this.fatherName,
    this.motherName,
    this.bloodType,
    this.phoneNumber,
    this.birthDate,
    this.NationalID,
    this.id,
  });
  UserModel.fromJson({required Map<String, dynamic> data}) {
    userName = data['userName'];
    email = data['email'];
    phoneNumber = data['phoneNumber'];
    bloodType = data['bloodType'];
    birthDate = data['birthDate'];
    motherName = data['motherName'];
    fatherName = data['fatherName'];
    NationalID = data['NationalID'];
    id = data['_id'];
  }
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'id': id,
      'bloodType': bloodType,
      'birthDate': birthDate,
      'motherName': motherName,
      'fatherName': fatherName,
      'NationalID': NationalID,
    };
  }
}
