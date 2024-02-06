import 'package:favourite_places/providers/user_places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/place.dart';
import '../screens/place_details.dart';

class Places extends ConsumerStatefulWidget{

  const Places({super.key});

  @override
  ConsumerState<Places> createState() {
return _placesState();
  }}
class _placesState extends ConsumerState<Places>{
  late Future<void> _placesFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _placesFuture=ref.read(userPlacesProvider.notifier).loadPlaces();
  }
  @override
  Widget build(BuildContext context) {
    Widget Content = Center(child:
    Text('No places added yet!!', style: Theme
        .of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(color: Colors.white),)
    );
   return placesList.isEmpty ? Content : ListView.builder(

     itemCount: placesList.length, itemBuilder: (ctx, index) =>
       ListTile(
         leading:CircleAvatar(
           radius: 26,
           backgroundImage: FileImage(placesList[index].image),
         ),
             title: Text(placesList[index].title),
     onTap: (){
       Navigator.of(context).push(MaterialPageRoute(builder:(ctx)=>PlaceScreen(place: placesList[index])));
     },)

   );
  }
}