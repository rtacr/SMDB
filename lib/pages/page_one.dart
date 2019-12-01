import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:smdp/data/array1.dart';
import 'package:smdp/data/array2.dart';
import 'package:smdp/data/array3.dart';
import 'package:smdp/pages/score.dart';

class Counter with ChangeNotifier {
  int _wordCount = 0;
  int get wordCount => _wordCount;

  int _erCount = 0;
  int get erCount => _erCount;

  void er_inc() {
    _erCount++;
    notifyListeners();
  }

  void word_inc() {
    _wordCount++;
    notifyListeners();
  }

  void reset() {
    _wordCount = 0;
    _erCount = 0;
    notifyListeners();
  }
}

class HomePage extends StatefulWidget {
  String userName;
  HomePage({this.userName});
  @override
  _HomePageState createState() => _HomePageState();
}

var alfabe = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'ı',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'o',
  'ö',
  'p',
  'r',
  's',
  'ş',
  't',
  'u',
  'ü',
  'v',
  'y',
  'z'
];

bool checkError(String item) {

  if (array1.contains(item)) {
    return true;
  } else if (array2.contains(item)) {
    return true;
  } else if (array3.contains(item)) {
    return true;
  }
  print(item);
  return false;
}

class _HomePageState extends State<HomePage> {
  var loading;
  List platforms = ["twitter", "instagram", "facebook", "linkedin"];
  String SMDPScore;
  TextEditingController handleCont;

  @override
  void initState() {
    loading = false;
    handleCont = TextEditingController(text: widget.userName);
    getData(widget.userName);
    SMDPScore = "";

    super.initState();
  }

  getData(String userHandle) async {
    setState(() {
      loading = true;
    });
    var snapshotList = await Firestore.instance
        .collection('twitter')
        .document('users')
        .collection('users')
        .document(userHandle)
        .collection('tweets')
        .getDocuments();
    Provider.of<Counter>(context).reset();
    for (var document in snapshotList.documents) {
      var temp = document.data['content'].toString();
      temp = temp
          .replaceAll('.', ' ')
          .replaceAll(',', ' ')
          .replaceAll('?', ' ')
          .replaceAll('!', ' ')
          .replaceAll('-', ' ')
          .replaceAll('/', ' ')
          .replaceAll(';', ' ')
          .replaceAll(':', ' ')
          .replaceAll('"', ' ')
          .replaceAll('[', ' ')
          .replaceAll(']', ' ');
      temp = temp.toLowerCase();

      var array = temp.split(' ');

      for (var item in array) {
        item = item.replaceAll(' ', '');
        if (!item.contains('#') &&
            item != '' &&
            !item.contains('@') &&
            alfabe.contains(item[0])) {
          if (!checkError(item)) {
            Provider.of<Counter>(context).er_inc();
          }
        }
    
        Provider.of<Counter>(context).word_inc();
      }
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SMDP"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
        ),
        child: loading
            ? Center(child: Text("Kontrol Ediliyor."))
            : Column(
                children: [
                  Hero(
                    tag: 'Searchbar',
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              controller: handleCont,
                            ),
                          ),
                          SizedBox(width: 16),
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              getData(handleCont.text);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  StreamBuilder(
                      stream: Firestore.instance
                          .collection('twitter')
                          .document('users')
                          .collection('users')
                          .document(handleCont.text)
                          .snapshots(),
                      builder: (context, snap) {
                        if (!snap.hasData) return CircularProgressIndicator();
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height / 5,
                              width: MediaQuery.of(context).size.height / 5,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            snap.data['image_url']))),
                              ),
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(snap.data['full_name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 8),
                                  Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Text(
                                        snap.data['bio'],
                                        style: TextStyle(fontSize: 12.5),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                  SizedBox(height: 12),
                  Container(width: MediaQuery.of(context).size.width, child: ScoreUI()),
                  SizedBox(height: 16),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Theme.of(context).secondaryHeaderColor),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            width: 120,
                            height: 25,
                            child: ListTile(
                              title: CircleAvatar(
                                  backgroundColor: Color(0xFFFF0000)),
                              trailing: Text(
                                "0-50",
                                style: TextStyle(fontSize: 12.5),
                              ),
                            )),
                        Container(
                            width: 120,
                            height: 25,
                            child: ListTile(
                              title:
                                  CircleAvatar(backgroundColor: Colors.orange),
                              trailing: Text(
                                "50-80",
                                style: TextStyle(fontSize: 12.5),
                              ),
                            )),
                        Container(
                            width: 120,
                            height: 25,
                            child: ListTile(
                              title: CircleAvatar(
                                  backgroundColor: Color(0xFF00FF00)),
                              trailing: Text(
                                "80-100",
                                style: TextStyle(fontSize: 12.5),
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Expanded(
                    child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('twitter')
                            .document('users')
                            .collection('users')
                            .document(handleCont.text)
                            .collection('tweets')
                            .snapshots(),
                       builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(
                              child: CircularProgressIndicator(),
                            );

                          return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, i) {
                              return Container(
                                margin: EdgeInsets.only(top: 8),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                child: ListTile(
                                  title: Text(
                                    snapshot.data.documents[i]['content'],
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ),
                ],
              ),
      ),
    );
  }
}
