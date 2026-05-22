import 'package:flutter/material.dart';
import 'pages/lista_reservas_page.dart';

void main() {
  runApp(const ReservasApp());
}

class ReservasApp extends StatelessWidget {
  const ReservasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservas de Salas de Estudo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const ListaReservasPage(),
    );
  }
}