import 'package:dio/dio.dart';
import 'package:f_cast/src/domain/repositories/remote/impl/api_key_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(dependsOn: [DioInterceptor])
class DioModule {
  final DioInterceptor _interceptor;

  DioModule(this._interceptor);

  Dio get dio {
    var newDio = Dio();
    newDio.options.baseUrl = "https://listen-api.listennotes.com/api/v2";
    newDio.options.connectTimeout = 5000; //5s
    newDio.options.receiveTimeout = 3000;

    newDio.interceptors.add(_interceptor.wrapper);

    return newDio;
  }
}

@Singleton(dependsOn: [ApiKeyRepository])
class DioInterceptor {
  final ApiKeyRepository apiKeyRepository;

  DioInterceptor(this.apiKeyRepository);

  InterceptorsWrapper get wrapper => InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          var apiKey = await apiKeyRepository.getApiKey();
          options.headers.addAll({"X-ListenAPI-Key": apiKey});
          return options;
        },
      );
}
