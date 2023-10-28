import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sample/bmi/bmipage.dart';


class BmiMain extends StatelessWidget {
  const BmiMain({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: BmiHomePage(),
      // routes: <String, WidgetBuilder>{
      //   '/': (context) => HomePage(),
      //   '/second': (context) => SecondApp()
      // },
    );
  }
}

class BmiHomePage extends StatefulWidget {

  @override
  _BmiPageState createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiHomePage> {
  // final _textControler = new TextEditingController();

  // @override
  // void dispose() {
  //   _textControler.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BmiPage()
    );
  }
}


