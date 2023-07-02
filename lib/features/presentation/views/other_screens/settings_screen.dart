import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/info_card.dart';
import 'login_screen.dart';

var email = FirebaseAuth.instance.currentUser!.email;
List<String> categoryList = [
  'business',
  'entertainment',
  'general',
  'science',
  'sports',
  'technology',
  'health',
];

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

final userId = FirebaseAuth.instance.currentUser!.uid;

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<int?>? summary({required String category}) async {
    var summaryDocument = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('modelValues')
        .doc(category)
        .get();
    var summaryField = await summaryDocument.data()?['summary'];
    log('$category summary field $summaryField');
    return summaryField;
  }

  late int summaryValue;
  int? summaryNumber(String category) {
    summary(category: category)?.then((value) {
      setState(() {
        summaryValue = value!;
        log('summary values $summaryValue');
      });
    });
    print('sum val $summaryValue');
    return summaryValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(500),
              //   child: CachedNetworkImage(
              //       height: 150,
              //       width: 150,
              //       fit: BoxFit.cover,
              //       imageUrl:
              //           'https://www.kindpng.com/picc/m/378-3783625_avatar-woman-blank-avatar-icon-female-hd-png.png'),
              // ),
              // Text(
              //   FirebaseAuth.instance.currentUser!.email!
              //           .split('@')[0]
              //           .toString() ??
              //       "Name",
              //   style: const TextStyle(
              //     fontSize: 40.0,
              //     color: Colors.white,
              //     fontWeight: FontWeight.bold,
              //     fontFamily: "Pacifico",
              //   ),
              // ),
              const SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              InfoCard(text: email, icon: Icons.email),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .collection('modelValues')
                      .snapshots(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return InfoCard(
                            text:
                                '${categoryList[index]}: ${snapshot.data!.docs[index]['summary'].toString()}'
                            // '${categoryList[index]}: ${summaryNumber(categoryList[index])}',
                            );
                      },
                    );
                  },
                ),
              ),
              InfoCard(
                text: "Sign Out",
                icon: Icons.logout,
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context, rootNavigator: true).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const LoginView();
                  }));
                },
              ),
              // const Spacer(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
