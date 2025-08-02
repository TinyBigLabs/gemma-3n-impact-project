import 'dart:ui' as ui;

import 'package:emergency_buddy/core/location/gps_location.dart';
import 'package:flutter/material.dart';

class TopSectionCard extends StatefulWidget {
  const TopSectionCard({super.key});

  @override
  State<TopSectionCard> createState() => _TopSectionCardState();
}

class _TopSectionCardState extends State<TopSectionCard> {
  String _language = ui.window.locale.languageCode;
  String _location = "Fetching location...";

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
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Language: $_language",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            Text(
              "Location: $_location",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
