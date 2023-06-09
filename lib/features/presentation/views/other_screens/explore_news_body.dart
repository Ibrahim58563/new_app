import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/presentation/views/widgets/explore_news_item.dart';

import '../../manager/every_news/every_news_cubit.dart';
import '../widgets/custom_error_widget.dart';
import '../widgets/custom_loading_indicator.dart';

class ExploreNewsBody extends StatelessWidget {
  const ExploreNewsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Explore News",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
            ),
            Expanded(
              child: BlocBuilder<EveryNewCubit, EveryNewState>(
                builder: (context, state) {
                  if (state is EveryNewSuccess) {
                    return ListView.builder(
                        itemCount: state.news.length,
                        itemBuilder: (context, index) {
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
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ExploreNewsItem(
                                imageUrl: '${state.news[index].urlToImage}',
                                source: '${state.news[index].source!.name}',
                                date: ' ${state.news[index].publishedAt!}',
                                category: '${state.news[index].category}',
                                title: '${state.news[index].title}',
                                content: '${state.news[index].content}',
                              ),
                            ),
                          );
                        });
                  } else if (state is EveryNewFailure) {
                    print("error here");
                    return CustomErrorWidget(errMessage: state.failure);
                  } else {
                    return const CustomLoadingIndicator();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
