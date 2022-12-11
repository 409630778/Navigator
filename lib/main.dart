import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



const items = <String>["1","2","3","4","5","6","7","8"];
const icons = <String>['assets/1.png','assets/2.png','assets/3.png','assets/4.png','assets/5.png','assets/6.png','assets/7.png','assets/8.png'];
const w=<String>['a','b','c','d','e','f','g','h'];

final ValueNotifier<String> textWrapper = ValueNotifier('');

var listview=ListView.separated(
    itemCount: items.length,
    itemBuilder: (context, index) =>
        Card(
          child: ListTile(title: Text(items[index],style: TextStyle(fontSize: 20)),
            onTap:() {
              textWrapper.value = "點選" + items[index];
            },
            leading:Container(
              child: CircleAvatar(backgroundImage: AssetImage(icons[index],),),
              padding: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
            ),
            subtitle: Text(w[index],style: TextStyle(fontSize: 16),),
          ),),
    separatorBuilder: (context, index)=>Divider()
);


void main() {
  runApp(
    const MaterialApp(
      home: Page1(),
    ),
  );
}

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(_createRoute());
          },
          child: const Text('Go!'),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:listview
    );
  }
}
