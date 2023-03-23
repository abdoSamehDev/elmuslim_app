import 'package:equatable/equatable.dart';

class AyahModel extends Equatable {
  final int number;
  final String text;
  final int numberInSurah;
  final int juz;
  final int page;
  final int hizbQuarter;
  final bool sajda;

  const AyahModel({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.page,
    required this.hizbQuarter,
    required this.sajda,
  });

  @override
  List<Object> get props => [
        number,
        text,
        numberInSurah,
        juz,
        page,
        hizbQuarter,
        sajda,
      ];
}

class QuranModel extends Equatable {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final List<AyahModel> ayahs;

  const QuranModel({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.ayahs,
  });

  @override
  List<Object> get props => [
        number,
        name,
        englishName,
        englishNameTranslation,
        revelationType,
        ayahs,
      ];
}
