import 'package:ez_mooc/app/data/model/category_model.dart';
import 'package:ez_mooc/app/data/model/user_model.dart';
import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';

class Favorites {
  int id;
  User user;
  VdoDetail vdoDetail;

  Favorites({
    required this.id,
    required this.user,
    required this.vdoDetail,
  });

  factory Favorites.fromJson(Map<String, dynamic> json) {
    return Favorites(
      id: json['id'] ?? 0,
      user: User.fromJson(json['user'] ?? {}),
      vdoDetail: VdoDetail.fromJson(json['video'] ?? {}),
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'vdo_detail': vdoDetail.toJson(),
    };
  }
}
