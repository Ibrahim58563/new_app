import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/features/presentation/views/widgets/custom_recommendation_item.dart';

class BookMarksScreen extends StatefulWidget {
  const BookMarksScreen({super.key});

  @override
  State<BookMarksScreen> createState() => _BookMarksScreenState();
}

class _BookMarksScreenState extends State<BookMarksScreen> {
  // late Box bookMarks;
  @override
  void initState() {
    // bookMarks.clear();
    super.initState();
    // bookMarks = Hive.box<HiveBookMarkModel>('bookMarks');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // bookMarks.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Marks"),
      ),
      body: Container(
        // child: ValueListenableBuilder(
        //   valueListenable: Hive.box('bookMarks').listenable(),
        //   builder: (context, value, child) {
        //     var bookMarks = Hive.box('bookMarks');
        //     List bookMarksList = List.from(bookMarks.values);
        //     return ListView.builder(
        //       itemCount: bookMarksList.length,
        //       itemBuilder: (context, index) {
        //         // TODO: set the data correctly
        //         return CustomRecommendationItem(
        //           imageUrl: bookMarksList[index].imageUrl,
        //           category: bookMarksList[index].category,
        //           title: bookMarksList[index].title,
        //           source: bookMarksList[index].source,
        //           date: bookMarksList[index].date,
        //           content: bookMarksList[index].content,
        //         );
        //       },
        //     );
        //   },
        // ),
      ),
    );
  }
}
