import 'package:flutter/material.dart';
import 'package:hrapp/data/remote/api_service.dart';
import 'package:hrapp/models/user_model.dart';
import 'package:hrapp/res/constant.dart';

class GetUser extends ChangeNotifier {
  ApiService apiService = ApiService();
  late String id;

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  late List<User> _result;
  List<User> get result => _result;

  GetUser() {
    fetchUsers();
    searchUser('');
  }
  Future<dynamic> fetchUsers() async {
    try {
      _state = ResultState.loading;
      _message = 'Sedang memuat...';

      final detail = await apiService.fetchUsers();

      if (detail == null) {
        _state = ResultState.noData;
        _message = 'Tidak menemukan user satupun';
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        _message = '';
        notifyListeners();
        return _result = detail;
      }
    } catch (e) {
      _state = ResultState.error;
      // notifyListeners();
      return _message = 'Pastikan anda terhubung dengan internet ya...';
    }
  }

  final List<User> _searchResult = [];
  List<User> get searchResult => _searchResult;

  Future<dynamic> searchUser(String query) async {
    try {
      _searchResult.clear();
      _state = ResultState.loading;

      for (var user in _result) {
        if (user.fullname!.toLowerCase().contains(query.toLowerCase())) {
          _state = ResultState.hasData;
          _searchResult.add(user);
        }
      }
      if (_searchResult.isEmpty) {
        _message = '$query not found';
        notifyListeners();
      }
      notifyListeners();
      return _searchResult;
    } catch (e) {
      _state = ResultState.error;
      _message = 'Make sure you are connected through Internet';
      notifyListeners();
    }
  }
}
