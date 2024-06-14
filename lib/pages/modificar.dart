import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Modificar extends StatefulWidget {
  const Modificar({super.key});

  @override
  State<Modificar> createState() => _Modificar();
}

class _Modificar extends State<Modificar> {
  String _nombre = "";
  int _edad = 0;
  String _telefono = "";
  String _comida = "";

  @override
  void initState() {
    super.initState();
    _loadInfo();
  }

  Future<void> _loadInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nombre = prefs.getString('nombre') ?? "";
      _telefono = prefs.getString('telefono') ?? "";
      _comida = prefs.getString('comida') ?? "";
      _edad = prefs.getInt("edad") ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 37, 90),
        title: const Text("Pantalla con Valor",
            style: TextStyle(color: Colors.white)),
      ),
      body: Column(children: <Widget>[
        const Text("Modificar"),
        TextField(
          decoration: const InputDecoration(labelText: 'Nombre'),
          onChanged: (value) {
            setState(() {
              _nombre = value;
            });
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Edad'),
          onChanged: (value) {
            setState(() {
              _edad = int.parse(value);
            });
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Teléfono'),
          onChanged: (value) {
            setState(() {
              _telefono = value;
            });
          },
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Comida favorita'),
          onChanged: (value) {
            setState(() {
              _comida = value;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('nombre', _nombre);
                await prefs.setString('telefono', _telefono);
                await prefs.setString('comida', _comida);
                await prefs.setInt('edad', _edad);
                Navigator.pop(context);
              },
              child: const Text("Guardar"),
            ),
            ElevatedButton(
                child: const Text(
                  "Regresar",
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ]),
    );
  }
}
