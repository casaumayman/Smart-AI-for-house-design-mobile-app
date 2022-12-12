import 'dart:convert';

import 'package:change_house_colors/constants/network_constants.dart';
import 'package:change_house_colors/shared/models/process_image_req.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketService extends GetxService {
  Socket socket = io(
      networkHost.toString(),
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build());

  final isConnected = false.obs;

  @override
  void onInit() {
    socket.onConnect((_) {
      debugPrint('Connected');
      isConnected.value = true;
    });
    socket.onDisconnect((_) {
      debugPrint('Disconnected');
      isConnected.value = false;
    });
    socket.onConnectTimeout((data) {
      debugPrint("Connect timeout!");
      isConnected.value = false;
    });
    socket.onConnectError((err) {
      debugPrint("Connect error: $err");
      isConnected.value = false;
    });
    super.onInit();
  }

  void connect() {
    if (isConnected.value) {
      return;
    }
    socket.connect();
  }

  void disconnect() {
    if (!isConnected.value) {
      return;
    }
    socket.disconnect();
  }

  void onReceive(Function(String) handler) {
    socket.on(eventName, (data) {
      handler(data);
    });
  }

  bool _emit(String data) {
    if (!isConnected.value) {
      return false;
    }
    socket.emit(eventName, data);
    return true;
  }

  bool requestProcess(ProcessImageRequest request) {
    String json = jsonEncode(request);
    debugPrint('send image');
    return _emit(json);
  }

  @override
  void onClose() {
    if (isConnected.value) {
      socket.close();
    }
    super.onClose();
  }
}
