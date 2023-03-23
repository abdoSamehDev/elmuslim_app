import 'package:equatable/equatable.dart';

class AzkarModel extends Equatable {
 final String category;
 final int count;
 final String description;
 final String reference;
 final String zekr;

 const AzkarModel({
    required this.category,
    required this.count,
    required this.description,
    required this.reference,
    required this.zekr,
  });

  @override
  List<Object> get props => [
    category,
    count,
    description,
   reference,
    zekr,
  ];
}
