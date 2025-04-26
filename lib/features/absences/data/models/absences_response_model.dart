import '../../domain/entities/absences_response.dart';
import 'absence_model.dart';

/// The [AbsencesResponseModel] class represents a response model for absences.
/// It extends the [AbsencesResponse] class and implements the [Equatable] interface
/// to allow for value comparison based on its properties.
/// The class contains properties such as [totalCount] and [absences] to represent
/// the number of absences and a list of absence models.
///
class AbsencesResponseModel extends AbsencesResponse {
  const AbsencesResponseModel({
    required super.totalCount,
    required super.absences,
  });

  factory AbsencesResponseModel.fromJson(Map<String, dynamic> json) {
    return AbsencesResponseModel(
      totalCount: json['count'] ?? 0,
      absences: ((json['absences'] ?? []) as List<dynamic>)
          .map((e) => AbsenceModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': totalCount,
      'absences': absences.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [totalCount, absences];
}
