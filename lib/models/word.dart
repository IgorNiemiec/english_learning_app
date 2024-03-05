

class Word
{

 final String wordEn;
 final String wordPl;
 final int points;
 final String wordLevel;

 const Word({
  required this.wordEn,
  required this.wordPl,
  required this.points,
  required this.wordLevel,
 });


 factory Word.updatePoints({
  required Word keyWord,
  required int points, 
 }) 
 {
  if (points<1)
  {
    points=0;
  }

 return Word(
  wordEn: keyWord.wordEn, 
  wordPl: keyWord.wordPl, 
  points: points, 
  wordLevel: keyWord.wordLevel);

 } 

 

 factory Word.fromJson(Map<String,dynamic> json) => Word(
  wordEn: json['wordEn'] as String,
  wordPl: json['wordPl'] as String, 
  points: json['points'] as int, 
  wordLevel: json['wordLevel'] as String
 );


  Map<String,dynamic> toJson()
  {
    return {
      "wordEn" : wordEn,
      "wordPl" : wordPl,
      "points" : points ,
      "wordLevel" : wordLevel,
    };
  }


 @override
 String toString() => "Word: $wordEn, Translation: $wordPl, Points: $points, word level: $wordLevel";
 
 @override
 bool operator == (covariant other) 
 {
   if (other is Word)
   {
      if ((wordEn == other.wordEn && wordPl == other.wordPl && wordLevel == other.wordLevel))
      {
        return true;
      }
      else
      {
        return false;
      }
   }
   else
   {
    return false;
   }
 } 

 @override
 int get hashCode => Object.hash(
  wordEn,
  wordPl,
  wordLevel);


}