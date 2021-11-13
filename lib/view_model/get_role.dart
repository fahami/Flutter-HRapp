import 'package:flutter/material.dart';
import 'package:hrapp/data/remote/api_service.dart';
import 'package:hrapp/models/role_model.dart';
import 'package:hrapp/res/constant.dart';

class GetRole extends ChangeNotifier {
  ApiService apiService = ApiService();
  late String id;

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  late List<Role> _result;
  List<Role> get result => _result;

  GetRole() {
    fetchRoles();
  }

  Future<dynamic> fetchRoles() async {
    try {
      _state = ResultState.loading;
      _message = 'Sedang memuat...';
      final detail = await apiService.fetchRoles();
      if (detail == null) {
        _state = ResultState.noData;
        return _message = 'Tidak menemukan user satupun';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _result = detail;
      }
    } catch (e) {
      _state = ResultState.error;
      // notifyListeners();
      return _message = 'Pastikan anda terhubung dengan internet ya...';
    }
  }

  late Role _newRole;
  Role get newRole => _newRole;

  Future<dynamic> createRole(
      String title, String description, String requirement) async {
    try {
      _state = ResultState.loading;
      _message = 'Sedang memuat...';
      final detail =
          await apiService.createRole(title, requirement, description);
      if (detail == null) {
        _state = ResultState.noData;
        return _message = 'Cannot create role';
      } else {
        _newRole = detail;
        notifyListeners();
        return _newRole = detail;
      }
    } catch (e) {
      _state = ResultState.error;
      // notifyListeners();
      return _message = 'Pastikan anda terhubung dengan internet ya...';
    }
  }
}
