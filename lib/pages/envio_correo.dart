import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TicketForm(),
    );
  }
}

class TicketForm extends StatefulWidget {
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
        title: Text("Formulario"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Nombre y Apellidos"),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Correo Electrónico"),
              ),
            ),
            Row(
              children: <Widget>[
                Text("¿Necesita factura?"),
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
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog();
              },
              child: Text("Enviar"),
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
          title: Text("Envío exitoso"),
          content: Text("El ticket se ha enviado exitosamente."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cerrar"),
            ),
          ],
        );
      },
    );
  }
}
