import 'package:crudnew/provider/mainprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Second extends StatelessWidget {
  String from;
  String oldid;
   Second({super.key,required this .from,required this.oldid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(width: 500,
            child: Consumer<MainProvider>(
              builder: (context,value,child) {
                return TextFormField(
                  controller: value.nameController,
                  decoration: InputDecoration(hintText: "User Name:",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                );
              }
            ),
            color: Colors.white,
          ),
          SizedBox(height: 15,),
          Container(width: 500,
            child: Consumer<MainProvider>(
              builder: (context,value,child) {
                return TextFormField(
                  controller: value.placeController,
                  decoration: InputDecoration(hintText: "Place:",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                );
              }
            ),
            color: Colors.white,
          ),
          SizedBox(height: 10,),
          Consumer<MainProvider>(
            builder: (context,value,child) {
              return InkWell(
                onTap: () {
                  if(from=="new"){
                     value.addDetails(from,"");
                    
                    }else{
                        value.addDetails(from,oldid);
                    }
                 

                  value.getStudent();
                  Navigator.pop(context);
                },
                child: Container(width: 100,
                        height: 30,
                        child: Center(child: Text("Save")),
                    color: Colors.white,
                  ),
              );
            }
          ),
        ],
      ),

    );
  }
}
