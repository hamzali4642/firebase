class EventModel {
  late String id;
  late String title;
  late String image;
  late int date;

  EventModel({
    required this.id,
    required this.title,
    required this.image,
    required this.date,
  });

  EventModel.fromMap(Map<String, dynamic> data){
    id = data["id"];
    title = data["title"];
    image = data["image"];
    date = data["date"];
  }

  Map<String, dynamic> toMap(){
    return {
      "id" : id,
      "title" : title,
      "image" : image,
      "date" : date,
    };
  }
}
