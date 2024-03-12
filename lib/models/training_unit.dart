import 'package:english_learning_app/models/word.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable 
class TrainingUnit
{

  final Word word;
  final bool isPointGained;

  const TrainingUnit({
    required this.word,
    required this.isPointGained
  });

}