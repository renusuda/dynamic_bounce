/// Player information.
class Player {
  /// Creates a new player instance.
  const Player({
    required this.id,
    required this.name,
  });

  /// Creates a new player from a JSON map.
  Player.fromJson({
    required Map<String, dynamic> json,
  })  : id = json['id'] as String,
        name = json['name'] as String;

  /// Creates a default player.
  const Player.init()
      : id = '',
        name = 'Unknown';

  /// Player ID.
  final String id;

  /// Player name.
  final String name;

  /// Converts this player to a JSON map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
