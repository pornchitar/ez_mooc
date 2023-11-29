import 'package:ez_mooc/app/data/model/vdo_detail_model.dart';
import 'package:get/get.dart';

class VdoDetailService extends GetxService {
  RxList<VdoDetail> vdoPlaylists = RxList<VdoDetail>.of([]).obs();

  //get vdoPlaylists
  List<VdoDetail> get getVdoPlaylists => vdoPlaylists.value;
  //set vdoPlaylists
  set setVdoPlaylists(List<VdoDetail> vdoPlaylists) =>
      this.vdoPlaylists.value = vdoPlaylists;
}
