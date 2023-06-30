// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/core/utils/helper_methods.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:news_app/core/components.dart';
import 'package:news_app/core/repo/hive_helper.dart';
import 'package:news_app/features/presentation/views/other_screens/item_detail_screen.dart';

import '../../../../core/models/news_model/hive_bookMark_model.dart';

class ExploreNewsItem extends StatefulWidget {
  const ExploreNewsItem({
    Key? key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.source,
    required this.date,
    required this.content,
    required this.postId,
    required this.likes,
    required this.time,
  }) : super(key: key);

  final String imageUrl;
  final String category;
  final String title;
  final String source;
  final String date;
  final String content;
  final String postId;
  final String time;
  final List<String> likes;

  @override
  State<ExploreNewsItem> createState() => _ExploreNewsItemState();
}

class _ExploreNewsItemState extends State<ExploreNewsItem> {
  List newsList = [];
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  // comment text controller
  final _commentTextController = TextEditingController();
  @override
  void initState() {
    isLiked = widget.likes.contains(currentUser.email);
    super.initState();
  }

  void toggleLike() {
    // setState(() {
    isLiked = !isLiked;
    // });
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('news').doc(widget.postId);
    log(widget.postId.toString());
    if (isLiked) {
      postRef.update({
        'likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        'likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  // add a comment
  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection('news')
        .doc(widget.postId)
        .collection('comments')
        .add({
      'CommentText': commentText,
      'CommentedBy': currentUser.email,
      'CommentTime': Timestamp.now(),
    });
  }

  // show a dialog box for adding comment
  void showCommentDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add Comment"),
              content: TextField(
                controller: _commentTextController,
                decoration:
                    const InputDecoration(hintText: "Write a comment.. "),
              ),
              actions: [
                // save Button
                TextButton(
                  onPressed: () {
                    addComment(_commentTextController.text);
                    Navigator.pop(context);
                    _commentTextController.clear();
                  },
                  child: const Text("Post"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _commentTextController.clear();
                  },
                  child: const Text("Cancel"),
                ),
                // cancel Button
              ],
            ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  List bookMarksList = HiveHelper.bookMarks.values.toList();
  final stopwatch = Stopwatch();
  int index = HiveHelper.bookMarks.length + 1;
  final textController = TextEditingController();
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final postsRef = FirebaseFirestore.instance.collection('news');
  Map likes = {};
  int likeCount = 0;

  void addBookmarkItems(String imageUrl, String category, String title,
      String source, String date, String content) {
    // setState(() {
    HiveHelper.bookMarks.add(HiveBookMarkModel(
      urlToImage: widget.imageUrl,
      source: widget.source,
      title: widget.title,
      publishedAt: widget.date,
      category: widget.category,
      content: (widget.content),
      author: '',
      description: '',
      url: '',
    ));
    // });
    log("added");
  }

  @override
  Widget build(BuildContext context) {
    isLiked = (likes[currentUserId] == true);
    return InkWell(
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
      child: VisibilityDetector(
        key: Key(widget.title.toString()),
        onVisibilityChanged: (info) {
          if (info.visibleFraction == 1 && !stopwatch.isRunning) {
            stopwatch.start();
            log(widget.title, name: 'start');
            print(widget.title);
          }
          if (info.visibleFraction < 0.5 && stopwatch.isRunning) {
            log(widget.title, name: 'reset');
            log("${stopwatch.elapsed}", name: "spent time");
            stopwatch.stop();
          }
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
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
                              InkWell(
                                  onTap: () async {
                                    addBookmarkItems(
                                        widget.imageUrl,
                                        widget.category,
                                        widget.category,
                                        widget.source,
                                        widget.date,
                                        widget.content);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Added Successfully')));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(4)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.bookmark_add_outlined,
                                        size: 24,
                                      ),
                                    ),
                                  )),
                              const SizedBox(
                                height: 5,
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
                                        child: Column(
                                          children: [
                                            LikeButton(
                                              isLiked: isLiked,
                                              onTap: toggleLike,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                                widget.likes.length.toString()),
                                          ],
                                        ))),
                              ),
                              const SizedBox(
                                height: 5,
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
                                        child: Column(
                                          children: [
                                            CommentButton(
                                                onTap: showCommentDialog),
                                          ],
                                        ))),
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
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 16),
                          ),
                          Text(
                            widget.date.substring(0, 11),
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // comment section
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('news')
                            .doc(widget.postId)
                            .collection('comments')
                            .orderBy("CommentTime", descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: snapshot.data!.docs.map((doc) {
                              final commentData =
                                  doc.data() as Map<String, dynamic>;

                              return Comment(
                                text: commentData["CommentText"],
                                user: commentData["CommentedBy"],
                                time: formatDate(commentData["CommentTime"]),
                              );
                            }).toList(),
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
