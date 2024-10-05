class Contact {
  String name;
  String phoneNumber;

  Contact({
    required this.name,
    required this.phoneNumber,
  });



  // Create a Contact object from a map (useful when retrieving data from Firestore or APIs)
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }
  // Convert a Contact object into a map to store in databases like Firestore
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }
}
