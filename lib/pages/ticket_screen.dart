import 'package:ecommerce/pages/envio_correo.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/pages/ticket.dart';

class TicketScreen extends StatelessWidget {
  final List<TicketItem> cartItems;
  final double totalPrice;

  const TicketScreen({super.key, required this.cartItems, required this.totalPrice});

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
              'Total: \$${totalPrice.toStringAsFixed(2)}',
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
                    builder: (context) => const TicketForm(),
                  ),
                );
              },
              child: const Text('Ticket digital'),
            )
          ],
        ),
      ),
    );
  }
}
