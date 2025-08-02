import 'dart:ui' as ui;

import 'package:emergency_buddy/core/location/gps_location.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emergency_buddy/presentation/pages/home_page_web.dart';
import 'package:emergency_buddy/presentation/pages/home_page_mobile.dart';
import 'package:emergency_buddy/presentation/widgets/first_aid/blocs/first_aid_cubit.dart';


class LandingPage extends StatefulWidget {
  const LandingPage({super.key, required this.title});

  final String title;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String _language = ui.window.locale.languageCode;
  String _location = "Fetching location...";
  late Future<void> _loadDataFuture;

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
    // Initialize the future to load data
    _loadDataFuture = context.read<FirstAidCubit>().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child:  FutureBuilder<void>(
              future: _loadDataFuture,
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator while data is being loaded
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Show an error message if loading fails
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  // Show the appropriate home page once data is loaded
                  return kIsWeb
                      ? HomePageWeb(location: _location, language: _language)
                      : HomePageMobile(location: _location, language: _language);
                }
              },
            ),
          ),
    );
  }
}