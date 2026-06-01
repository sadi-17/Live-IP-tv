class ServerModel {
  final String id;
  final String name;
  final String url;
  final String icon;
  final String description;
  bool isActive;

  ServerModel({
    required this.id,
    required this.name,
    required this.url,
    this.icon = '⚽',
    this.description = '',
    this.isActive = true,
  });

  static List<ServerModel> defaultServers = [
    ServerModel(
      id: '1',
      name: 'Stadium 1 - Live Feed',
      url: 'http://10.2.2.10',
      icon: '⚽',
      description: 'Main match streaming',
    ),
    ServerModel(
      id: '2',
      name: 'Stadium 2 - Championship',
      url: 'http://172.17.50.112',
      icon: '🏆',
      description: 'Championship matches',
    ),
    ServerModel(
      id: '3',
      name: 'World Cup - Global Feed',
      url: 'http://192.168.91.8',
      icon: '🌍',
      description: 'International broadcasts',
    ),
  ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'icon': icon,
      'description': description,
      'isActive': isActive,
    };
  }

  factory ServerModel.fromJson(Map<String, dynamic> json) {
    return ServerModel(
      id: json['id'],
      name: json['name'],
      url: json['url'],
      icon: json['icon'] ?? '⚽',
      description: json['description'] ?? '',
      isActive: json['isActive'] ?? true,
    );
  }
}
