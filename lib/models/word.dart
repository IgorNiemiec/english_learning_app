

class Word
{

 final String wordEn;
 final String wordPl;
 int points;
 final String wordLevel;

  Word({
  required this.wordEn,
  required this.wordPl,
  required this.points,
  required this.wordLevel,
 });

 factory Word.fromJson(Map<String,dynamic> json) => Word(
  wordEn: json['wordEn'] as String,
  wordPl: json['wordPl'] as String, 
  points: json['points'] as int, 
  wordLevel: json['wordLevel'] as String
 );

 @override
 String toString() => "Word: $wordEn, Translation: $wordPl, Points: $points, word level: $wordLevel";
 
 @override
 bool operator == (covariant Word other) => (wordEn == other.wordEn && wordPl == other.wordPl && wordLevel == other.wordLevel);

 @override
 int get hashCode => Object.hash(
  wordEn,
  wordPl,
  wordLevel);


}