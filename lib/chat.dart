import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyChatApp());
}

class MyChatApp extends StatelessWidget {
  const MyChatApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyChatPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyChatPage extends StatefulWidget {
  const MyChatPage({super.key, required this.title});

  final String title;

  @override
  State<MyChatPage> createState() => _MyChatPageState();
}

class ChatMessage {
  String messageContent;
  String messageType;

  ChatMessage({required this.messageContent, required this.messageType});
}

class _MyChatPageState extends State<MyChatPage> {
  int _counter = 0;
  String name = "";

  _MyChatPageState() {
    Timer.periodic(Duration(seconds: 0), (_) {
      view_message();
    });
  }

  List<ChatMessage> messages = [];

  TextEditingController te_message = TextEditingController();

  List<String> from_id_ = <String>[];
  List<String> to_id_ = <String>[];
  List<String> message_ = <String>[];
  List<String> date_ = <String>[];
  List<String> time_ = <String>[];//change

  Future<void> view_message() async {
    final pref = await SharedPreferences.getInstance();
    name = pref.getString("agrname").toString();

    setState(() {
      name = name;
    });

    List<String> from_id = <String>[];
    List<String> to_id = <String>[];
    List<String> message = <String>[];
    List<String> date = <String>[];
    List<String> time = <String>[];//change

    try {
      final pref = await SharedPreferences.getInstance();
      String urls = pref.getString('url').toString();
      String url = '$urls/User_viewchat/';

      var data = await http.post(Uri.parse(url), body: {
        'from_id': pref.getString("lid").toString(),
        'to_id': pref.getString("aid").toString()
      });
      var jsondata = json.decode(data.body);
      String status = jsondata['status'];
      print(status);

      var arr = jsondata["data"];
      print(arr);

      messages.clear();

      for (int i = 0; i < arr.length; i++) {
        from_id.add(arr[i]['from'].toString());
        to_id.add(arr[i]['to'].toString());
        message.add(arr[i]['msg']);
        date.add(arr[i]['date'].toString());
        time.add(arr[i]['date'].toString());//change

        if (pref.getString("lid").toString() == arr[i]['from'].toString()) {
          messages.add(ChatMessage(
              messageContent: arr[i]['msg'], messageType: "sender"));
        } else {
          messages.add(ChatMessage(
              messageContent: arr[i]['msg'], messageType: "receiver"));
        }
      }

      // messages.add(ChatMessage(messageContent: "....", messageType: "sender"));

      setState(() {
        from_id_ = from_id;
        to_id_ = to_id;
        message_ = message;
        date_ = date;
        time_ = time;//change

        messages = messages;
      });

      print(status);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffeef444c),
        elevation: 0,
        leadingWidth: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 20.0,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                splashRadius: 1.0,
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 24.0,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              name,
              style: TextStyle(fontFamily: "Nexa_bold", color: Colors.white),
            ),
            SizedBox(
              width: 40.0,
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 50),
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType == "receiver"
                          ? Colors.black54
                          : Colors.red[400]),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      messages[index].messageContent,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Nexa_light",
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(left: 50, bottom: 15, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white12,
              child: Row(
                children: <Widget>[
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Container(
                  //     height: 30,
                  //     width: 30,
                  //     decoration: BoxDecoration(
                  //       color: Colors.cyan,
                  //       borderRadius: BorderRadius.circular(30),
                  //     ),
                  //     child: Icon(
                  //       Icons.add,
                  //       color: Colors.white,
                  //       size: 20,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 15,
                  // ),
                  Expanded(
                    child: TextField(
                      controller: te_message,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(
                              color: Color(0xffeef444c,),
                            fontFamily: "Nexa_bold",),
                          border: InputBorder.none),
                    ),
                  ),
                  Container(
                      // child: SizedBox(
                      //   width: 15,
                      // ),
                      ),
                  Container(
                    padding: EdgeInsets.only(
                      right: 15,
                    ),
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () async {
                        String fid = "";
                        String toid = "";
                        String message = te_message.text.toString();

                        /////
                        try {
                          final pref = await SharedPreferences.getInstance();
                          String ip = pref.getString("url").toString();

                          String url = ip + "/User_sendchat/";

                          var data = await http.post(Uri.parse(url), body: {
                            'message': message,
                            'from_id': pref.getString("lid").toString(),
                            'to_id': pref.getString("aid").toString()
                          });
                          var jsondata = json.decode(data.body);
                          String status = jsondata['status'];

                          te_message.text = "";

                          var arr = jsondata["data"];

                          setState(() {});

                          print("");
                        } catch (e) {
                          print("Error ------------------- " + e.toString());
                          //there is error during converting file image to base64 encoding.
                        }
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: Color(0xffeef444c),
                      elevation: 100,
                      shape: CircleBorder(),
                      mini: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
