import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:emergency_buddy/core/location/gps_location.dart';
import 'package:emergency_buddy/presentation/pages/home_page_mobile.dart';
import 'package:emergency_buddy/presentation/pages/home_page_web.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key, required this.title});

  final String title;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String _language = ui.window.locale.languageCode;
  String _location = "Fetching location...";

  // Initialize the GPSLocation instance and fetch the location
  Future<void> setLocation() async {
    try {
      _location = await GPSLocation().getLocation();
      setState(() {});
    } catch (e) {
      _location = "Failed to fetch location: $e";
    }
  }

  @override
  void initState() {
    super.initState();
    setLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: kIsWeb
            ? HomePageWeb(location: _location, language: _language)
            : HomePageMobile(location: _location, language: _language),
      ),
    );
  }
}
