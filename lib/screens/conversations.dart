import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Conversations extends StatefulWidget {
  final String userId;
  final String conversationId;
  const Conversations({Key key, this.userId, this.conversationId})
      : super(key: key);

  @override
  _ConversationsState createState() => _ConversationsState();
}

class _ConversationsState extends State<Conversations> {
  CollectionReference _ref;
  final TextEditingController _editingController = TextEditingController();
  @override
  void initState() {
    _ref = FirebaseFirestore.instance
        .collection("conversations/${widget.conversationId}/messages");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: -6,
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQms2l_f6svIdZrLP4bzx_nr9sqBt_HDfT2KQ&usqp=CAU"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("serdarrrrr"),
              ),
            ],
          )),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://lumiere-a.akamaihd.net/v1/images/sa_pixar_virtualbg_coco_16x9_9ccd7110.jpeg?region=0,0,1920,1080"))),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: _ref.orderBy("timeStamp").snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return !snapshot.hasData
                        ? CircularProgressIndicator()
                        : ListView(
                            children: snapshot.data.docs
                                .map(
                                  (document) => ListTile(
                                    title: Align(
                                        alignment: widget.userId !=
                                                document["senderid"]
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight,
                                        child: Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Text(
                                              document["message"],
                                            ))),
                                  ),
                                )
                                .toList(),
                          );
                  }),
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    controller: _editingController,
                    decoration: InputDecoration(
                        hintText: "type a message", border: InputBorder.none),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor),
                  child: IconButton(
                      icon: Icon(Icons.send, color: Colors.white),
                      onPressed: () async {
                        await _ref.add({
                          "senderid": widget.userId,
                          "message": _editingController.text,
                          "timeStamp": DateTime.now()
                        });
                        _editingController.text = "";
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
