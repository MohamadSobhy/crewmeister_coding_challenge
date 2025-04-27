import 'package:flutter/widgets.dart';

import '../../domain/enums/absence_type.dart';

class AbsencesFiltersController with ChangeNotifier {
  AbsenceType? _selectedAbsenceType;
  String? _selectedDate;

  /// Getters
  AbsenceType? get selectedAbsenceType => _selectedAbsenceType;
  String? get selectedDate => _selectedDate;

  /// Setters
  void setSelectedDate(String date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setSelectedAbsenceType(AbsenceType type) {
    _selectedAbsenceType = type;
    notifyListeners();
  }

  void clearFilters() {
    _selectedDate = null;
    _selectedAbsenceType = null;
    notifyListeners();
  }

  int get filtersCount {
    int count = 0;

    if (_selectedAbsenceType != null) count++;
    if (_selectedDate != null) count++;

    return count;
  }
}
