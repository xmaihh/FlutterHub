import 'dart:developer';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class RandomWordsWidget extends StatelessWidget {
  const RandomWordsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return

        //   const DecoratedBox(decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('graphics/background.jpg')
        //   )
        // ));

        Padding(
            padding: const EdgeInsets.all(8.0),
            // child:
            child: Column(
              children: [
                Image.asset('graphics/background.jpg'),
                Text(wordPair.toString()),
              ],
            ));
  }
}

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/config.json');
}

void someFunction() async {
  String jsonString = await loadAsset();
  print(jsonString);
  debugger(when: jsonString.length > 0);
  debugPrint(jsonString);
}

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: TextButton(
          child: const Text('Dump me'),
          onPressed: () {
            // 调试Widgets树
            debugDumpApp();
            // 调试Render树
            debugDumpRenderTree();
            // 调试Layer树
            debugDumpLayerTree();
          },
        ),
      ),
    );
  }
}

class FocusTestRoute extends StatefulWidget {
  const FocusTestRoute({super.key});

  @override
  _FocusTestRouteState createState() => _FocusTestRouteState();
}

class _FocusTestRouteState extends State<FocusTestRoute> {
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusScopeNode? focusScopeNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Focus Test Route')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          TextField(
              autofocus: true,
              focusNode: focusNode1,
              decoration: const InputDecoration(labelText: 'input1')),
          TextField(
            focusNode: focusNode2,
            decoration: const InputDecoration(labelText: 'input2'),
          ),
          Builder(builder: (ctx){
            return Column(
              children: <Widget>[
                ElevatedButton(onPressed: (){
                  FocusScope.of(context).requestFocus(focusNode2);
                }, child: const Text('移动焦点')),
                ElevatedButton(onPressed: (){
                  //当所有编辑框都失去焦点时键盘就会收起
                  focusNode1.unfocus();
                  focusNode2.unfocus();
                }, child: const Text('隐藏键盘'))
              ],
            );
          },)
        ]),
      ),
    );
  }
}
