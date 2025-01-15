import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/event_model.dart';

class FirebaseManager {

  static CollectionReference <EventModel> getTasksCollection() {
    return FirebaseFirestore.instance.collection("Tasks").withConverter<EventModel>(
        fromFirestore: (snapshot, _) {
      return EventModel.fromJson(snapshot.data()!);
    }, toFirestore: (value, _) {
      return value.toJson();
    });
  }

  static Future<void> addEvent(EventModel model) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    model.id = docRef.id;
    return docRef.set(model);
  }

  static Stream<QuerySnapshot<EventModel>> getEvent() {
    var collection = getTasksCollection();
    return collection.orderBy("date").snapshots();
  }
}
