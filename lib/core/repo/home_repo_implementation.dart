import 'package:dio/dio.dart';
import 'package:news_app/core/repo/failure.dart';
import 'package:news_app/core/models/news_model/news_model.dart';
import 'package:dartz/dartz.dart';
import 'package:news_app/core/repo/home_repo.dart';
import 'package:news_app/core/utils/api_service.dart';

class HomeRepoImplementation extends HomeRepo {
  final ApiService apiService;

  HomeRepoImplementation(this.apiService);
  @override
  Future<Either<Failure, List<NewsModel>>> fetchBreakingNews() async {
    try {
      var data = await apiService.get(
        endPoint: '/v2/latest_headlines?countries=US&topic=business',
      );
      List<NewsModel> news = [];
      for (var item in data['articles']) {
        if (NewsModel.fromJson(item).urlToImage != null) {
          news.add(NewsModel.fromJson(item));
        }
      }
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
      var data = await apiService.get(
        endPoint: '/v2/latest_headlines?countries=US&topic=business',
      );
      List<NewsModel> news = [];
      for (var item in data['articles']) {
        if (NewsModel.fromJson(item).urlToImage != null) {
          news.add(NewsModel.fromJson(item));
        }
      }
      return right(news);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure('errMessage'));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
