const String tblContact="tbl_contact";
const String tblContactColId="id";
const String tblContactColName="name";
const String tblContactColMobile="mobile";
const String tblContactColEmail="email";
const String tblContactColAddress="address";
const String tblContactColDob="dob";
const String tblContactColImage="image";
const String tblContactColFavorite="favorite";

class ContactModel{

  int? id;
  String name;
  String mobile;
  String? email;
  String? streetAddress;
  String? dob;
  String? image;
  bool favorite;

  ContactModel({
    this.id,
    required this.name,
    required this.mobile,
    this.email,
    this.streetAddress,
    this.dob,
    this.image,
    this.favorite=false,
  });

  Map<String,dynamic>toMap(){
    var map=<String,dynamic>{
      tblContactColName:name,
      tblContactColMobile:mobile,
      tblContactColEmail:email,
      tblContactColAddress:streetAddress,
      tblContactColDob:dob,
      tblContactColImage:image,
      tblContactColFavorite: favorite ? 1 : 0,
    };
    if(id!= null){
      map[tblContactColId]=id;
    }
    return map;
  }
  
  factory ContactModel.fromMap(Map<String,dynamic>map)=>
      ContactModel(
          name: map[tblContactColName],
        mobile: map[tblContactColMobile],
        id: map[tblContactColId],
        email: map[tblContactColEmail],
        streetAddress: map[tblContactColAddress],
        image: map[tblContactColImage],
        dob: map[tblContactColDob],
        favorite: map[tblContactColFavorite]==1 ? true:false,
      );


}