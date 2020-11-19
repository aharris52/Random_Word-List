import 'package:flutter/material.dart';
// import for random word generation
import 'package:english_words/english_words.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){

    return MaterialApp(
      title: 'Harris Travel',
      home: RandomWords()
    );
  }
}

// This class builds a list of randomly generated words
class RandomWordsState extends State<RandomWords>{
  // private var for the words
  final List<WordPair> _suggestions = <WordPair>[];
  // field for saved words from list
  // created as a set of WordList items
  final Set<WordPair> _saved = Set<WordPair>();

  // Random Word Widget, calls the _buildSuggestions()
  // that builds the ListView items of random words
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Word_List"),
      ),
      body: _buildSuggestions(),
    );
  }

  // generates the listView and creates the divider between them
  Widget _buildSuggestions(){
    return ListView.builder(
      // ignore: missing_return
      itemBuilder: (BuildContext _context, int i){
        if(i.isOdd){
          return Divider(
            thickness: 1.3,
          );
        }
        // accounts for every-other index being used for the divider
        final index = i ~/ 2;

        if (index >= _suggestions.length){
          // ignore: missing_return, missing_return
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]); // new row
      },
    );
  }

  // Row Construction Widget
  Widget _buildRow(WordPair pair){
    // for if it has already been saved
    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase
      ),
      trailing: Icon(
        // if it's saved, red heart, otherwise outline
        alreadySaved? Icons.favorite : Icons.favorite_border,
        color: alreadySaved? Colors.red : null,
      ),
      // logic for heart color change
      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved.remove(pair);
          } else{
            _saved.add(pair);
          }
        });
      },
    );
  }

}

// This Class is for calling the RandomWords Class
class RandomWords extends StatefulWidget{
  @override
  RandomWordsState createState() => RandomWordsState();
}