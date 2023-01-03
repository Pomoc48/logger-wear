import 'package:equatable/equatable.dart';

class ListOfItems extends Equatable {
  final int id;
  final String name;
  final int count;
  final DateTime timestamp;
  final List<int> chartData;

  const ListOfItems({
    required this.id,
    required this.name,
    required this.count,
    required this.timestamp,
    required this.chartData,
  });

  factory ListOfItems.fromMap(dynamic map) {
    return ListOfItems(
      id: map["id"],
      name: map["name"],
      count: map["count"],
      timestamp: DateTime.fromMillisecondsSinceEpoch(map["timestamp"] * 1000),
      chartData: List<int>.from(map["chart_data"]),
    );
  }

  @override
  List<Object> get props => [id, name, count, timestamp, chartData];
}
