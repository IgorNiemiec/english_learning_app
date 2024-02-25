

import 'package:english_learning_app/models/word.dart';

class WordOfTheDay
{
  final Word wotd;
  final int timestamp;

  const WordOfTheDay({
    required this.wotd,
    required this.timestamp,
  });
  

  factory WordOfTheDay.fromJson(Map<String,dynamic> json) => 
  WordOfTheDay(
    wotd: Word.fromJson(json['wotd']), 
    timestamp: json['timestamp'] as int);


  Map<String,dynamic> toJson() => 
  {
    "wotd" : wotd.toJson(),
    "timestamp" : timestamp,
  };


}