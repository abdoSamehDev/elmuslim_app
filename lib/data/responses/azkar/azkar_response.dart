import 'package:json_annotation/json_annotation.dart';
part 'azkar_response.g.dart';


@JsonSerializable()
class AzkarResponse{
  @JsonKey(name: "category")
  String category;
  @JsonKey(name: "count")
  String count;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "reference")
  String reference;
  @JsonKey(name: "zekr")
  String zekr;


  AzkarResponse(this.category, this.count, this.description, this.reference, this.zekr,);

  //from Json
  factory AzkarResponse.fromJson(Map<String, dynamic> json) => _$AzkarResponseFromJson(json);

//to Json
  Map<String, dynamic> toJson() => _$AzkarResponseToJson(this);
}