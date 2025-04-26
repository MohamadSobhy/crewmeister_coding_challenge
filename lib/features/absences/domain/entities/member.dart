import 'package:equatable/equatable.dart';

/// The [Member] class represents a member entity with various properties.
/// It extends the [Equatable] class to allow for value comparison based on its properties.
/// The class contains properties such as [crewId], [id], [image], [name], and [userId]
/// to represent different aspects of a member.
abstract class Member extends Equatable {
  final int crewId;
  final int id;
  final String image;
  final String name;
  final int userId;

  const Member({
    required this.crewId,
    required this.id,
    required this.image,
    required this.name,
    required this.userId,
  });

  Map<String, dynamic> toJson();
}
