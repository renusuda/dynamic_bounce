/// User information.
class User {
  /// Creates a new user instance.
  const User({
    required this.id,
    required this.name,
  });

  /// Creates a new user from a JSON map.
  User.fromJson({
    required Map<String, dynamic> json,
  })  : id = json['id'] as String,
        name = json['name'] as String;

  /// User ID.
  final String id;

  /// User name.
  final String name;

  /// Converts this user to a JSON map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
