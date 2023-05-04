class CharactersModel {
  int? id;
  String? firstName;
  String? lastName;
  String? fullName;
  String? title;
  String? family;
  String? image;
  String? imageUrl;

  CharactersModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.fullName,
      this.title,
      this.family,
      this.image,
      this.imageUrl});

  static List<CharactersModel> fromData(List<Map<String,dynamic>> data){
    return data.map((character) => CharactersModel.fromJson(character)).toList();
  }

  CharactersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    title = json['title'];
    family = json['family'];
    image = json['image'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['fullName'] = this.fullName;
    data['title'] = this.title;
    data['family'] = this.family;
    data['image'] = this.image;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}