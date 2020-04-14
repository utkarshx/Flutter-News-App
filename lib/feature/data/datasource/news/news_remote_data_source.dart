import 'package:dio/dio.dart';
import 'package:flutter_news_app/config/constant_config.dart';
import 'package:flutter_news_app/feature/data/model/topheadlinesnews/top_headlines_news_response_model.dart';
import 'package:meta/meta.dart';

abstract class NewsRemoteDataSource {
  /// Calls the baseUrl:/v2/top-headlines?country=:country&apiKey=:apiKey endpoint
  ///
  /// Throws a [DioError] for all error codes.
  Future<TopHeadlinesNewsResponseModel> getTopHeadlinesNews();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio dio;
  final ConstantConfig constantConfig;

  NewsRemoteDataSourceImpl({
    @required this.dio,
    @required this.constantConfig,
  });

  @override
  Future<TopHeadlinesNewsResponseModel> getTopHeadlinesNews() async {
    var response = await dio.get(
      '/v2/top-headlines',
      queryParameters: {
        'country': 'id',
        'apiKey': constantConfig.apiKeyNewsApi,
      },
    );
    if (response.statusCode == 200) {
      return TopHeadlinesNewsResponseModel.fromJson(response.data);
    } else {
      throw DioError();
    }
  }
}
