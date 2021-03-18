import 'package:dscistanbulapi/models/album.dart';
import 'package:dscistanbulapi/services.dart';
import 'package:flutter/material.dart';

class AlbumScreen extends StatefulWidget {
  AlbumScreen({Key key}) : super(key: key);

  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fotoğraf Albümü'),
      ),
      body: FutureBuilder<List<Album>>(
        future: getAlbum(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 3),
                    width: double.infinity,
                    height: 180,
                    child: Image.network(
                      snapshot.data[index].url,
                      fit: BoxFit.cover,
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
