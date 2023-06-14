class User {
  final int? id;  // Make it nullable by adding a '?'
  final String email;
  final String password;

  User({this.id, required this.email, required this.password});  // Remove 'required' from id

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      password: map['password'],
    );
  }
}
