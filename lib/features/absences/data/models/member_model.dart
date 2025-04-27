import '../../domain/entities/member.dart';

/// The [MemberModel] class represents a member model with various properties.
/// It extends the [Member] class and implements the [Equatable] interface
/// to allow for value comparison based on its properties.
/// The class contains properties such as [crewId], [id], [image], [name], and [userId]
/// to represent different aspects of a member.
class MemberModel extends Member {
  const MemberModel({
    required super.crewId,
    required super.id,
    required super.image,
    required super.name,
    required super.userId,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      crewId: json['crewId'] ?? 0,
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      userId: json['userId'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'crew_id': crewId,
      'id': id,
      'image': image,
      'name': name,
      'user_id': userId,
    };
  }

  @override
  List<Object?> get props => [crewId, id, image, name, userId];
}
