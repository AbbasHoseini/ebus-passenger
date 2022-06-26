import 'package:ebus/core/models/Festival.dart';
import 'package:flutter/cupertino.dart';

class FestivalDetailViewModel with ChangeNotifier {
  List<dynamic> getImages(Festival festival) {
    List<dynamic> _images = <dynamic>[];
    for (String image in festival.images) {
      _images.add(NetworkImage(image));
    }
    return _images;
  }
}
