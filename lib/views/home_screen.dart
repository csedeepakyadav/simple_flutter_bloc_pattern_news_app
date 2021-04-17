import 'package:blocnews/model/news_model.dart';
import 'package:flutter/material.dart';
import '../bloc/news_bloc.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    newsBloc.fetchAllNews(country: "in");
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: height * 0.08),
              child: StreamBuilder<List<ArticleModel>>(
                stream: newsBloc.allNews,
                builder: (context, AsyncSnapshot<List<ArticleModel>> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  newsBloc.lauchNewsUrl(
                                      snapshot.data![index].url.toString());
                                },
                                child: Container(
                                    height: height * 0.3,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 1,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              offset: Offset(0, 0),
                                              spreadRadius: 2),
                                        ]),
                                    margin: EdgeInsets.symmetric(
                                        vertical: height * 0.01,
                                        horizontal: height * 0.01),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: width,
                                          height: height * 0.3,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                  image: NetworkImage(snapshot
                                                      .data![index].urlToImage
                                                      .toString()),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.8),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15),
                                                    )),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.05,
                                                    vertical: height * 0.01),
                                                child: Text(
                                                  snapshot.data![index].title
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      letterSpacing: 1.1,
                                                      height: 1.5,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )))
                                      ],
                                    )),
                              );
                            }));
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Container(
              height: height * 0.07,
              width: width,
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.01),
              child: Text(
                "Bloc News",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    letterSpacing: 1.1,
                    height: 1.5),
              ),
            )
          ],
        ),
      ),
    );
  }
}
