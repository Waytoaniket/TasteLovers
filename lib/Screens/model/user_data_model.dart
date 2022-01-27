class UserDataModel {
  int id;
  String token;
  String firstName;
  String lastName;
  String email;
  String mobile;
  String profileImageUrl;
  String city;
  UserDataModel({
    this.id = 0,
    this.token = "",
    this.firstName: "",
    this.lastName: "",
    this.email: "",
    this.mobile: "",
    this.profileImageUrl: "",
    this.city: "",
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['profileImageUrl'] = this.profileImageUrl;
    data['city'] = this.city;

    return data;
  }
}
