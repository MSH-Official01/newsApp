import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news_app/model/news_model.dart';
import 'package:news_app/service/news_api_service.dart';
import 'package:news_app/widget/const.dart';
import 'package:news_app/widget/error_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Articles> newsList = [];

  // @override
  // void didChangeDependencies() async {
  //   newsList = await NewsApiService().fetchNewsData();
  //   setState(() {});
  //   print("ppppppppp${newsList.length}");
  //   super.didChangeDependencies();
  // }

  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
        centerTitle: true,
        title: Text(
          "News App",
          style: myStyle(18, Colors.black, FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "All News",
                style: myStyle(18, Colors.black, FontWeight.w700),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    paginationButton(onTap: () {}, title: "Prev"),
                    Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: MaterialButton(
                                color: index + 1 == currentIndex
                                    ? Colors.blue
                                    : Colors.white12,
                                minWidth: 30,
                                onPressed: () {
                                  setState(() {
                                    currentIndex = index + 1;
                                  });
                                },
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text("${index + 1}"),
                              ),
                            );
                          }),
                    ),
                    paginationButton(onTap: () {}, title: "Next"),
                  ],
                ),
              ),
              FutureBuilder<List<Articles>>(
                // future: providerData.getNewsData(
                //     page: currentIndex, sortBy: sortBy),
                future: NewsApiService.fetchNewsData(),
                // page: currentIndex, sortBy: sortBy),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return ErrorScreen();
                  }

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Text("${snapshot.data![index]}");
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton paginationButton({VoidCallback? onTap, String? title}) {
    return ElevatedButton(
        onPressed: onTap,
        child: Text(
          "$title",
          style: myStyle(14, Colors.white),
        ));
  }
}
