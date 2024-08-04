import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResponseModel<T> {
  final T? data;
  final int errorCode;
  final String errorMsg;

  ResponseModel({
    required this.data,
    required this.errorCode,
    required this.errorMsg,
  });

  factory ResponseModel.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic json) fromJsonT,
      ) =>
      _$ResponseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(dynamic Function(T value) toJsonT) =>
      _$ResponseModelToJson(this, toJsonT);

  @override
  String toString() {
    return 'ResponseModel(data: $data, errorCode: $errorCode, errorMsg: "$errorMsg")';
  }
}
