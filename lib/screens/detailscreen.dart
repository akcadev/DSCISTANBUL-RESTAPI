import 'package:dscistanbulapi/models/comments.dart';
import 'package:dscistanbulapi/models/post.dart';
import 'package:flutter/material.dart';

import '../services.dart';

class DetailScreen extends StatefulWidget {
  final postId;

  const DetailScreen({Key key, this.postId}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Detay Sayfası'),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<Post>(
              future: getpost(widget.postId.toString()),
              builder: (context, snapshot) {
                if (ConnectionState.waiting == snapshot.connectionState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            snapshot.data.title.toString(),
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(color: Colors.amber),
                        ),
                        Divider(),
                        Text("İçerik: "),
                        Text(snapshot.data.body),
                        Divider(),
                        Text(
                          'Yorumlar',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FutureBuilder<List<Comments>>(
                            future: getComments(widget.postId.toString()),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 55,
                                                  height: 55,
                                                  alignment: Alignment.center,
                                                  child: Text('resim'),
                                                  decoration: BoxDecoration(
                                                      color: Colors.amber,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      width: 180,
                                                      child: Text(
                                                        'Adı : ${snapshot.data[index].name}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    SizedBox(
                                                      width: 180,
                                                      child: Text(
                                                        'email : ${snapshot.data[index].email}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            Text(snapshot.data[index].body)
                                          ],
                                        ),
                                      );
                                    });
                              }
                            }),
                      ],
                    ),
                  );
                }
              }),
        ));
  }
}
