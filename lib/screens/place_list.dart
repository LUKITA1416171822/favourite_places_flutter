import 'dart:html';

import 'package:favourite_places/dummy_data.dart';
import 'package:favourite_places/models/place.dart';
import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/widgets/places.dart';
import 'package:flutter/material.dart';
import 'package:favourite_places/screens/place_details.dart';
import 'new_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class PlacesScreen extends ConsumerWidget{
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final placesList=ref.watch(userPlacesProvider);
    _addItem () async{
     final newItem= await Navigator.of(context).push<Place>(MaterialPageRoute(builder: (ctx)=>NewItem()));
    if(newItem!=null) {

    }
    print(newItem?.title);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Your  places', style: Theme
              .of(context)
              .textTheme
              .titleLarge),
          actions: [
            IconButton(onPressed: () {
              _addItem();
            }, icon: const Icon(Icons.add))
          ],
        ),
        body:
         Padding (padding: const EdgeInsets.all(8.0),

             child: FutureBuilder (future: ,builder: (context, snapshot) =>snapshot.connectionState==ConnectionState.waiting?const Center(child: CircularProgressIndicator()) : Places(placesList: placesList,)))
    );
  }
}