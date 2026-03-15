class GiveawayType {
  final int id;
  final String code;
  final String name;
  final String description;
 

  const GiveawayType({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    
  });

  static int _asInt(dynamic v, {int fallback = 0}) {
    if (v is int) return v;
    if (v is String) return int.tryParse(v) ?? fallback;
    if (v is num) return v.toInt();
    return fallback;
  }

  static String _asString(dynamic v, {String fallback = ''}) {
    if (v == null) return fallback;
    if (v is String) return v;
    return v.toString();
  }

  factory GiveawayType.fromJson(Map<String, dynamic>? json) {
    final map = json ?? const <String, dynamic>{};

    return GiveawayType(
      id: _asInt(map['id']),
      code: _asString(map['code']),
      name: _asString(map['name']),
      description: _asString(map['description']),
      // typeCode: GiveawayTypeCode.airtime,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'code': code, 'name': name, 'description': description};
  }

  GiveawayType copyWith({
    int? id,
    String? code,
    String? name,
    String? description,
    // GiveawayTypeCode? typeCode,
  }) {
    return GiveawayType(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      // typeCode: typeCode??this.typeCode,
    );
  }
}

enum GiveawayTypeCode {
  airtime,
  data,
  product;

  bool get isAirtime => this == GiveawayTypeCode.airtime;
  bool get isData => this == GiveawayTypeCode.data;
  bool get isProduct => this == GiveawayTypeCode.product;
}
