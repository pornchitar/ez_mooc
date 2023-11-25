import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/enrollment_controller.dart';

class EnrollmentView extends GetView<EnrollmentController> {
  const EnrollmentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EnrollmentView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EnrollmentView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
