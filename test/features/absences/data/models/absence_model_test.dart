import 'package:crewmeister_coding_challenge/features/absences/data/models/absence_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// Setup
  final tAbsenceJson = {
    "admitterId": null,
    "admitterNote": "",
    "confirmedAt": "2020-12-12T18:03:55.000+01:00",
    "createdAt": "2020-12-12T14:17:01.000+01:00",
    "crewId": 352,
    "endDate": "2021-01-13",
    "id": 2351,
    "memberNote": "",
    "rejectedAt": null,
    "startDate": "2021-01-13",
    "type": "sickness",
    "userId": 2664,
    "member": {
      "crewId": 352,
      "id": 2650,
      "image": "https://loremflickr.com/300/400",
      "name": "Mike",
      "userId": 2664
    },
  };

  /// Test cases
  group(
    'AbsenceMode.fromJson(json)',
    () {
      test(
        'should return a valid AbsenceModel when the JSON is valid',
        () async {
          // arrange
          final tAbsenceModel = AbsenceModel.fromJson(tAbsenceJson);

          // act
          final result = AbsenceModel.fromJson(tAbsenceJson);

          // assert
          expect(result, tAbsenceModel);
        },
      );

      test(
        'should correctly parse the JSON to AbsenceModel',
        () async {
          // act
          final model = AbsenceModel.fromJson(tAbsenceJson);

          // assert
          expect(model.crewId, 352);
          expect(model.admitterId, null);
          expect(model.admitterNote, "");
          expect(model.confirmedAt, "2020-12-12T18:03:55.000+01:00");
          expect(model.createdAt, "2020-12-12T14:17:01.000+01:00");
          expect(model.crewId, 352);
          expect(model.endDate, "2021-01-13");
          expect(model.id, 2351);
          expect(model.memberNote, "");
          expect(model.rejectedAt, '');
          expect(model.startDate, "2021-01-13");
          expect(model.type.name, "sickness");
          expect(model.userId, 2664);
          expect(model.member.crewId, 352);
          expect(model.member.name, 'Mike');
          expect(model.member.id, 2650);
          expect(model.member.image, "https://loremflickr.com/300/400");
          expect(model.member.userId, 2664);
        },
      );
    },
  );
}
