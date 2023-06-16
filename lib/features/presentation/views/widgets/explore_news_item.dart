import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/presentation/views/other_screens/item_detail_screen.dart';

class ExploreNewsItem extends StatefulWidget {
  const ExploreNewsItem({
    super.key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.source,
    required this.date,
    required this.content,
  });

  final String imageUrl;
  final String category;
  final String title;
  final String source;
  final String date;
  final String content;

  @override
  State<ExploreNewsItem> createState() => _ExploreNewsItemState();
}

class _ExploreNewsItemState extends State<ExploreNewsItem> {
  // late Box bookMarks;
  @override
  void initState() {
    // bookMarks.clear();
    super.initState();
    // bookMarks = Hive.box('bookMarks');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // bookMarks.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemDetailScreen(
                      imageUrl: widget.imageUrl,
                      source: widget.source,
                      title: widget.title,
                      date: widget.date,
                      category: widget.category,
                      content: (widget.content),
                    ))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87,
                      blurRadius: 20.0,
                      spreadRadius: -20.0,
                      offset: Offset(0.0, 20.0),
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: widget.imageUrl,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(widget.category),
                              )),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: () async {
                                          // var bookMarks = Hive.box('bookMarks');
                                          // bookMarks.put(
                                          //     'p1',
                                          //     HiveBookMarkModel(
                                          //       urlToImage: widget.imageUrl,
                                          //       source: widget.source,
                                          //       title: widget.title,
                                          //       publishedAt: widget.date,
                                          //       category: widget.category,
                                          //       content: (widget.content),
                                          //       author: '',
                                          //       description: '',
                                          //       url: '',
                                          //     ));
                                          print("item added");
                                        },
                                        child: const Icon(
                                            CupertinoIcons.bookmark)),
                                  )),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.source,
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 16),
                        ),
                        Text(
                          widget.date.substring(0, 11),
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
