class User {
  final String userId;
  final String name;
  final List<String> interests;
  final List<String> affiliations;
  final int age;

  User({
    required this.userId,
    required this.name,
    required this.interests,
    required this.affiliations,
    required this.age,
  });
}