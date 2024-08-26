import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudnew/add_screen.dart';
import 'package:crudnew/models/student_model.dart';
import 'package:crudnew/provider/mainprovider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.teal,
      floatingActionButton:Consumer<MainProvider>(
        builder: (context,value,child) {
          return FloatingActionButton(child: Icon(Icons.add),
          onPressed: () {
            value.clearDetails();
            Navigator.push(context, MaterialPageRoute(builder: (context) => Second(from: "new",oldid: ""),));
            
              },
              );
        }
      ),
      body: SizedBox(
        child: Consumer<MainProvider>(
          builder: (context,value,child) {
            return ListView.builder(
              shrinkWrap: true,

              itemCount: value.studentList.length,

              itemBuilder: ((context, index) {
                var item=value.studentList[index];
              return Padding(
                padding:  EdgeInsets.all(10),
                child: Container(
                  height: 60,
                  width: 150,
                  color: Colors.white,
                  child: ListTile(
                    title: Text(item.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    subtitle: Text(item.place),
                    trailing: SizedBox(width: 80,
                      child: Row(
                        children: [


                          Consumer<MainProvider>(
                            builder: (context,value,child) {
                              return InkWell(onTap: () {
                                value.detailsedit(value.studentList[index].id.toString());
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder:(context) => Second(from: "EDIT",oldid: value.studentList[index].id.toString())));
                              },
                                  child: Icon(Icons.edit,color: const Color.fromARGB(255, 7, 68, 118),));
                    }
                          ),
                          SizedBox(width: 20,),

                          Consumer<MainProvider>(
                            builder: (context,value,child) {
                              
                              return InkWell(onTap: () {
                                value.deleteDetails(item.id);
                              },
                                child: Icon(Icons.delete,color: Colors.red,));
                            }
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            )
            );
          }
        ),
      ));
    
  }
}