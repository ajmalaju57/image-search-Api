import 'dart:convert';
import 'package:apinew/model/Api_model.dart';
import 'package:apinew/view/view_photo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<BigData?> getData() async {
    final url =
        "https://pixabay.com/api/?key=31246689-11decf962a63e23e7a30694ed&q=${search.text}&image_type=photo&pretty=true";
    var response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return BigData.fromJson(jsonDecode(response.body));
    }
  }
  var search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFF000633),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body:
      SingleChildScrollView(
        child: Container(
          child: Column(
            children:[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children:[
                    Expanded(
                        child: TextField(
                          controller: search,
                          decoration: InputDecoration(
                              hintText: "Search...",
                              border: InputBorder.none),
                        )),
                    InkWell(
                        onTap: () {
                          setState((){

                          });
                        },
                        child: Container(child: Icon(Icons.search)))
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                child: FutureBuilder<BigData?>(
                    future: getData(),
                    builder: (context, AsyncSnapshot<BigData?> snapshote) {
                      if (snapshote.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshote.hasData) {
                        return Text("no data");
                      }
                      return GridView.builder(
                          itemCount: snapshote.data!.hits!.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ViewImage(
                                            image: snapshote.data!
                                                .hits![index].largeImageURL
                                                .toString(),
                                          )));
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  // color: Colors.red,
                                  child: Image.network(snapshote
                                      .data!.hits![index].largeImageURL
                                      .toString()),
                                ),
                              ),
                            );
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
