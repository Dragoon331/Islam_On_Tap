// import 'dart:html';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:my_first_flutter_project/Qibla_Compass.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:Page1());
  }
}
class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Islam on Tap Home Screen'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (cpntext) => Page2()));
                    },
                    child: Text('Compass') ,
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(300, 100),
                      textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      elevation: 300,
                      shadowColor: Colors.blue,
                      side: BorderSide(color: Colors.black87,width: 1),
                    ),
                  ),
                ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (cpntext) => Page3()));
                    },
                    child: Text('Calendar') ,
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(300, 100),
                      textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      elevation: 300,
                      shadowColor: Colors.blue,
                      side: BorderSide(color: Colors.black87,width: 1),
                    ),
                  ),
                ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (cpntext) => Page4()));
                    },
                    child: Text('Alarm') ,
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(250, 100),
                      textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      elevation: 300,
                      shadowColor: Colors.blue,
                      side: BorderSide(color: Colors.black87,width: 1),
                    ),
                  ),
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);
  @override
  State<Page2> createState() => _Page2State();
  /**Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Page 2"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Home Screen') ,
        ),
      ),
    );
  }**/
}
class _Page2State extends State<Page2>{

  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();
    _fetchPermissions();
  }
  void _fetchPermissions(){
    Permission.locationWhenInUse.status.then((status) {
      if (mounted){
        setState(() {
          _hasPermissions = (status == PermissionStatus.granted);
        });
      }
    });

  }

  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Builder(
            builder: (context){
          if(_hasPermissions){
            return _buildCompass();
            }
          else{
            return _buildPermissionSheet();
            }
          }
        ),
      ),
    );
  }

  Widget _buildCompass(){
    return StreamBuilder<CompassEvent>(
        stream: FlutterCompass.events,
        builder: (context, snapshot){
          if (snapshot.hasError) {
            return Text('Error reading heading: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          double? direction = snapshot.data!.heading;

          // if direction is null, then device does not support this sensor
          // show error message
          if (direction == null) {
            return const Center(
              child: Text("Device does not have sensors !"),
            );
          }
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: AspectRatio(aspectRatio: 1, child: Image.asset('lib/Assets/cadrant.png',color: Colors.black, fit: BoxFit.cover),),
                ),
                ClipRRect(
                  borderRadius: new BorderRadius.circular(40.0),
                  child: Transform.rotate(
                      angle: (direction * (math.pi/ 180) * -1),
                  child: Image.asset('lib/Assets/compass.png', fit: BoxFit.cover),
                  ),
                ),
              ],
            ) ,//'lib/Assets/cadrant.png'
          );

    });
  }

  Widget _buildPermissionSheet(){
    return Center(
      child: ElevatedButton(
        child: const Text('Request Permission'),
        onPressed: (){
          Permission.locationWhenInUse.request().then((value) {
            _fetchPermissions();
          });
        },
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Page 3"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Home Screen') ,
        ),
      ),
    );
  }
}
class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Page 4"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Home Screen') ,
        ),
      ),
    );
  }
}



