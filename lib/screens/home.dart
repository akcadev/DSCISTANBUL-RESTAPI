import 'package:dscistanbulapi/models/posts.dart';
import 'package:dscistanbulapi/screens/albumscreen.dart';
import 'package:dscistanbulapi/screens/detailscreen.dart';
import 'package:dscistanbulapi/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomeScreen object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('DSC ISTANBUL API '),
      ),
      body: Stack(fit: StackFit.expand, children: [
        FutureBuilder<List<Posts>>(
          future: getPosts(),
          builder: (context, snapshot) {
            if (ConnectionState.waiting == snapshot.connectionState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data == null) {
              return Center(
                child: Text('Hata Mevcut'),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    // ignore: deprecated_member_use
                    return FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => DetailScreen(
                                  postId: snapshot.data[index].id,
                                )));
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          snapshot.data[index].title.toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        decoration: BoxDecoration(color: Colors.yellow),
                      ),
                    );
                  });
            }
          },
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AlbumScreen()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.photo),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
