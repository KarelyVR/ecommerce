// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TicketForm(),
//     );
//   }
// }

class TicketForm extends StatefulWidget {
  const TicketForm({super.key});

  @override
  _TicketFormState createState() => _TicketFormState();
}

class _TicketFormState extends State<TicketForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool needsInvoice = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulario"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Nombre y Apellidos"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Correo Electrónico"),
              ),
            ),
            Row(
              children: <Widget>[
                const Text("¿Necesita factura?"),
                Switch(
                  value: needsInvoice,
                  onChanged: (value) {
                    setState(() {
                      needsInvoice = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog();
              },
              child: const Text("Enviar"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Envío exitoso"),
          content: const Text("El ticket se ha enviado exitosamente."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cerrar"),
            ),
          ],
        );
      },
    );
  }
}
