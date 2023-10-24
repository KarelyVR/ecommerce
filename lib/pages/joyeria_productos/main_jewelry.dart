import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/pages/joyeria_productos/jewelry_bloc.dart';


class Joyeria extends StatelessWidget {
  const Joyeria({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => JewelryBloc()..add(FetchJewelryEvent()),
        child: const JewelryList(),
      ),
    );
  }
}

class JewelryList extends StatelessWidget {
  const JewelryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JewelryBloc, JewelryState>(
      builder: (context, state) {
        if (state is JewelryInitialState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is JewelryLoadSuccessState) {
          final jewelry = state.jewelry;
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
          return const Center(child: Text('Error al cargar la joyería'));
        }
      },
    );
  }
}
