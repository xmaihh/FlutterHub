import 'package:json_annotation/json_annotation.dart';

part 'response_list_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResponseListModel<T> {
  final List<T>? data;
  final int errorCode;
  final String errorMsg;

  ResponseListModel({required this.data, required this.errorCode, required this.errorMsg});

  factory ResponseListModel.fromJson(Map<String, dynamic> json, T Function(dynamic json) fromJsonT) => _$ResponseListModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(dynamic Function(T value) toJsonT) => _$ResponseListModelToJson(this, toJsonT);

  @override
  String toString() {
    return 'ResponseListModel(data: $data, errorCode: $errorCode, errorMsg: "$errorMsg")';
  }
}
