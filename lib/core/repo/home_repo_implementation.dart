import 'package:dio/dio.dart';
import 'package:news_app/core/repo/failure.dart';
import 'package:news_app/core/models/news_model/news_model.dart';
import 'package:dartz/dartz.dart';
import 'package:news_app/core/repo/home_repo.dart';
import 'package:news_app/core/utils/api_service.dart';

List<String> categoryParameterList = [];

class HomeRepoImplementation extends HomeRepo {
  final ApiService apiService;

  HomeRepoImplementation(this.apiService);
  @override
  Future<Either<Failure, List<NewsModel>>> fetchBreakingNews() async {
    try {
      List<NewsModel> news = [];
      for (int i = 0; i < categoryParameterList.length; i++) {
        var data = await apiService.get(
          endPoint:
              '/v2/top-headlines?country=us&category=${categoryParameterList[i]}&apiKey=45e8aa2e58b4452b9141bdef4f0364ef',
        );
        print("${categoryParameterList[i]} added successfully");
        for (var item in data['articles']) {
          if (NewsModel.fromJson(item).urlToImage != null) {
            news.add(NewsModel.fromJson(item));
          }
          news.last.category = categoryParameterList[i];
        }
        print(data['articles'].length);
      }
      news.shuffle();
      return right(news);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure('errMessage'));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NewsModel>>> fetchRecommendationNews() async {
    try {
      List<NewsModel> news = [];
      for (int i = 0; i < categoryParameterList.length; i++) {
        var data = await apiService.get(
          endPoint:
              '/v2/top-headlines?country=us&category=${categoryParameterList[i]}&apiKey=bdcd432edce64b73b050a35f7def53cf',
        );
        print("${categoryParameterList[i]} added successfully");
        for (var item in data['articles']) {
          if (NewsModel.fromJson(item).urlToImage != null) {
            news.add(NewsModel.fromJson(item));
          }
          news.last.category = categoryParameterList[i];
        }
        print(data['articles'].length);
      }
      news.shuffle();
      return right(news);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure('errMessage'));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
