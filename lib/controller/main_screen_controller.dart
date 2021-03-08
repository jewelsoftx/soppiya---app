import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class MainScreenController extends GetxController with SingleGetTickerProviderMixin{


  var selectedItemTitle = "Home".obs;



  AnimationController animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final animationDuration = const Duration(milliseconds: 500);



  @override
  void onInit() {
    animationController = AnimationController( duration: animationDuration, vsync: this);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
    super.onInit();
  }



  @override
  void dispose() {
    animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      animationController.forward();
    }
  }




}