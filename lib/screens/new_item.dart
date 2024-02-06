import 'package:favourite_places/dummy_data.dart';
import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/widgets/image_input.dart';
import 'package:favourite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import '../models/place.dart';

class NewItem extends ConsumerStatefulWidget{
  @override
  ConsumerState<NewItem> createState() => _NewItemState();
}

class _NewItemState extends ConsumerState<NewItem> {
  var _enteredName='';
File? _selectedImage;
  final _formKey=GlobalKey<FormState>();

  void _saveItem (){
    if(_formKey.currentState!.validate() || _selectedImage!=null) {
      _formKey.currentState!.save();
     ref.watch(userPlacesProvider.notifier).addPlace(Place(title:_enteredName,image: _selectedImage!));
      Navigator.of(context).pop();}

  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Add a new Place',style: Theme.of(context).textTheme.titleLarge),
     ),
  body: Form(key: _formKey,
      child: SingleChildScrollView(padding:EdgeInsets.all(16) ,
        child: Column(
          children:[ TextFormField(style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
           maxLength: 50,
           decoration: const InputDecoration(
             label: Text('Title')
           ),validator:(value,){
            if(value==null || value.isEmpty || value.trim().length<=1|| value.trim().length>50) {
              return 'Must be between 1 and 50 characters';
            }
            return null;
          },
    onSaved: (value){

     _enteredName=value!;}
          ),
            const SizedBox(height: 16),
            ImageInput(onPickImage: (image) {
              _selectedImage=image;
            },),
    const SizedBox(height: 16),
            const SizedBox(height: 16),
            LocationInput(),
            ElevatedButton.icon(
            onPressed: () {
              _saveItem();
            },
            icon: Icon(Icons.add), // The add sign
            label: Text('Add Place'), // The text
          ) ],
        ),
      )
  ), );
  }
}