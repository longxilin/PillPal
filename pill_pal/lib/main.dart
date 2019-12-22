import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class Drug {
  String name;
  double quantity;
  double remain;
  double indicatorValue;
  String content;
  Drug(
      {this.name,
      this.quantity,
      this.remain,
      this.indicatorValue,
      this.content});
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'PillPal',
      theme: new ThemeData(fontFamily: 'Montserrat'),
      home: new ListPage(title: 'PILLPAL'),
    );
  }
}

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List drug;

  @override
  void initState() {
    drug = getDrug();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Drug drug) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          child: Icon(Icons.star_border, color: Colors.black),
        ),
        title: Text(
          drug.name .toUpperCase(),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                  // tag: 'hero',
                  height: 12.0,
                  child: LinearProgressIndicator(
                    backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                    value: drug.indicatorValue,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
                  )),
            ),
          ],
        ),
        trailing: Text(drug.remain.toString(),
            style: TextStyle(
              color: Colors.black,
            )));

    Card makeCard(Drug drug) => Card(
          elevation: 0.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: new BoxDecoration(
                border: new Border(
                    bottom:
                        new BorderSide(width: 2.0, color: Color(0xFFF4F4F4)))),
            child: makeListTile(drug),
          ),
        );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: drug.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(drug[index]);
        },
      ),
    );

    final makeBottom = Container(
      child: BottomAppBar(
        color: Color.fromRGBO(255, 255, 255, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 40,
                  icon: Icon(Icons.view_module, color: Colors.grey),
                  onPressed: () {},
                ),
                Container(
                  margin: const EdgeInsets.only(top: 0),
                  child: Text(
                    'GRID VIEW',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.only(top: 10),
                child: IconButton(
                  iconSize: 55,
                  icon: Icon(Icons.add_circle, color: const Color(0xff27BCF4)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => addMed()),
                    );
                  },
                )),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 40,
                  icon: Icon(Icons.person, color: Colors.grey),
                  onPressed: () {},
                ),
                Container(
                  margin: const EdgeInsets.only(top: 0),
                  child: Text(
                    'ABOUT',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Colors.white,
      title: Text(
        widget.title,
        style: TextStyle(color: const Color(0xff27BCF4)),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list, color: const Color(0xff27BCF4)),
          onPressed: () {},
        )
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: topAppBar,
      body: makeBody,
      bottomNavigationBar: makeBottom,
    );
  }
}

class addMed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final makeBody = Stack(
      children:[
        Align(
            alignment: Alignment.topRight,
            child:
              Padding(
                padding: EdgeInsets.only(top:40.0, right: 20.0),
                child: IconButton (
                  iconSize: 25,
                  icon: Icon(Icons.clear, color: const Color(0xFFFFFFFF)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
        ),
        Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(25.0),
                child: Text(
                  'ADD A NEW\nMEDICATION',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 250,
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white)),
                    color: Colors.white,
                    textColor: Colors.black,
                    onPressed: () {},
                    child: Text(
                      'BY CAMERA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 250,
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white)),
                  color: Colors.white,
                  textColor: Colors.black,
                  onPressed: () {},
                  child: Text(
                    'BY MANUAL INPUT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Color(0xff27BCF4),
      body: makeBody,
    );
  }
}

List getDrug() {
  return [
    Drug(
        name: "Drug 1",
        quantity: 20,
        remain: 10,
        indicatorValue: 10 / 20,
        content: "Take 1 tab twice a day"),
    Drug(
        name: "Drug 2",
        quantity: 60,
        remain: 45,
        indicatorValue: 45 / 60,
        content: "Take 1 tab twice a day"),
    Drug(
        name: "Drug 3",
        quantity: 90,
        remain: 40,
        indicatorValue: 40 / 90,
        content: "Take 1 tab twice a day")
  ];
}
