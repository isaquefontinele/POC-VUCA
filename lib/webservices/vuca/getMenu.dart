import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:poc_vuca/auth/secrets.dart';
import 'package:poc_vuca/models/menu.dart';
import 'package:poc_vuca/models/menuResponse.dart';

import '../webServiceSettings.dart';

class GetMenuService {
  Future<Menu> getFullMenu() async {
    var requestBody = {
      'token' : vuca_token,
      'wlib' : 'cardapioProdutos',
      'vucaName' : 'lifeboxburger',
      'id_usuario' : 7,
      'id_unidade' : 16,
      'telaInicial': false
    };

    final http.Response response = await http.post(
        Uri.parse('$vuca_base_url$menu_path'),
        body: json.encode(requestBody),
        headers: WebServiceSettings.getDefaultHeaders());

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> jsonMap = json.decode(response.body);
        var menuResponse = MenuResponse.fromJson(jsonMap);
        if (menuResponse.success) {
          return menuResponse.menu;
        } else {
          return Future.error("Não foi possível obter o cardápio.");
        }
      } catch (error) {
        error.toString();
      }
    }
    return Future.error("Não foi possível obter o cardápio.");
  }
}
