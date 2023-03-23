// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'azkar_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AzkarResponse _$AzkarResponseFromJson(Map<String, dynamic> json) =>
    AzkarResponse(
      json['category'] as String,
      json['count'] as int,
      json['description'] as String,
      json['reference'] as String,
      json['zekr'] as String,
    );

Map<String, dynamic> _$AzkarResponseToJson(AzkarResponse instance) =>
    <String, dynamic>{
      'category': instance.category,
      'count': instance.count,
      'description': instance.description,
      'reference': instance.reference,
      'zekr': instance.zekr,
    };
