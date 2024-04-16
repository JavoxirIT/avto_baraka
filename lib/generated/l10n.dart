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

  /// `Additional information`
  String get qoshimchaMalumot {
    return Intl.message(
      'Additional information',
      name: 'qoshimchaMalumot',
      desc: '',
      args: [],
    );
  }

  /// `Type of fuel`
  String get yoqilgiTuri {
    return Intl.message(
      'Type of fuel',
      name: 'yoqilgiTuri',
      desc: '',
      args: [],
    );
  }

  /// `Distance traveled`
  String get yurganMasofasi {
    return Intl.message(
      'Distance traveled',
      name: 'yurganMasofasi',
      desc: '',
      args: [],
    );
  }

  /// `Pulling side`
  String get tortuvchiTomon {
    return Intl.message(
      'Pulling side',
      name: 'tortuvchiTomon',
      desc: '',
      args: [],
    );
  }

  /// `Paint Condition`
  String get boyoqHolati {
    return Intl.message(
      'Paint Condition',
      name: 'boyoqHolati',
      desc: '',
      args: [],
    );
  }

  /// `Transmission`
  String get uzatishQutisi {
    return Intl.message(
      'Transmission',
      name: 'uzatishQutisi',
      desc: '',
      args: [],
    );
  }

  /// `Motor size`
  String get dvigatelHajmi {
    return Intl.message(
      'Motor size',
      name: 'dvigatelHajmi',
      desc: '',
      args: [],
    );
  }

  /// `Body type`
  String get kuzovTuri {
    return Intl.message(
      'Body type',
      name: 'kuzovTuri',
      desc: '',
      args: [],
    );
  }

  /// `Year of manufacture`
  String get ishlabChiqarilganYili {
    return Intl.message(
      'Year of manufacture',
      name: 'ishlabChiqarilganYili',
      desc: '',
      args: [],
    );
  }

  /// `Select the version`
  String get versiyasiniTanlang {
    return Intl.message(
      'Select the version',
      name: 'versiyasiniTanlang',
      desc: '',
      args: [],
    );
  }

  /// `Select a brand`
  String get markaniTanlang {
    return Intl.message(
      'Select a brand',
      name: 'markaniTanlang',
      desc: '',
      args: [],
    );
  }

  /// `First select the type of technique`
  String get avvalTexnikaTuriniTanlang {
    return Intl.message(
      'First select the type of technique',
      name: 'avvalTexnikaTuriniTanlang',
      desc: '',
      args: [],
    );
  }

  /// `Choose a Brand`
  String get brendniTanlang {
    return Intl.message(
      'Choose a Brand',
      name: 'brendniTanlang',
      desc: '',
      args: [],
    );
  }

  /// `Select the type of equipment`
  String get texnikaTuriniTanlang {
    return Intl.message(
      'Select the type of equipment',
      name: 'texnikaTuriniTanlang',
      desc: '',
      args: [],
    );
  }

  /// `Choose a region first`
  String get avvalViloyatniTanlang {
    return Intl.message(
      'Choose a region first',
      name: 'avvalViloyatniTanlang',
      desc: '',
      args: [],
    );
  }

  /// `Regions`
  String get tumanlar {
    return Intl.message(
      'Regions',
      name: 'tumanlar',
      desc: '',
      args: [],
    );
  }

  /// `Select Region`
  String get viloyatniTanlang {
    return Intl.message(
      'Select Region',
      name: 'viloyatniTanlang',
      desc: '',
      args: [],
    );
  }

  /// `Location on the map`
  String get xaritadaJoylashuvi {
    return Intl.message(
      'Location on the map',
      name: 'xaritadaJoylashuvi',
      desc: '',
      args: [],
    );
  }

  /// `Uskunadan Geolokatsiyani yoqish va foydalanishga ruxsat berish kerak bo’ladi`
  String get geolokatsiyaniYoqish {
    return Intl.message(
      'Uskunadan Geolokatsiyani yoqish va foydalanishga ruxsat berish kerak bo’ladi',
      name: 'geolokatsiyaniYoqish',
      desc: '',
      args: [],
    );
  }

  /// `Avtomatik tanlash`
  String get avtomatikTanlash {
    return Intl.message(
      'Avtomatik tanlash',
      name: 'avtomatikTanlash',
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
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'uz'),
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
