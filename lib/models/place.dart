import 'package:uuid/uuid.dart';
import 'dart:io';
final uuid= const Uuid();
class Place{
  Place({required this.title,required this.image, String? id}) :  id=id??uuid.v4() ;
  String id;
  String title;
  final File image;
}