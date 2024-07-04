import 'package:flutter/material.dart';

class Newroute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Route'),
      ),
      body: const Center(
        child: Text("This is new route"),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings){
        switch(settings.name){
          case "/":
            return MaterialPageRoute(builder: (context)=>const MyHomePage(title: 'Flutter Demo Home Page'));
          case "/new_page":
            return MaterialPageRoute(builder: (context)=>Newroute());
          case "tip2":
            return MaterialPageRoute(builder: (context)=>TipRoute(text: settings.arguments));
        }
      },
      routes: {
        '/':(context)=>const MyHomePage(title: 'Flutter Demo Home Page'),
        "/new_page":(context)=>Newroute(),
        "tip2":(context)=>TipRoute(text: ModalRoute.of(context)!.settings.arguments)
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Newroute()),
                // );

                Navigator.pushNamed(context, '/A', arguments: '我是传递的参数');
              },
              child: const Text('Open new route'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({required this.text, Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('提示'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            children: [
              Text(text),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, '我是返回值'),
                child: const Text('返回'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RouterTestRoute extends StatelessWidget {
  const RouterTestRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          // 打开新路由
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return TipRoute(
                  text: '我是提示xxxx',
                );
              },
            ),
          );
          print("路由返回值：$result");
        },
        child: const Text("打开提示页"),
      ),
    );
  }
}
