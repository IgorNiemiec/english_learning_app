import 'package:english_learning_app/models/word.dart';
import 'package:english_learning_app/models/wotd.dart';

extension IsEqualToIgnoringOrdering<T> on List<T>
{
  bool isEqualToIgnorinOrdering(List<T> other) => 
  length == other.length && {...this}.intersection({...other}).length == length;
}


class UserLibrary
{

  List<Word> words;

  WordOfTheDay wordOfTheDay;

  UserLibrary(
    {
      required this.words,
      required this.wordOfTheDay,
    }
  );

  factory UserLibrary.fromJson(Map<String,dynamic> json)
  {

    List<Word> wordList = [];

    List<dynamic> list = json['words'] as List<dynamic>;

    WordOfTheDay wordOfTheDay  = WordOfTheDay.fromJson(json['wordOfTheDay']);


    for (var element in list) {

        try
        {
          wordList.add(Word.fromJson(element));
        }
        catch(e)
        {
          print(e);
        }
      
    }

    return UserLibrary(
      words: wordList,
      wordOfTheDay: wordOfTheDay,
      );

  }
  
  Map<String,dynamic> toJson()
  {
    var list = [];

    for(var element in words)
    {
      list.add(element.toJson());
    }

    

    return {
      "words": list,
      "wordOfTheDay": wordOfTheDay.toJson(),
    };
    
  }


  @override
  bool operator ==(covariant UserLibrary other) =>
  words.isEqualToIgnorinOrdering(other.words);


  @override
  String toString() => "UserLibrary: ${words.toString()}";
 

}