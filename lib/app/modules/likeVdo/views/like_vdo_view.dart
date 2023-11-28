import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/like_vdo_controller.dart';

class LikeVdoView extends GetView<LikeVdoController> {
  const LikeVdoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LikeVdoView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LikeVdoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
