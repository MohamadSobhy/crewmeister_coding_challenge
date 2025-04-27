import 'package:crewmeister_coding_challenge/app_module.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

import '../enums/absence_type.dart';
import 'member.dart';

/// The [Absence] class represents an absence entity with various properties.
/// It extends the [Equatable] class to allow for value comparison based on its properties.
/// The class contains properties such as [admitterId], [admitterNote], [confirmedAt],
/// [createdAt], [crewId], [endDate], [id], [memberNote], [rejectedAt], [startDate],
/// [type], and [userId]. These properties represent different aspects of an absence.
abstract class Absence extends Equatable {
  final String? admitterId;
  final String admitterNote;
  final String confirmedAt;
  final String createdAt;
  final int crewId;
  final String endDate;
  final int id;
  final String memberNote;
  final String rejectedAt;
  final String startDate;
  final AbsenceType type;
  final int userId;
  final Member member;

  const Absence({
    required this.admitterId,
    required this.admitterNote,
    required this.confirmedAt,
    required this.createdAt,
    required this.crewId,
    required this.endDate,
    required this.id,
    required this.memberNote,
    required this.rejectedAt,
    required this.startDate,
    required this.type,
    required this.userId,
    required this.member,
  });

  String get status {
    if (confirmedAt.trim().isNotEmpty) {
      return 'Confirmed';
    } else if (rejectedAt.trim().isNotEmpty) {
      return 'Rejected';
    } else {
      return 'Requested';
    }
  }

  Color get statusColor {
    if (confirmedAt.trim().isNotEmpty) {
      return AppModule.I.appColors.validColor;
    } else if (rejectedAt.trim().isNotEmpty) {
      return AppModule.I.appColors.errorColor;
    } else {
      return AppModule.I.appColors.pendingColor;
    }
  }

  String get durationInDays {
    final start = DateTime.parse(startDate);
    final end = DateTime.parse(endDate);
    final days = end.difference(start).inDays + 1;

    return '$days Day${days > 1 ? 's' : ''}';
  }

  Map<String, dynamic> toJson();
}
