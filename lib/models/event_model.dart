class EventModel {
  String id;
  String title;
  String description;
  int date;
  String category;
  String location;
  bool isDone;

  EventModel(
      {this.id = "",
      required this.category,
      this.location = "",
      required this.title,
      required this.description,
      required this.date,
      this.isDone = false});

  EventModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
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
      "title": title,
      "description": description,
      "date": date,
      "isDone": isDone,
      "location": location,
      "category": category
    };
  }
}
