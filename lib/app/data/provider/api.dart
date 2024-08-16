import 'dart:convert';

import 'package:app_painel_hortifruti_pratico/app/core/errors/exception_handlers.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/address.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/category.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/category_request.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/city.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/order.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/order_request.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/product.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/product_request.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/store.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/user.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/user_address_request.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/user_login_request.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/user_login_response.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/user_profile_request.dart';
import 'package:app_painel_hortifruti_pratico/app/data/services/storage/service.dart';
import 'package:dio/dio.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class Api extends GetxService {

  //final _storageService = Get.find<StorageService>();
  //final _baseUrl = 'https://dev.hortifruti.174.138.42.25.getmoss.site/';
  final _baseUrl = 'http://192.168.137.1:3333/';
  //final _baseUrl = 'http://10.101.2.71:3333/';
  //final _baseUrl = 'http://10.101.10.4:3333/';
  //final _baseUrl = 'http://127.0.0.1:3333/';
  late Dio _dio;

  @override
  void onInit() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      receiveTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ));

    // Adiciona o interceptor
    _dio.interceptors.add(AppInterceptors(_dio));

    super.onInit();
  }

  Future<List<CityModel>> getCities() async {
    var response = await _dio.get('cidades');

    List<CityModel> data = [];
    for(var city in response.data){
      data.add(CityModel.fromJson(city));
    }

    return data;
  }

  Future<UserLoginResponseModel> login(UserLoginRequestModel data) async {
    var response = await _dio.post('login', data: jsonEncode(data));

    return UserLoginResponseModel.fromJson(response.data);
  }

  Future<UserModel> register(UserProfileRequestModel data) async {
    var response = await _dio.post('cliente/cadastro', data: jsonEncode(data));

    return UserModel.fromJson(response.data);
  }

  Future<UserModel> getUser() async {
    var response = await _dio.get('auth/me');

    return UserModel.fromJson(response.data);
  }

  Future<UserModel> putUser(UserProfileRequestModel data) async{
    var response = await _dio.put('cliente', data: jsonEncode(data));

    return UserModel.fromJson(response.data);
  }

  Future<List<AddressModel>> getUserAddresses() async {
    var response = await _dio.get('enderecos');

    List<AddressModel> data = [];
    for (var address in response.data) {
      data.add(AddressModel.fromJson(address));
    }

    return data;
  }

  Future<void> postAddress(UserAddressRequestModel data) async {
    await _dio.post('enderecos', data: jsonEncode(data));
  }

  Future<void> putAddress(UserAddressRequestModel data) async {
    await _dio.put('enderecos/${data.id}', data: jsonEncode(data));
  }

  Future<void> deleteAddress(int id) async {
    await _dio.delete('enderecos/$id');
  }

  Future<List<StoreModel>> getStores(int cityId) async {
    var response = await _dio.get('cidades/$cityId/estabelecimentos');

    List<StoreModel> data = [];
    for (var store in response.data) {
      data.add(StoreModel.fromJson(store));
    }

    return data;
  }

  Future<StoreModel> getStore(int id) async {
    var response = await _dio.get('estabelecimentos/$id');

    return StoreModel.fromJson(response.data);
  }

  // PEDIDOS
  Future postOrder(OrderRequestModel data) async {
    await _dio.post('pedidos', data: jsonEncode(data));
  }

  Future<List<CategoryModel>> getCategories() async {
    var response = await _dio.get('estabelecimento/categorias');

    List<CategoryModel> data = [];
    for (var order in response.data) {
      data.add(CategoryModel.fromJson(order));
    }

    return data;
  }

  //Categorias
  Future<CategoryModel> postCategory(CategoryRequestModel data) async {
    var response = await _dio.post('estabelecimento/categorias', data: jsonEncode(data));
    return CategoryModel.fromJson(response.data);
  }

  //Produtos
  Future<ProductModel> postProduct(ProductRequestModel data) async {
    var formData = FormData.fromMap(data.toJson());
    var image = data.image;

    print(data.toJson());

    if(image != null){
      formData.files.add(
        MapEntry('imagem', MultipartFile.fromBytes(image.bytes!, filename: image.name))
      );
    }

    var response = await _dio.post('estabelecimento/produtos', data: formData);

    print(response.data);

    return ProductModel.fromJson(response.data);
  }

  Future<List<ProductModel>> getProducts(int categoryId) async {
    var response = await _dio.get('estabelecimento/produtos?categoria_id=$categoryId');

    List<ProductModel> data = [];
    for (var order in response.data) {
      data.add(ProductModel.fromJson(order));
    }

    return data;
  }

  Future<List<OrderModel>> getOrders() async {
    var response = await _dio.get('pedidos');

    List<OrderModel> data = [];
    for (var order in response.data) {
      data.add(OrderModel.fromJson(order));
    }

    return data;
  }

  Future<OrderModel> getOrder(String id) async {
    var response = await _dio.get('pedidos/$id');

    return OrderModel.fromJson(response.data);
  }

  Future<void> postOrderStatus(String id, int statusId) async {
    await _dio.post('pedidos/$id/statuses', data: jsonEncode({'status_id': statusId}));
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;
  final _storageService = Get.find<StorageService>();

  AppInterceptors(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var accessToken = _storageService.token;

    if(accessToken != null){
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException error, ErrorInterceptorHandler handler){
    switch(error.type){
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw DeadlineExceededException(error.requestOptions);
      case DioExceptionType.badResponse:
        switch(error.response?.statusCode){
          case 400:
            throw BadRequestException(error.requestOptions);
          case 401:
            throw UnauthorizedException(error.requestOptions);
          case 404:
            throw NotFoundException(error.requestOptions);
          case 409:
            throw ConflictException(error.requestOptions);
          case 422:
            throw UnprocessableEntity(error.requestOptions, error.response);
          case 500:
            throw InternalServerErrorException(error.requestOptions);
        }
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.badCertificate:
        throw NoInternetConnectionException(error.requestOptions);
      case DioExceptionType.unknown:
      default:
        throw NoInternetConnectionException(error.requestOptions);
    }

    return handler.next(error);
  }

}