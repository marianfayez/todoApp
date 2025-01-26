import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/models/event_model.dart';
import 'package:todo/models/user_model.dart';

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

  static Stream<QuerySnapshot<EventModel>> getEvent(String category) {
    var collection = getTasksCollection();
    if(category=="All"){
      return collection.orderBy("date").where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();
    }else{
      return collection.where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid).where("category",isEqualTo: category).orderBy("date").snapshots();
    }
  }

  static Stream<DocumentSnapshot<EventModel>> getEventId(String id) {
    var collection=getTasksCollection();
    return collection.doc(id).snapshots().map((docSnapshot) {
      return docSnapshot;  // Transform to the correct data type if needed
    });
  }


  static Future<void> deleteEvent(String id) {
    var collection = getTasksCollection();
    return collection.doc(id).delete();
  }

  static Future<void> update(EventModel model) {
    var collection = getTasksCollection();
    return collection.doc(model.id).update(model.toJson());
  }

  static createAccount(String email,String password,String name,Function onSuccess,Function onLoading, Function onError) async{
    try {
      onLoading();
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      onSuccess();
      UserModel model=UserModel(id: credential.user!.uid, name: name, email: email, createAt: DateTime.now().millisecondsSinceEpoch);
      await addUser(model);
      credential.user!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
        print('The account already exists for that email.');
      }
    } catch (e) {
      onError("Something went wrong");
      print(e);
    }
  }

  static Future<void> logIn(String email,String password,Function onSuccess,Function onLoading, Function onError) async{
    try {
      onLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      onSuccess();
    /*  if(credential.user!.emailVerified){
        onSuccess();}
      else{
        onError("Email is not verified");
      }*/
    } on FirebaseAuthException catch (e) {
      onError("Email or password is not valid");
      /*if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }*/
    }
  }

  static CollectionReference <UserModel> getUsersCollection() {
    return FirebaseFirestore.instance.collection("Users").withConverter<UserModel>(
        fromFirestore: (snapshot, _) {
          return UserModel.fromJson(snapshot.data()!);
        }, toFirestore: (value, _) {
      return value.toJson();
    });
  }

  static Future<void> addUser(UserModel model) {
    var collection = getUsersCollection();
    var docRef = collection.doc(model.id);
    return docRef.set(model);
  }

  static Future<UserModel?> getUser(String id)async{
    var collection=getUsersCollection();
    DocumentSnapshot<UserModel> snapshot = await collection.doc(id).get();
    return snapshot.data();
  }
  static Future<void> logOut(){
    return FirebaseAuth.instance.signOut();
  }
}
