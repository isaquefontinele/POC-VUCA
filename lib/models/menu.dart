class Menu {
  final List<Category>? categories;

  const Menu({this.categories});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
        categories: json['cardapio'] != null
            ? List<Category>.from((json['cardapio'] as Iterable<dynamic>)
                .map<dynamic>((dynamic o) =>
                    Category.fromJson(o as Map<String, dynamic>)))
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
        id: json['id'] as String?,
        desc: json['desc'] as String?,
        time: json['hora'] as String?,
        products: json['produtos'] != null
            ? List<MenuItem>.from((json['aListOfObjects'] as Iterable<dynamic>)
                .map<dynamic>((dynamic o) =>
                    MenuItem.fromJson(o as Map<String, dynamic>)))
            : null);
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'desc': desc, 'hora': time, 'produtos': products};
}

class MenuItem {
  final String? id;
  final int? adic;
  final int? idP;
  final String? desc;
  final String? descr;
  final double? val;
  final int? aPar;
  final String? ft;
  final String? thumb;

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
        id: json['id'] as String?,
        adic: json['adic'] as int?,
        idP: json['idP'] as int?,
        desc: json['desc'] as String?,
        descr: json['descr'] as String?,
        val: json['val'] as double?,
        aPar: json['aPar'] as int?,
        ft: json['ft'] as String?,
        thumb: json['thumb'] as String?);
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
