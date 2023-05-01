import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class CustomAdhkarEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String count;
  final String dhikr;

  const CustomAdhkarEntity({
    required this.id,
    required this.count,
    required this.dhikr,
  });

  @override
  List<Object> get props => [
    count,
    dhikr,
  ];
}
