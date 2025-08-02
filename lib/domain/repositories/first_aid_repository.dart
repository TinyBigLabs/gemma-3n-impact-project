// Repository for managing first aid data
import 'dart:convert';

import 'package:emergency_buddy/domain/entities/first_aid_listing_model.dart';
import 'package:emergency_buddy/domain/entities/first_aid_model.dart';
import 'package:emergency_buddy/domain/entities/pdf_reference_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class FirstAidRepository {
  /// Get all first aid procedures
  Future<List<FirstAidData>> getFirstAidDataList();
  Future<List<PdfReference>> getAllPdfs();
  Future<List<FirstAidListing>> getAllListing();
}

/// Exception thrown when repository operations fail
class FirstAidRepositoryException implements Exception {
  final String message;
  final dynamic cause;

  const FirstAidRepositoryException(this.message, [this.cause]);

  @override
  String toString() => 'FirstAidRepositoryException: $message${cause != null ? ' (Cause: $cause)' : ''}';
}

class FirstAidRepositoryImpl  implements FirstAidRepository {
  // Private fields for caching
  List<FirstAidData> _firstAidDataList = [];
  List<PdfReference> _pdfList= [];
  List<FirstAidListing> _firstAidMainListing=[];

  /// Simple init function to load all data
  Future<void> loadData({
    String categoriesAssetPath = 'assets/data/first_aid_categories.json',
    String pdfReferencesAssetPath = 'assets/data/pdf.json',
    String listingsAssetPath = 'assets/data/listing.json',
  }) async {

    if( _firstAidDataList.isNotEmpty &&
        _pdfList.isNotEmpty &&
        _firstAidMainListing.isNotEmpty) {
      // Data already loaded, no need to reload
      debugPrint('Data already loaded, skipping loadData()');
      return;
    }

    debugPrint('Data not loaded yet, loading from assets...');

    debugPrint('Loading data from assets...');
    try {
      final proceduresJson = await rootBundle.loadString(categoriesAssetPath);
      final proceduresArray = json.decode(proceduresJson) as List<dynamic>;
      _firstAidDataList = proceduresArray
          .map((item) => FirstAidData.fromJson(item as Map<String, dynamic>))
          .toList();

      // Load PDF references
      final pdfReferencesJson = await rootBundle.loadString(
          pdfReferencesAssetPath);
      final pdfReferencesArray = json.decode(pdfReferencesJson) as List<dynamic>;
      _pdfList = pdfReferencesArray
          .map((item) => PdfReference.fromJson(item as Map<String, dynamic>))
          .toList();

      // Load listings
      final listingsJson = await rootBundle.loadString(listingsAssetPath);
      final listingsArray = json.decode(listingsJson) as List<dynamic>;
      _firstAidMainListing = listingsArray
          .map((item) => FirstAidListing.fromJson(item as Map<String, dynamic>))
          .toList();

      debugPrint('Loaded ${_firstAidDataList.length} first aid procedures');
      debugPrint('Loaded ${_pdfList.length} PDF references');
      debugPrint('Loaded ${_firstAidMainListing.length} listings');
    } catch (e) {
      debugPrint('Error loading data: $e');
      throw FirstAidRepositoryException('Failed to initialize repository', e);
    }
  }

  @override
  Future<List<FirstAidData>> getFirstAidDataList() async{
    if (_firstAidDataList.isEmpty) {
        await loadData();
    }
    return _firstAidDataList;
  }

  @override
  Future<List<PdfReference>> getAllPdfs() async{
    if (_pdfList.isEmpty) {
      await loadData();
    }
    return _pdfList;
  }

  @override
  Future<List<FirstAidListing>> getAllListing() async{
    if (_firstAidMainListing.isEmpty) {
      await loadData();
    }
    return _firstAidMainListing;
  }
}