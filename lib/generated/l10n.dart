// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `No internet connection`
  String get no_internet_connection_msg {
    return Intl.message(
      'No internet connection',
      name: 'no_internet_connection_msg',
      desc: '',
      args: [],
    );
  }

  /// `Absences ({count})`
  String absencesCountFormat(int count) {
    return Intl.message(
      'Absences ($count)',
      name: 'absencesCountFormat',
      desc: '',
      args: [count],
    );
  }

  /// `Filters`
  String get filters {
    return Intl.message(
      'Filters',
      name: 'filters',
      desc: '',
      args: [],
    );
  }

  /// `Select Absence Type`
  String get select_absence_type {
    return Intl.message(
      'Select Absence Type',
      name: 'select_absence_type',
      desc: '',
      args: [],
    );
  }

  /// `Select Absence Date`
  String get select_absence_date {
    return Intl.message(
      'Select Absence Date',
      name: 'select_absence_date',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Period ({durationInDays})`
  String periodFormatMsg(String durationInDays) {
    return Intl.message(
      'Period ($durationInDays)',
      name: 'periodFormatMsg',
      desc: '',
      args: [durationInDays],
    );
  }

  /// `From {startDate} to {endDate}`
  String periodRangeMsg(String startDate, String endDate) {
    return Intl.message(
      'From $startDate to $endDate',
      name: 'periodRangeMsg',
      desc: '',
      args: [startDate, endDate],
    );
  }

  /// `Member Note`
  String get member_note {
    return Intl.message(
      'Member Note',
      name: 'member_note',
      desc: '',
      args: [],
    );
  }

  /// `Admitter Note`
  String get admitter_note {
    return Intl.message(
      'Admitter Note',
      name: 'admitter_note',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `No absences found`
  String get no_absences_msg {
    return Intl.message(
      'No absences found',
      name: 'no_absences_msg',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
