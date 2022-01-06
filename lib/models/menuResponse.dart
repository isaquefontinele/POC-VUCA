import 'package:poc_vuca/models/menu.dart';

class MenuResponse {
  late bool success;
  late Menu menu;

  MenuResponse();

  MenuResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool,
        menu = Menu.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'success': success, 'cardapio': menu.toJson()};
}
