// ignore_for_file: avoid_print, prefer_const_constructors, unnecessary_null_comparison

import 'package:ecommerce/pages/ticket.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(SendMailFromLocalHost(totalPrice: 0.0, cartItems: const [], costoEnvio: 0.0, precioTotal: 0.0,));
}

class SendMailFromLocalHost extends StatefulWidget {
  const SendMailFromLocalHost({super.key,
    required this.cartItems,
    required this.totalPrice,
    required this.costoEnvio,
    required this.precioTotal,
  });

  final List<TicketItem> cartItems;
  final double totalPrice;
  final double costoEnvio;
  final double precioTotal;

  @override
  State<SendMailFromLocalHost> createState() => _SendMailFromLocalHostState();
}

class _SendMailFromLocalHostState extends State<SendMailFromLocalHost> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();

  sendMail() async {
    String username = 'CORREO'; //aqui se pone el correo del remitente 
    String password = 'CONTRASEÑA'; //aqui se pone la contraseña del remitente

    final smtpServer = gmail(username, password);

     final message = Message()
  ..from = Address(username, 'E-Commerce-App-Flutter')
  ..recipients.add(emailController.text) // Correo del destinatario 
  ..subject = 'Ticket de compra ${DateTime.now()}'
  ..text = 'Ticket de compra\n.'
  ..html = "<h2>Hola ${nameController.text},</h2>\n<p>Se le envía la siguiente información de su compra en la tienda online:</p>";

    // Verifica si son nulos y asigna valores predeterminados si es necesario
    final cartItems = widget.cartItems;
    final totalPrice = widget.totalPrice;

    String htmlContent = "";

    if (cartItems != null && totalPrice != null) {
      for (final item in cartItems) {
        htmlContent += "<p>${item.name}: \$${item.price} x ${item.quantity}</p>";
      }
      htmlContent += "<p>Subtotal: \$${widget.precioTotal.toStringAsFixed(2)}</p>";
      htmlContent += "<p>Costo de envío: \$${widget.costoEnvio.toStringAsFixed(2)}</p>";
      htmlContent += "<p>Total: \$${widget.totalPrice.toStringAsFixed(2)}</p>";
      htmlContent += "<p>En la siguiente dirección: ${direccionController.text}</p>";
    }
    // Concatenar el contenido adicional al contenido HTML existente
    message.html = message.html! + htmlContent;

    try {
      final sendReport = await send(message, smtpServer);
      Fluttertoast.showToast(
        msg: 'Mensaje enviado: $sendReport',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM, 
      );
    } on MailerException catch (e) {
      Fluttertoast.showToast(
        msg: 'Message not sent. ${e.toString()}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      for (var p in e.problems) {
        Fluttertoast.showToast(
          msg: 'Problem: ${p.code}: ${p.msg}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Enviar Ticket por Correo"),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: TextField(
                  controller: direccionController,
                  decoration: const InputDecoration(labelText: "Dirección de envío"),
                ),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  sendMail();
                  _showConfirmationDialog();
                },
                child: const Text('Enviar', 
                style: TextStyle(color: Colors.white)),
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