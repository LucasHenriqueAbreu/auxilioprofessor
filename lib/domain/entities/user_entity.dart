// user_entity.dart

class User {
  final String uid;
  final String email;
  final String displayName;
  final String photoURL;

  User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.photoURL,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.uid == uid &&
        other.email == email &&
        other.displayName == displayName &&
        other.photoURL == photoURL;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        displayName.hashCode ^
        photoURL.hashCode;
  }
}
