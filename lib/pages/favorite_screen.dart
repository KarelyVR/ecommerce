import 'package:ecommerce/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final finalList = provider.favorites;
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20,left: 20),
            child: Row(
              children: [
                Text(
                  "Favoritos",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: finalList.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(), 
                      children: [
                        SlidableAction(
                          onPressed: (context){
                            finalList.removeAt(index);
                            setState(() {});
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Borrar',
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        finalList[index].name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Text(
                        finalList[index].description,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(finalList[index].image),
                        backgroundColor: Colors.red.shade100,
                      ),
                      trailing: Text(
                        '\$${finalList[index].price}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      tileColor: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}