import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:poc_vuca/auth/secrets.dart';
import 'package:poc_vuca/models/menu.dart';
import 'package:poc_vuca/models/menuResponse.dart';

import '../webServiceSettings.dart';

class GetMenuService {
  Future<Menu> getFullMenu(String companyId) async {
    final http.Response response = await http.get(
        Uri.parse('$vuca_base_url$menu_path'),
        headers: WebServiceSettings.getDefaultHeaders());
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      var menuResponse = MenuResponse.fromJson(jsonMap);
      if (menuResponse.success) {
        return menuResponse.menu;
      }
    }
    return Future.error("Não foi possível obter o cardápio.");
  }
}
