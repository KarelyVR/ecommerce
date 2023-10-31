import 'package:ecommerce/pages/envio_correo.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/pages/ticket.dart';

class TicketScreen extends StatelessWidget {
  final List<TicketItem> cartItems;
  final double precioTotal;
  final double precioTotalEnvio;
  final double costoEnvio;

  const TicketScreen({Key? key, required this.cartItems, required this.precioTotal})
      : costoEnvio = 100.00,
        precioTotalEnvio = precioTotal + 100.00,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket de compra'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cartItems[index].name),
            subtitle: Text(
                '\$${cartItems[index].price} x ${cartItems[index].quantity}'),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Subtotal: \$${precioTotal.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Costo envio: \$${costoEnvio.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Total: \$${precioTotalEnvio.toStringAsFixed(2)}', 
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SendMailFromLocalHost(
                      cartItems: cartItems, // Lista de elementos del carrito
                      totalPrice: precioTotalEnvio, // Precio total con envío
                      costoEnvio: costoEnvio, // Costo de envío
                      precioTotal: precioTotal, // Precio total
                    ),
                  ),
                );
              },
              child: const Text('Enviar ticket por correo'),
            )
          ],
        ),
      ),
    );
  }
}
