import 'package:change_house_colors/constants/socket_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketService extends GetxService {
  Socket socket = io(
      socketHost,
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build());

  bool isConnected = false;

  @override
  void onInit() {
    socket.onConnect((_) {
      debugPrint('Connected');
      isConnected = true;
    });
    socket.onDisconnect((_) {
      debugPrint('Disconnected');
      isConnected = false;
    });
    socket.onConnectTimeout((data) {
      debugPrint("Connect timeout!");
      isConnected = false;
    });
    socket.onConnectError((err) {
      debugPrint("Connect error: $err");
      isConnected = false;
    });
    super.onInit();
  }

  void connect() {
    socket.connect();
  }

  void disconnect() {
    socket.disconnect();
  }

  void onReceive(Function(String) handler) {
    socket.on(eventName, (data) {
      handler(data);
    });
  }

  void emit(String data) {
    if (!isConnected) {
      return;
    }
    socket.emit(eventName, data);
  }

  @override
  void onClose() {
    if (isConnected) {
      socket.close();
    }
    super.onClose();
  }
}
