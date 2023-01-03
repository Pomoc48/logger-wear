import 'package:equatable/equatable.dart';

class ListItem extends Equatable {
  final int number;
  final int id;
  final DateTime timestamp;

  const ListItem({
    required this.number,
    required this.id,
    required this.timestamp,
  });

  factory ListItem.fromMap(dynamic map) {
    return ListItem(
      number: map["number"],
      id: map["id"],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map["timestamp"] * 1000),
    );
  }

  @override
  List<Object> get props => [id, timestamp, number];
}
