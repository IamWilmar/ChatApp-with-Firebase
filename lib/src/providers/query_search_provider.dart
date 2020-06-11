import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchQueryProvider with ChangeNotifier{
  QuerySnapshot _searchQuery;

  QuerySnapshot get searchQuery => _searchQuery;

  set searchQuery(QuerySnapshot searchQuery) {
    this._searchQuery = searchQuery;
    notifyListeners();
  }
}