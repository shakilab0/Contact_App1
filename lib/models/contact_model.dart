class ContactModel{

  int id;
  String name;
  String mobile;
  String? email;
  String? streetAddress;
  String? dob;
  String? image;
  bool? favorite;

  ContactModel({
    this.id=-1,
    required this.name,
    required this.mobile,
    this.email,
    this.streetAddress,
    this.dob,
    this.image,
    this.favorite,
  });

}