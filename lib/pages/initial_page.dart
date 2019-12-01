import 'package:flutter/material.dart';
import 'package:smdp/pages/page_one.dart';

class InitPage extends StatefulWidget {
  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  TextEditingController textCont;

  @override
  void initState() {
    textCont = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SMDP"),
        centerTitle: true,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 8),
                width: MediaQuery.of(context).size.width,
                child: Opacity(
                    opacity: 1, child: Image.asset('src/arkaplan.png'))),
            Container(
              margin: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
                top: MediaQuery.of(context).size.height / 16,
              ),
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: 'Searchbar',
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              controller: textCont,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Image.asset('src/logos/facebook.png',
                            color: Colors.white),
                        width: 35,
                        height: 35,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: Image.asset('src/logos/instagram.png',
                            color: Colors.white),
                        width: 35,
                        height: 35,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage(userName: textCont.text);
                          }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Image.asset('src/logos/twitter.png',
                              color: Colors.white),
                          width: 35,
                          height: 35,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage(userName: textCont.text);
                          }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Image.asset('src/logos/linkedin.png',
                              color: Colors.white),
                          width: 35,
                          height: 35,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text("Zargan Veritabanı Kullanılmaktadır", style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
