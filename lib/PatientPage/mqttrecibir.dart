import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttClientEsp extends StatefulWidget {
  const MqttClientEsp({Key? key}) : super(key: key);

  @override
  State<MqttClientEsp> createState() => _MqttClientEspState();
}

class _MqttClientEspState extends State<MqttClientEsp> {
  bool isConnected = false;
  var pongCount = 0;
  final MqttServerClient client =
      MqttServerClient('a1tuvfuymkza4b-ats.iot.us-east-1.amazonaws.com', '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                isConnected = true;
                mqttConnect();
              },
              child: Text('Conectar')),
          ElevatedButton(
              onPressed: () {
                isConnected = false;
                client.disconnect();
              },
              child: Text('Desconectar')),
        ],
      ),
    );
  }

  Future<int> mqttConnect() async {
    ByteData rootCA = await rootBundle.load('assets/certs/AmazonRootCA1.pem');
    ByteData deviceCert =
        await rootBundle.load('assets/certs/DeviceCertificate.crt');
    ByteData privatekey = await rootBundle.load('assets/certs/Private.key');

    SecurityContext context = SecurityContext.defaultContext;
    context.setClientAuthoritiesBytes(rootCA.buffer.asUint8List());
    context.useCertificateChainBytes(deviceCert.buffer.asUint8List());
    context.usePrivateKeyBytes(privatekey.buffer.asUint8List());

    client.securityContext = context;
    client.logging(on: true);
    client.keepAlivePeriod = 20;
    client.port = 8883;
    client.secure = true;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.pongCallback = pong;

    final MqttConnectMessage conMess =
        MqttConnectMessage().withClientIdentifier('').startClean();
    client.connectionMessage = conMess;
    print('Example client connecting.....');

    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      print('Example: no exitoso');
      client.disconnect();
    } on SocketException catch (e) {
      print('socket exception');
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('Conexion fue exitosa');
    } else {
      print('error en conexxion mqtt');
      client.disconnect();
      exit(-1);
    }

    const topic = 'esp8266/pub';
    client.subscribe(topic, MqttQos.atMostOnce);

    client.published!.listen((MqttPublishMessage message) {
      print(
          'Example topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
    });

    return 0;
  }

  void onConnected() {
    print('Example is coneccted exitoso');
  }

  void onDisconnected() {
    print('Exaple disconeected');
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print('Callback unsolicited or none');
    }
    if (pongCount == 3) {
      print('Pong count is correct');
    } else {
      print('Exaple pong count is incorrect');
    }
  }

  void pong() {
    print('ping response callback invoked');
    pongCount++;
  }
}
