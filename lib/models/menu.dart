class Menu {
  final List<Category>? categories;

  const Menu({this.categories});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
        categories: json['cardapio'] != null
            ? List<Category>.from((json['cardapio'] as Iterable<dynamic>)
                .map<dynamic>((dynamic obj) =>
                    Category.fromJson(obj)))
            : null);
  }

  Map<String, dynamic> toJson() => {'cardapio': categories};
}

class Category {
  final String? id;
  final String? desc;
  final String? time;
  final List<MenuItem>? products;

  const Category({this.id, this.desc, this.time, this.products});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'].toString(),
        desc: json['desc'].toString(),
        time: json['hora'].toString(),
        products: json['produtos'] != null
            ? List<MenuItem>.from((json['produtos'] as Iterable<dynamic>)
                .map<dynamic>((dynamic obj) =>
                    MenuItem.fromJson(obj)))
            : null);
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'desc': desc, 'hora': time, 'produtos': products};
}

class MenuItem {
  final String? id;
  final String? adic;
  final String? idP;
  final String? desc;
  final String? descr;
  final String? val;
  final String? aPar;
  final List<String>? ft;
  final List<String>? thumb;

  MenuItem(
      {this.id,
      this.adic,
      this.idP,
      this.desc,
      this.descr,
      this.val,
      this.aPar,
      this.ft,
      this.thumb});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
        id: json['id'].toString(),
        adic: json['adic'].toString(),
        idP: json['idP'].toString(),
        desc: json['desc'].toString(),
        descr: json['descr'].toString(),
        val: json['val'].toString(),
        aPar: json['aPar'].toString(),
        ft: new List<String>.from(json['ft']),
        thumb: new List<String>.from(json['thumb']));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'adic': adic,
        'idP': idP,
        'desc': desc,
        'descr': descr,
        'val': val,
        'aPar': aPar,
        'ft': ft,
        'thumb': thumb
      };
}
