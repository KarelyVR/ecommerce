import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/pages/electronics_productos/electronics_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Electronics(),
    );
  }
}

class Electronics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo los electrónicos'),
      ),
      body: BlocProvider(
        create: (context) => ElectronicsBloc()..add(FetchElectronicsEvent()),
        child: ElectronicsList(),
      ),
    );
  }
}

class ElectronicsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElectronicsBloc, ElectronicsState>(
      builder: (context, state) {
        if (state is ElectronicsInitialState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ElectronicsLoadSuccessState) {
          final jewelry = state.electronics;
          return ListView.builder(
            itemCount: jewelry.length,
            itemBuilder: (context, index) {
              final item = jewelry[index];
              return ListTile(
                title: Text(item.title),
                subtitle: Text("\$${item.price.toStringAsFixed(2)}"),
                leading: Image.network(item.image),
              );
            },
          );
        } else {
          return const Center(child: Text('Error al cargar los electronicos'));
        }
      },
    );
  }
}
