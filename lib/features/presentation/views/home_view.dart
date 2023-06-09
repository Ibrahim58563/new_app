import 'package:flutter/material.dart';
import 'package:news_app/features/presentation/views/widgets/main_navigation_bar.dart';

// api key bdcd432edce64b73b050a35f7def53cf
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      // top: false,
      child: Scaffold(
        body: MainNavigationBar(),
      ),
    );
  }
}
