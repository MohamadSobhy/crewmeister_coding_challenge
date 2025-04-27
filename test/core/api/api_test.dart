import 'package:flutter_test/flutter_test.dart';

import '../../../lib/core/api/api.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('every member has key', () {
    ['id', 'name', 'userId', 'image'].forEach((key) {
      test(key, () async {
        List<dynamic> memberData = await fetchListOfMembers();
        memberData.forEach((member) {
          expect(member.containsKey(key), isTrue);
        });
      });
    });
  });

  group('every absence has key', () {
    [
      'admitterNote',
      'confirmedAt',
      'createdAt',
      'crewId',
      'endDate',
      'id',
      'memberNote',
      'rejectedAt',
      'startDate',
      'type',
      'userId',
    ].forEach((key) {
      test(key, () async {
        List<dynamic> absenceData = await fetchListOfAbsences();
        absenceData.forEach((absence) {
          expect(absence.containsKey(key), isTrue);
        });
      });
    });
  });
}
