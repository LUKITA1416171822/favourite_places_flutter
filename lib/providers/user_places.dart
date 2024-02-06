import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import '../models/place.dart' ;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import '../models/place.dart';
Future<Database> _getDtabase() async {
  final dbPath= await sql.getDatabasesPath();
  final db= await sql.openDatabase((path.join(dbPath,'places.db')),onCreate:(db, version) {
    return db.execute('CREATE TABLE user_places( id Text Primary KEY, title TEXT , image TEXT)');

  },
    version: 1
    , );
  return db;
}


class UserPlacesNotifier extends StateNotifier<List<Place>>{
UserPlacesNotifier() :super(const []);

Future<void> loadPlaces() async {
  final db= await _getDtabase();
  final data= await db.query('user_places');
  data.map((row) => Place(title: row['title'] as String,image: File(row['image'] as String),id: row['id'] as String));
}



void addPlace(Place place ) async{
final appDir= await syspath.getApplicationDocumentsDirectory();
final filename= path.basename(place.image.path);
final copiedImage= await place.image.copy('${appDir.path}/$filename');
final db= await _getDtabase();
db.insert('user_places',{
  'id':place.id,
  'title':place.title,
  'image':place.image
});

state=[...state,place];
  
}


}
final userPlacesProvider =StateNotifierProvider<UserPlacesNotifier, List<Place>>((ref) =>
UserPlacesNotifier());