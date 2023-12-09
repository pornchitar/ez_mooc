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
      id: json['id'],
      user: User.fromJson(json['user']),
      vdoDetail: VdoDetail.fromJson(json['vdo_detail']),
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
