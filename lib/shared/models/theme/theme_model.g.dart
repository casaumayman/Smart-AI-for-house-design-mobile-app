// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeModel _$ThemeModelFromJson(Map<String, dynamic> json) => ThemeModel(
      json['id'] as int,
      json['name'] as String,
    )..descriptImg = json['descriptImg'] as String?;

Map<String, dynamic> _$ThemeModelToJson(ThemeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'descriptImg': instance.descriptImg,
    };
