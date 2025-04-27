import 'dart:convert';

import 'package:flutter/services.dart';

const absencesPath = 'json_files/absences.json';
const membersPath = 'json_files/members.json';

Future<List<dynamic>> readJsonFile(String path) async {
  final fileContent = await rootBundle.loadString(path);
  Map<String, dynamic> data = jsonDecode(fileContent);

  return data['payload'];
}

Future<List<dynamic>> fetchListOfAbsences() async {
  return await readJsonFile(absencesPath);
}

Future<List<dynamic>> fetchListOfMembers() async {
  return await readJsonFile(membersPath);
}
