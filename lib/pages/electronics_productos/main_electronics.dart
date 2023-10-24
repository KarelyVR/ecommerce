import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/pages/electronics_productos/electronics_bloc.dart';

class Electronics extends StatelessWidget {
  const Electronics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<ElectronicsBloc>(
        create: (context) => ElectronicsBloc()..add(FetchElectronicsEvent()),
        child: const ElectronicsList(),
      ),
    );
  }
}

class ElectronicsList extends StatelessWidget {
  const ElectronicsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElectronicsBloc, ElectronicsState>(
      builder: (context, state) {
        if (state is ElectronicsInitialState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ElectronicsLoadSuccessState) {
          final electronics = state.electronics;
          return ListView.builder(
            itemCount: electronics.length,
            itemBuilder: (context, index) {
              final item = electronics[index];
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
