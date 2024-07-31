import 'package:dio/dio.dart';

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString(){
    return 'Requisição inválida';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString(){
    return 'Erro desconhecido ocorreu, por favor tente mais tarde.';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString(){
    return 'Ocorreu um conflinto';
  }
}

class UnprocessableEntity extends DioException {
  UnprocessableEntity(RequestOptions r, Response? response) : super(requestOptions: r, response: response);

  @override
  String toString(){
    if(response != null){
      return response!.data['errors'].first['message'];
    }

    return 'Falha de validação';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString(){
    return 'Acesso negado';
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString(){
    return 'A informação da requisição não foi encontrada';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString(){
    return 'Sem conexão com internet detectada, por favor tente novamente';
  }
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString(){
    return 'A conexão caiu, por favor tente mais tarde';
  }
}