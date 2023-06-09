import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/presentation/views/other_screens/item_detail_screen.dart';

class ExploreNewsItem extends StatelessWidget {
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
                      imageUrl: imageUrl,
                      source: source,
                      title: title,
                      date: date,
                      category: category,
                      content: (content.substring(0, content.length - 15) * 3),
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
                      imageUrl: imageUrl,
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
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Category"),
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
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(CupertinoIcons.heart),
                                  )),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(4)),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(CupertinoIcons.bookmark),
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
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          source,
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                        Text(
                          date.substring(0, 10),
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
