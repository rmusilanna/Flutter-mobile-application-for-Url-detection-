import 'package:UrlDetection/widgets/TransactionList.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(URLD());
}

class URLD extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      home: urlDml(),
    );
  }
}

class urlDml extends StatefulWidget {
  @override
  _urlDmlState createState() => _urlDmlState();
}

class _urlDmlState extends State<urlDml> {
  final titlecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Url Detection"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Enter Url'),
                    controller: titlecontroller,
                  ),
                  RaisedButton(
                    color: Colors.blue[300],
                    highlightColor: Colors.pink,
                    hoverColor: Colors.red,
                    child: Text('Search'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TransactionListPage(text: titlecontroller.text),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
