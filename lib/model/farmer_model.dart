class FarmerModel {
  String? traderUid;
  String? userName;
  String? firstName;
  String? secondName;
  String? mobileNumber;
  String? cnic;
  String? password;

  FarmerModel(
      {this.traderUid,
      this.userName,
      this.firstName,
      this.secondName,
      this.mobileNumber,
      this.cnic,
      this.password});

  // receiving data from server
  factory FarmerModel.fromMap(map) {
    return FarmerModel(
        traderUid: map['traderUid'],
        userName: map['userName'],
        firstName: map['firstName'],
        secondName: map['secondName'],
        mobileNumber: map['mobileNumber'],
        cnic: map['cnic'],
        password: map['password']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'traderUid': traderUid,
      'userName': userName,
      'firstName': firstName,
      'secondName': secondName,
      'mobileNumber': mobileNumber,
      'cnic': cnic,
      'password': password
    };
  }
}
