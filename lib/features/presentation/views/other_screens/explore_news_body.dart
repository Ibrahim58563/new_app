// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/every_news/every_news_cubit.dart';
import '../widgets/custom_error_widget.dart';
import '../widgets/custom_loading_indicator.dart';
import '../widgets/explore_news_item.dart';

class ExploreNewsBody extends StatefulWidget {
  const ExploreNewsBody({
    super.key,
  });

  @override
  State<ExploreNewsBody> createState() => _ExploreNewsBodyState();
}

class _ExploreNewsBodyState extends State<ExploreNewsBody> {
  // late Box bookMarks;
  List newsList = [];
  @override
  void initState() {
    // Firestore.getAllNews().then((List list) {
    //   setState(() {
    //     newsList = list;
    //   });
    // });
    super.initState();
    // bookMarks = Hive.box('bookMarks');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // bookMarks.close();
  }

  Future<String> someFutureStringFunction() async {
    return Future.delayed(const Duration(seconds: 1), () => "someText");
  }

  // final stopwatch = Stopwatch();
  DateTime time1 = DateTime.now();
  late DateTime time2;
  List<TimeSpentItem> timeSpent = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Material(
              elevation: 40,
              color: Colors.white,
              surfaceTintColor: Colors.transparent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Image(image: AssetImage('assets/images/news_logo.png'))),
          Expanded(
            child: BlocBuilder<EveryNewCubit, EveryNewState>(
              builder: (context, state) {
                if (state is EveryNewSuccess) {
                  // timeSpent.clear();
                  final commentSnapshot = FirebaseFirestore.instance
                      .collection('news')
                      .doc()
                      .collection('comments')
                      .snapshots();
                  return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('news')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Sth went wrong");
                        } else if (snapshot.hasData) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                              itemCount: state.news.length,
                              itemBuilder: (context, index) {
                                print((snapshot.data!.docs[index].id));
                                final post = snapshot.data?.docs[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: ExploreNewsItem(
                                      imageUrl:
                                          '${state.news[index].urlToImage}',
                                      source:
                                          '${state.news[index].source!.name}',
                                      date:
                                          ' ${state.news[index].publishedAt!}',
                                      category: '${state.news[index].category}',
                                      title: '${state.news[index].title}',
                                      content: '${state.news[index].content}',
                                      postId: (snapshot.data!.docs[index].id),
                                      likes: List<String>.from(
                                          snapshot.data?.docs[index]['likes'] ??
                                              []),
                                      time: ' ',
                                    ),
                                  ),
                                );
                              });
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      });
                } else if (state is EveryNewFailure) {
                  print(state.failure.toString());
                  return CustomErrorWidget(errMessage: state.failure);
                } else {
                  return const CustomLoadingIndicator();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class TimeSpentItem {
  String? id;
  Duration? time;
  TimeSpentItem({
    this.id,
    this.time,
  });
}
