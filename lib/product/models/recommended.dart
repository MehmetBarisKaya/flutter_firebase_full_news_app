import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_project/product/utility/base/base_firebase_model.dart';

@immutable
class Recommended with EquatableMixin, IdModel, BaseFirebaseModel<Recommended> {
  const Recommended({
    this.name,
    this.description,
    this.image,
    this.id,
  });
  final String? name;
  final String? description;
  final String? image;
  @override
  final String? id;

  @override
  List<Object?> get props => [name, description, image];

  Recommended copyWith({
    String? name,
    String? description,
    String? image,
  }) {
    return Recommended(
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'image': image,
    };
  }

  @override
  Recommended fromJson(Map<String, dynamic> json) {
    return Recommended(
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
    );
  }
}
