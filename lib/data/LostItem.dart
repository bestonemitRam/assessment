class LostItem {
  final int? id; // SQLite will auto-increment this
  final String name;
  final String contactInfo;
  final String itemDescription;
  final String date;
  final String location;
  final List<String> images; // Store image paths as strings in a JSON-like format

  LostItem({
    this.id,
    required this.name,
    required this.contactInfo,
    required this.itemDescription,
    required this.date,
    required this.location,
    required this.images,
  });

  // Convert to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contactInfo': contactInfo,
      'itemDescription': itemDescription,
      'date': date,
      'location': location,
      'images': images.join(','),
    };
  }

  // Create object from Map
  factory LostItem.fromMap(Map<String, dynamic> map) {
    return LostItem(
      id: map['id'],
      name: map['name'],
      contactInfo: map['contactInfo'],
      itemDescription: map['itemDescription'],
      date: map['date'],
      location: map['location'],
      images: (map['images'] as String).split(','),
    );
  }
}
