class PostModel {
  String? name;
  String? image;
  late String uid;
  late String id;
  late String text;

  PostModel({
    required this.name,
    required this.image,
    required this.uid,
    required this.id,
    required this.text,
  });

  PostModel.fromMap(Map<String, dynamic> data){
    name = data["name"];
    image = data["image"];
    uid = data["uid"];
    id = data["id"];
    text = data["text"];
  }

  Map<String, dynamic> toMap(){
    return {
      "name" : name,
      "image" : image,
      "uid" : uid,
      "id" : id,
      "text" : text,
    };
  }
}
