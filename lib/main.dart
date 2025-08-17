import 'package:flutter/material.dart';
import 'package:verba/words/words.dart';
import 'dart:math';
import 'package:get_storage/get_storage.dart';

var randomItem;
final random = Random();

final savedWords = [];
final saved = GetStorage();
final stored = [];

final savedDefs = [];
final storedDefs = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  randomItem = random.nextInt(words.length);
  runApp(const HomePage());
}

void save() {
  List<dynamic> currentWords = saved.read<List>('words') ?? [];
  List<dynamic> currentDefs = saved.read<List>('definitions') ?? [];

  if (!currentWords.contains(randomItem)) {
    currentWords.add(randomItem);
    saved.write('words', currentWords);
    print('Saved words: $currentWords');
  }

  if (!currentDefs.contains(randomItem)) {
    currentDefs.add(randomItem);
    saved.write('definitions', currentDefs);
    print('Saved defs: $currentDefs');
  }
}

void shuffle() {
  randomItem = random.nextInt(words.length);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(245, 45, 62, 102),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 154, 150, 211),
        ),
      ),
      home: const MyHomePage(title: 'Word Of The Day!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void shuffle() {
    setState(() {
      randomItem = random.nextInt(words.length);
    });
  }

  void bookmark() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color.fromARGB(255, 99, 144, 186),
                    const Color.fromARGB(255, 158, 191, 222),
                  ],
                ),
              ),
              child: Text(
                "Verba",
                style: TextStyle(
                  fontFamily: 'Dongle',
                  fontSize: 50,
                  fontWeight: FontWeight.w100,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              words[randomItem],
              style: TextStyle(
                fontFamily: 'Dongle',
                fontSize: 60,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),

            Padding(padding: EdgeInsets.only(top: 20.0)),

            Expanded(
              child: Container(
                alignment: Alignment.center,

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      const Color.fromARGB(255, 69, 98, 128),
                      const Color.fromARGB(255, 139, 176, 210),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Text(
                      "Definition:",
                      style: TextStyle(
                        fontFamily: 'Dongle',
                        fontSize: 50,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),

                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 300),
                      child: Text(
                        definitions[randomItem],
                        style: TextStyle(
                          fontFamily: 'Dongle',
                          fontSize: 30,
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 30.0)),
                    Divider(
                      color: const Color.fromARGB(255, 108, 137, 163),
                      thickness: 3,
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),

                    SizedBox(
                      width: 200,
                      height: 50,

                      child: ElevatedButton(
                        onPressed: (shuffle),
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                        ),

                        child: Icon(
                          Icons.change_circle,
                          color: const Color.fromARGB(255, 109, 124, 225),
                          size: 50.0,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),

                    SizedBox(
                      width: 200,
                      height: 50,

                      child: ElevatedButton(
                        onPressed: (save),
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                        ),

                        child: Icon(
                          Icons.bookmark,
                          color: const Color.fromARGB(255, 109, 124, 225),
                          size: 50.0,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    SizedBox(
                      width: 200,
                      height: 100,

                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const savedPage(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Saved Words",
                              style: TextStyle(
                                fontFamily: 'Dongle',
                                fontSize: 30,
                                color: const Color.fromARGB(255, 109, 124, 225),
                              ),
                            ),

                            Icon(
                              Icons.book,
                              color: const Color.fromARGB(255, 109, 124, 225),
                              size: 50.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class savedPage extends StatefulWidget {
  const savedPage({super.key});

  @override
  State<savedPage> createState() => _savedPageState();
}

class _savedPageState extends State<savedPage> {
  List<int> savedWordIndices = [];
  List<int> savedDefinitionIndices = [];

  @override
  void initState() {
    super.initState();
    var stored = saved.read<List>('words');
    var storedDefs = saved.read<List>('definitions');
    if (stored != null && storedDefs != null) {
      savedWordIndices = stored.cast<int>();
      savedDefinitionIndices = storedDefs.cast<int>();
    }
    setState(() {}); // to refresh UI after loading
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),

                child: Icon(
                  Icons.arrow_back,
                  color: const Color.fromARGB(255, 109, 124, 225),
                  size: 50.0,
                ),
              ),

              Padding(padding: EdgeInsets.all(10)),
              Text(
                "Saved Words:",
                style: TextStyle(
                  fontFamily: 'Dongle',
                  fontSize: 70,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 20),
              itemCount: savedWordIndices.length,
              itemBuilder: (context, index) {
                int i = savedWordIndices[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        const Color.fromARGB(255, 69, 98, 128),
                        const Color.fromARGB(255, 139, 176, 210),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (stored != null) ...[
                        Text(
                          words[i],
                          style: TextStyle(
                            fontFamily: 'Dongle',
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),

                        Text(
                          definitions[i],
                          style: TextStyle(
                            fontFamily: 'Dongle',
                            fontSize: 22,
                            color: const Color.fromARGB(179, 236, 235, 241),
                          ),
                        ),
                      ] else ...[
                        Text(
                          "Nothing here... YET!!",
                          style: TextStyle(
                            fontFamily: 'Dongle',
                            fontSize: 22,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
