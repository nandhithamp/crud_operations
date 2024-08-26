import 'dart:collection';

import 'package:crudnew/models/student_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainProvider extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController placeController = TextEditingController();

MainProvider(){
  getStudent();
}

  void addDetails(String from ,String oldid) {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    HashMap<String, Object> details = HashMap();

    details["Name"] = nameController.text;
    details["Place"] = placeController.text;
    if(from=="new"){
    details["Id"] = id;}

    if(from=="EDIT"){
       db.collection("STUDENT").doc(oldid).set(details);

    }else{
             db.collection("STUDENT").doc(id).set(details);
  }
  notifyListeners();

 }

  List<StudentModel> studentList = [];


  // List<String> student=[];

  void getStudent() {
    db.collection("STUDENT").get().then((value) {
      if (value.docs.isNotEmpty) {
        studentList.clear();
        for (var e in value.docs) {
          Map<dynamic, dynamic> map = e.data();

          studentList.add(StudentModel(e.id,map["Name"].toString(), map["Place"].toString()));
              // student.add(map["Name"].toString());
          notifyListeners();
        }
      }
    });
  }
  void clearDetails(){
    nameController.clear();
    placeController.clear();
    notifyListeners();
  }

  void deleteDetails(String id){
    db.collection("STUDENT").doc(id).delete();
    getStudent();
    notifyListeners();
  }
 
  void detailsedit(String id){
    db.collection("STUDENT").doc(id).get().then((value){
       Map<dynamic, dynamic> map = value.data()as Map;
      if(value.exists){
         nameController.text=map["Name"].toString();
         placeController.text=map["Place"].toString();
         notifyListeners();
      }
    });
    notifyListeners();
  }
}
