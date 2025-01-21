class EventModel {
  String id;
  String title;
  String description;
  int date;
  String category;
  String location;
  bool isDone;
  String userId;

  EventModel(
      {this.id = "",
      required this.category,
      this.location = "",
      required this.title,
      required this.description,
      required this.date,
        required this.userId,
      this.isDone = false});

  EventModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
    userId: json["userId"],
    title: json["title"],
          description: json["description"],
          date: json["date"],
          isDone: json["isDone"],
          category: json["category"],
          location: json["location"],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId":userId,
      "title": title,
      "description": description,
      "date": date,
      "isDone": isDone,
      "location": location,
      "category": category
    };
  }
}
