part of 'base_api_client.dart';

class ApiClient extends BaseApiClient {
  ApiClient._();
  static final ApiClient _instance = ApiClient._();
  factory ApiClient({Alice? alice}) {
    if (alice != null) {
      _instance._dio.interceptors.add(alice.getDioInterceptor());
    }

    // Set default configs
    _instance._dio.options.baseUrl = EnvConfig.baseUrl;

    return _instance;
  }

  final Dio _dio = Dio();

  @override
  Future<Response> get(
    String url, {
    String? token,
    responseType = ResponseType.json,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    int msTimeout = 10000,
  }) async {
    Map<String, dynamic> headers = <String, dynamic>{};

    headers.forEach((k, v) => headers[k] = v);

    if (token != null) headers['Authorization'] = 'Bearer $token';

    final durationInMsTimeout = Duration(milliseconds: msTimeout);
    _dio.options.connectTimeout = durationInMsTimeout;
    _dio.options.receiveTimeout = durationInMsTimeout;

    try {
      final response = await _dio.get(
        url,
        options: Options(headers: headers, responseType: responseType),
        queryParameters: queryParams,
      );

      return _returnResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw TimeoutException(e.error);
      } else if (e.type == DioExceptionType.unknown) {
        throw FetchDataException(e.error);
      } else if (e.type == DioExceptionType.badResponse) {
        return _returnResponse(e.response);
      } else {
        throw FetchDataException(e.error);
      }
    }
  }

  @override
  Future<Response> patch(
    String url, {
    String? token,
    dynamic data,
    Map? headers,
    Map<String, dynamic>? queryParams,
    String contentType = 'application/json',
    int msTimeout = 10000,
  }) async {
    Map<String, dynamic> headers = <String, dynamic>{};

    headers.forEach((k, v) => headers[k] = v);

    if (token != null) headers['Authorization'] = 'Bearer $token';

    headers['Content-Type'] = contentType;

    final durationInMsTimeout = Duration(milliseconds: msTimeout);
    _dio.options.connectTimeout = durationInMsTimeout;
    _dio.options.receiveTimeout = durationInMsTimeout;

    try {
      final response = await _dio.patch(
        url,
        data: data,
        options: Options(headers: headers),
        queryParameters: queryParams,
      );

      return _returnResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw TimeoutException(e.error);
      } else if (e.type == DioExceptionType.unknown) {
        throw FetchDataException(e.error);
      } else if (e.type == DioExceptionType.badResponse) {
        return _returnResponse(e.response);
      } else {
        throw FetchDataException(e.error);
      }
    }
  }

  @override
  Future<Response> post(
    String url, {
    dynamic data,
    String? token,
    Map? headers,
    Map<String, dynamic>? queryParams,
    String contentType = 'application/json',
    int msTimeout = 10000,
  }) async {
    Map<String, dynamic> headers = <String, dynamic>{};

    headers.forEach((k, v) => headers[k] = v);

    if (token != null) headers['Authorization'] = 'Bearer $token';

    headers['Content-Type'] = contentType;

    final durationInMsTimeout = Duration(milliseconds: msTimeout);
    _dio.options.connectTimeout = durationInMsTimeout;
    _dio.options.receiveTimeout = durationInMsTimeout;

    try {
      final response = await _dio.post(
        url,
        data: data,
        options: Options(headers: headers),
        queryParameters: queryParams,
      );

      return _returnResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw TimeoutException(e.error);
      } else if (e.type == DioExceptionType.unknown) {
        throw FetchDataException(e.error);
      } else if (e.type == DioExceptionType.badResponse) {
        return _returnResponse(e.response);
      } else {
        throw FetchDataException(e.error);
      }
    }
  }

  @override
  Future<Response> delete(
    String url, {
    dynamic data,
    String? token,
    Map? headers,
    Map<String, dynamic>? queryParams,
    String contentType = 'application/json',
    int msTimeout = 10000,
  }) async {
    Map<String, dynamic> headers = <String, dynamic>{};

    headers.forEach((k, v) => headers[k] = v);

    if (token != null) headers['Authorization'] = 'Bearer $token';

    headers['Content-Type'] = contentType;

    final durationInMsTimeout = Duration(milliseconds: msTimeout);
    _dio.options.connectTimeout = durationInMsTimeout;
    _dio.options.receiveTimeout = durationInMsTimeout;

    try {
      final response = await _dio.delete(
        url,
        data: data,
        options: Options(headers: headers),
        queryParameters: queryParams,
      );

      return _returnResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw TimeoutException(e.error);
      } else if (e.type == DioExceptionType.unknown) {
        throw FetchDataException(e.error);
      } else if (e.type == DioExceptionType.badResponse) {
        return _returnResponse(e.response);
      } else {
        throw FetchDataException(e.error);
      }
    }
  }

  @override
  Future<Response> put(
    String url, {
    dynamic data,
    String? token,
    Map? headers,
    Map<String, dynamic>? queryParams,
    String contentType = 'application/json',
    int msTimeout = 10000,
  }) async {
    Map<String, dynamic> headers = <String, dynamic>{};

    headers.forEach((k, v) => headers[k] = v);

    if (token != null) headers['Authorization'] = 'Bearer $token';

    headers['Content-Type'] = contentType;

    final durationInMsTimeout = Duration(milliseconds: msTimeout);
    _dio.options.connectTimeout = durationInMsTimeout;
    _dio.options.receiveTimeout = durationInMsTimeout;

    try {
      final response = await _dio.put(
        url,
        data: data,
        options: Options(headers: headers),
        queryParameters: queryParams,
      );

      return _returnResponse(response);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw TimeoutException(e.error);
      } else if (e.type == DioExceptionType.unknown) {
        throw FetchDataException(e.error);
      } else if (e.type == DioExceptionType.badResponse) {
        return _returnResponse(e.response);
      } else {
        throw FetchDataException(e.error);
      }
    }
  }
}

_returnResponse(Response? response) {
  if (response == null) throw FetchDataException(response?.data['error']);

  switch (response.statusCode) {
    case 200:
      return response;
    case 201:
      return response;
    case 204:
      return response;
    case 400:
      throw BadRequestException(response.data['error']);
    case 401:
      throw UnauthorizedException(response.data['error']);
    case 403:
      throw ForbiddenException(response.data['error']);
    case 404:
      throw NotFoundException(response.data['error']);
    case 500:
      throw InternalServerErrorException(response.data['error']);
    case 503:
      throw ServiceUnavailableException(response.data['error']);
    case 504:
      throw TimeoutException(response.data['error']);
    default:
      throw FetchDataException(response.data['error']);
  }
}
