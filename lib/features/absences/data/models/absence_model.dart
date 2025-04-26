import '../../domain/entities/absence.dart';
import '../../domain/enums/absence_type.dart';
import 'member_model.dart';

/// The [AbsenceModel] class represents an absence model with various properties.
/// It extends the [Absence] class and implements the [Equatable] interface
/// to allow for value comparison based on its properties.
class AbsenceModel extends Absence {
  const AbsenceModel({
    required super.admitterId,
    required super.admitterNote,
    required super.confirmedAt,
    required super.createdAt,
    required super.crewId,
    required super.endDate,
    required super.id,
    required super.memberNote,
    required super.rejectedAt,
    required super.startDate,
    required super.type,
    required super.userId,
    required super.member,
  });

  factory AbsenceModel.fromJson(Map<String, dynamic> json) {
    return AbsenceModel(
      admitterId: json['admitterId']?.toString(),
      admitterNote: json['admitterNote'] ?? '',
      confirmedAt: json['confirmedAt'] ?? '',
      createdAt: json['createdAt'] ?? '',
      crewId: json['crewId'] ?? -1,
      endDate: json['endDate'] ?? '',
      id: json['id'] ?? -1,
      memberNote: json['memberNote'] ?? '',
      rejectedAt: json['rejectedAt'] ?? '',
      startDate: json['startDate'] ?? '',
      type: AbsenceType.fromName(json['type']?.toString()),
      userId: json['userId'] ?? -1,
      member: MemberModel.fromJson(json['member']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'admitterId': admitterId,
      'admitterNote': admitterNote,
      'confirmedAt': confirmedAt,
      'createdAt': createdAt,
      'crewId': crewId,
      'endDate': endDate,
      'id': id,
      'memberNote': memberNote,
      'rejectedAt': rejectedAt,
      'startDate': startDate,
      'type': type.name,
      'userId': userId,
    };
  }

  @override
  List<Object?> get props => [
        admitterId,
        admitterNote,
        confirmedAt,
        createdAt,
        crewId,
        endDate,
        id,
        memberNote,
        rejectedAt,
        startDate,
        type,
        userId,
      ];
}
