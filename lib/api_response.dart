import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class YangaApiResponse<T> {
  final int statusCode;
  final bool status;
  final String message;
  final T? data;
  final List<dynamic>? errors;
  final dynamic meta;
  final String? transactionStatus;

  YangaApiResponse({
    required this.statusCode,
    required this.status,
    required this.message,
    this.data,
    this.errors,
    this.meta,
    this.transactionStatus,
  });

  factory YangaApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$YangaApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$YangaApiResponseToJson(this, toJsonT);
}
