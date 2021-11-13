import 'dart:convert';

import 'package:hrapp/models/role_model.dart';
import 'package:hrapp/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteService {
  Future<List<User>> fetchUsers();
  Future<List<Role>> fetchRoles();
  Future<Role> createRole(
    String title,
    String requirement,
    String description,
  );
}

class ApiService implements RemoteService {
  static const String _baseUrl = 'http://hr.ekrut.co';

  @override
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$_baseUrl/items/users'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<User> users =
          (data['data'] as List).map((user) => User.fromJson(user)).toList();
      return users;
    } else {
      return throw Exception('Failed to load list of users');
    }
  }

  @override
  Future<List<Role>> fetchRoles() async {
    final response = await http.get(Uri.parse('$_baseUrl/items/role'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Role> users =
          (data['data'] as List).map((user) => Role.fromJson(user)).toList();
      return users;
    } else {
      return throw Exception('Failed to load list of users');
    }
  }

  @override
  Future<Role> createRole(
      String title, String requirement, String description) async {
    final response = await http.post(Uri.parse('$_baseUrl/items/role'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "title": title,
          "requirement": requirement,
          "description": description
        }));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Role newRole = Role.fromJson(data['data']);
      return newRole;
    } else {
      return throw Exception('Failed to create role');
    }
  }
}
