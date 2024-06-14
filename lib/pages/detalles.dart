import 'package:flutter/material.dart';
import 'package:shared/pages/modificar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detalles extends StatefulWidget {
  const Detalles({super.key});

  @override
  State<Detalles> createState() => _DetallesState();
}

class _DetallesState extends State<Detalles> {
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
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Detalles"),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text("Nombre: $_nombre"),
              Text("Teléfono: $_telefono"),
              Text("Comida favorita: $_comida"),
              Text("Edad: ${_edad.toString()}"),
              Row(
                children: [
                  ElevatedButton(
                      child: const Text(
                        "Modificar",
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Modificar()));
                      }),
                  ElevatedButton(
                      child: const Text(
                        "Regresar",
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              )
            ])));
  }
}
