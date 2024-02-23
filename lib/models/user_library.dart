import 'package:english_learning_app/models/word.dart';

extension IsEqualToIgnoringOrdering<T> on List<T>
{
  bool isEqualToIgnorinOrdering(List<T> other) => 
  length == other.length && {...this}.intersection({...other}).length == length;
}


class UserLibrary
{

  List<Word> words;

  UserLibrary(
    {
      required this.words
    }
  );

  factory UserLibrary.fromJson(Map<String,dynamic> json)
  {

    List<Word> wordList = [];

    List<Map<String,dynamic>> list = json['words'];

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

    return UserLibrary(words: wordList);

  }
  
  Map<String,dynamic> toJson()
  {
    var list = [];

    for(var element in words)
    {
      element.toJson();
      list.add(element);
    }

    return {
      "words": words
    };
    
  }


  @override
  bool operator ==(covariant UserLibrary other) =>
  words.isEqualToIgnorinOrdering(other.words);


  @override
  String toString() => "UserLibrary: ${words.toString()}";
 

}