import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class ApiResponse<T extends Object> extends Equatable {
  final int statusCode;
  final String message;
  final T? data;
  final bool isSuceess;
  final List<MapEntry<String, List<String>>>? errors;

  const ApiResponse.success({
    this.statusCode = 200,
    required this.message,
    required this.data,
    this.isSuceess = true,
  }) : errors = null;

  const ApiResponse.error({
    this.statusCode = 0,
    required this.message,
    this.isSuceess = false,
    this.errors = const [],
  }) : data = null;

  factory ApiResponse.fromMapSuccess(Map<String, dynamic> map, {T Function(Map<String, dynamic>)? mapper}) {
    return ApiResponse<T>.success(
      message: map['message'],
      data: mapper != null ? mapper(map['data']) : map['data'],
      isSuceess: map['success'],
    );
  }

  factory ApiResponse.fromMapError(Response? response) {
    final data = response?.data;
    return ApiResponse<T>.error(
      message: data?['message'],
      isSuceess: data?['success'] ?? false,
      errors: List<MapEntry<String, List<String>>>.from(data?['errors'].entries.map((e) => MapEntry<String, List<String>>(e.key, List<String>.from(e.value)))),
    );
  }

  @override
  String toString() => 'ApiResponse(message: $message, data: $data, isSuceess: $isSuceess, errors: $errors)';

  @override
  List<Object?> get props => [message, data, isSuceess, errors];
}