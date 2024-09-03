// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:developer' as developer;

import 'package:app_settings/app_settings.dart';
import 'package:avto_baraka/generated/l10n.dart';
import 'package:avto_baraka/style/colors.dart';
import 'package:avto_baraka/style/elevation_button_map.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CheckingInternetConnection extends StatefulWidget {
  const CheckingInternetConnection({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<CheckingInternetConnection> createState() =>
      _CheckingInternetConnectionState();
}

class _CheckingInternetConnectionState
    extends State<CheckingInternetConnection> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).internetAloqasiYoq,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor: colorEmber,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              S.of(context).iltimosInternetAloqaniYoqing,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            style: elevatedButtonMap.copyWith(backgroundColor: WidgetStatePropertyAll(colorEmber)),
            child: Text(S.of(context).sozlamalarniOchisgh),
            onPressed: () =>
                AppSettings.openAppSettings(type: AppSettingsType.device),
          ),
        ],
      ),
    );
  }
}
