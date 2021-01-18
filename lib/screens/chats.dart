import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personaltoolbag/screens/conversations.dart';

class Chats extends StatefulWidget {
  
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {

  //set user
  final String userId="3o7xFL9mVGMPUUXeUKpYnqG017E2";
  //final String userId="RVtz1UMIDWaXL2N8lXw3NBdBHgT2";
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('conversations').where("members",arrayContains: userId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //if there is any error
          if (snapshot.hasError) {
            return Text("Error : ${snapshot.hasError}");
          }
          //if data not received yet
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("loading...");
          }

          return ListView(
            children: snapshot.data.docs
                .map((e) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQms2l_f6svIdZrLP4bzx_nr9sqBt_HDfT2KQ&usqp=CAU"),
                      ),
                      title: Text("serdar"),
                      subtitle: Text(e["displayMessage"]),
                      trailing: Column(
                        children: [
                          Text("12:27"),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green),
                            child: Center(
                              child: Text("3",
                              textScaleFactor: 0.8,
                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white ),),
                            ),
                          )
                        ],
                      ),


                      onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (content)=>Conversations(userId: userId,conversationId: e.id)));

                      } ,
                    ))
                .toList(),
          );
        });
  }
}
