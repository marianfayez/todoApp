import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:todo/firebase/firebase_manager.dart';
import 'package:todo/models/user_model.dart';

class UserProvider extends ChangeNotifier{

  UserModel? userModel;
  User? currentUser;

  UserProvider(){
    currentUser=FirebaseAuth.instance.currentUser;
    if(currentUser!=null){
      initUser();
    }
  }
  initUser()async{
    currentUser=FirebaseAuth.instance.currentUser;
    userModel = await FirebaseManager.getUser(currentUser!.uid);
    notifyListeners();
  }
}