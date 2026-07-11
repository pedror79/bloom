class Identity {
  final String name;
  final int age;

  const Identity({
    required this.name,
    required this.age,
  });

  Identity copyWith({
    String? name,
    int? age,
  }) {
    return Identity(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }
}