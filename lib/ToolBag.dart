
import 'package:flutter/material.dart';
import 'package:personaltoolbag/screens/calculator.dart';
import 'package:personaltoolbag/screens/chats.dart';
import 'package:personaltoolbag/screens/gallery.dart';

class ToolBag extends StatefulWidget {
  @override
  _ToolBagState createState() => _ToolBagState();
}

class _ToolBagState extends State<ToolBag> with SingleTickerProviderStateMixin {
  TabController _tabcontroller;
  bool _showButton = true;

  void initState() {
    _tabcontroller = TabController(vsync: this, length: 3, initialIndex: 0);
    _tabcontroller.addListener(() {
      _showButton = _tabcontroller.index == 0;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
                child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  floating: true,
                  
                  title: Text("Personal Tool Bag"),
                  actions: [
                      IconButton(icon: Icon(Icons.build), onPressed: null)

                  ],
                )
              ];
            },
            body: Column(
              children: [
              TabBar(
                    controller: _tabcontroller,
                    tabs: <Widget>[
                      Tab(
                        text: "Chats",
                      ),
                      Tab(
                        text: "Gallery",
                      ),
                       Tab(
                        text: "Calculator",
                      ),
                    ],
                  ),
                
                Expanded(
                  child: Container(
                    color:Colors.white,
                    child: TabBarView(
                      
                      controller: _tabcontroller,
                      children: [
                        Chats(),
                        Gallery(),
                        Calculator()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _showButton
          ? FloatingActionButton(
              child: Icon(Icons.message),
              backgroundColor: Colors.purple,
              onPressed: () {},
            )
          : null,
    );
  }
}
