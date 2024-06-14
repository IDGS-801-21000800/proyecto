import 'package:flutter/material.dart';
import 'package:shared/pages/detalles.dart';
import 'package:shared/pages/login.dart';
import 'modificar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  String _nombre = "";
  int _edad = 0;
  bool _session = false;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _session = prefs.getBool('session') ?? false;
      _nombre = prefs.getString('nombre') ?? "";
      _edad = prefs.getInt("edad") ?? 0;
    });
  }

  Future<void> _saveData(String nombre, int edad) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('session', true);
    await prefs.setString('nombre', nombre);
    await prefs.setInt('edad', edad);
  }

  Future<void> _cleanData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('session');
    await prefs.remove('edad');
    await prefs.remove('nombre');

    setState(() {
      _session = false;
      _nombre = "";
      _edad = 0;
    });
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 350,
                height: 100,
                decoration: BoxDecoration(
                  color: _session ? Colors.green : Colors.amber,
                ),
                child: Column(
                  children: <Widget>[
                    Text(_nombre),
                    Text(_edad.toString()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center ,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Detalles()));
                          },
                          child: const Text("Detalles"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Modificar()));
                          },
                          child: const Text("Modificar"),
                        ),
                        ElevatedButton(
                          onPressed: _cleanData,
                          child: const Text("Salir"),
                        )
                      ],
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
