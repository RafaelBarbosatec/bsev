import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

///Classe responsavel por realizar conexões com API
abstract class Con{
  void addInterceptor(InterceptorsWrapper interceptor);
  Future <dynamic> get(String uri, {Map<String,String> headers});
  Future <dynamic> post(String uri,dynamic body, {Map<String,String> headers});
  Future <dynamic> put(String uri,dynamic body, {Map<String,String> headers});
  Future <dynamic> delete(String uri, {Map<String,String> headers});
}

class ConDioImpl implements Con{

  final String urlBase;
  Dio _dio;
  ConDioImpl(this.urlBase){
    _dio = Dio();
    _dio.options.baseUrl = urlBase;
  }

  void addInterceptor(InterceptorsWrapper interceptor){
    _dio.interceptors.add(interceptor);
  }

  /// Método que executa chamada de conexão do tipo GET
  /// @params uri
  /// @params headers (opcional)
  Future <dynamic> get(String uri, {Map<String,String> headers}) async{

      Response response;

      final op = Options(headers: headers);
      response = await _dio.get(uri,options: op);

      return response.data;

  }

  /// Método que executa chamada de conexão do tipo POST
  /// @params uri
  /// @params body
  /// @params headers (opcional)
  Future <dynamic> post(String uri,dynamic body, {Map<String,String> headers}) async{

    Response response;

    final op = Options(headers: headers);
    op.contentType = ContentType.parse("application/x-www-form-urlencoded");
    response = await _dio.post(uri,data: body,options: op);

    return response.data;

  }

  /// Método que executa chamada de conexão do tipo PUT
  /// @params uri
  /// @params body
  /// @params headers (opcional)
  Future <dynamic> put(String uri,dynamic body, {Map<String,String> headers}) async{

    Response response;

    final op = Options(headers: headers);
    op.contentType = ContentType.parse("application/x-www-form-urlencoded");
    response = await _dio.put(uri,data: body,options: op);

    return response.data;

  }

  /// Método que executa chamada de conexão do tipo DELETE
  /// @params uri
  /// @params headers (opcional)
  Future <dynamic> delete(String uri, {Map<String,String> headers}) async{

    Response response;

    final op = Options(headers: headers);
    response = await _dio.delete(uri,options: op);

    return response.data;

  }

}