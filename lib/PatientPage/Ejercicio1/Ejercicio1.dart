import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loginpage/PatientPage/Ejercicio1/thermometropage.dart';
import 'package:loginpage/PatientPage/Homepagepatient.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Ejercicio1 extends StatefulWidget {
  const Ejercicio1({Key? key, required this.device}) : super(key: key);
  final BluetoothDevice device;

  @override
  State<Ejercicio1> createState() => _Ejercicio1State();
}

class _Ejercicio1State extends State<Ejercicio1> {
  final String SERVICE_UUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  final String CHARACTERISTIC_UUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  late bool isReady;
  late Stream<List<int>> stream;

  late Stream<DocumentSnapshot> _stream;
  bool showbutton = false;
  late final double _temp = 0;

  @override
  void initState() {
    super.initState();
    connectToDevice();

    Future.delayed(const Duration(seconds: 120), () {
      setState(() {
        showbutton = true;
      });
    });
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final currentuser = _auth.currentUser;

    // Establecer el stream para escuchar los cambios en el documento específico
    _stream = FirebaseFirestore.instance
        .collection('sensor')
        .doc(currentuser?.uid)
        .collection('Ejercicio')
        .doc('sensor')
        .snapshots();
  }

  connectToDevice() async {
    if (widget.device == null) {
      _pop();
      return;
    }

    Timer(const Duration(seconds: 10), () {
      if (!isReady) {
        disconnectFromDevice();
        _pop();
      }
    });

    await widget.device.connect();
    discorverServices();
  }

  disconnectFromDevice() {
    if (widget.device == null) {
      _pop();
      return;
    }

    widget.device.disconnect();
  }

  discorverServices() async {
    if (widget.device == null) {
      _pop();
      return;
    }

    List<BluetoothService> services = await widget.device.discoverServices();
    for (var service in services) {
      if (service.uuid.toString() == SERVICE_UUID) {
        for (var characteristics in service.characteristics) {
          if (characteristics.uuid.toString() == CHARACTERISTIC_UUID) {
            characteristics.setNotifyValue(!characteristics.isNotifying);
            stream = characteristics.value;

            setState(() {
              isReady = true;
            });
          }
        }
      }
    }

    if (!isReady) {
      _pop();
    }
  }

  _onWillPop() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Esta seguro?"),
              content: const Text("Quiere desconectar el dispositivo?"),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("No")),
                ElevatedButton(
                    onPressed: () {
                      disconnectFromDevice();
                      Navigator.of(context).pop(true);
                    },
                    child: const Text("Si")),
              ],
            ));
  }

  _pop() {
    Navigator.of(context).pop(true);
  }

  String _dataParse(dataFromDevice) {
    return utf8.decode(dataFromDevice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio'),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 50,
                width: 350,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 28,
                              color: Color.fromARGB(255, 1, 175, 152),
                              fontWeight: FontWeight.bold,
                            ),
                            child: AnimatedTextKit(
                              repeatForever: false,
                              totalRepeatCount: 4,
                              animatedTexts: [
                                FadeAnimatedText(
                                  'Presione el area pelvica',
                                  duration: const Duration(seconds: 15),
                                ),
                                FadeAnimatedText(
                                  'Relaje el area pelvica',
                                  duration: const Duration(seconds: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                child: SizedBox(
                  height: 350,
                  width: 90,
                  child: ThermometerStreamBuilder(stream: _stream),
                ),
              ),
              Container(
                  child: !isReady
                      ? const Center(child: Text("Esperando...."))
                      : Container(
                          child: StreamBuilder<List<int>>(
                            stream: stream,
                            builder: (BuildContext context,
                                AsyncSnapshot<List<int>> snapshot) {
                              if (snapshot.hasError) {
                                return Text("Error ${snapshot.error}");
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                var _currentvalue = _dataParse(snapshot.data);

                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Valor del sensor es:"),
                                      Text(_currentvalue),
                                    ],
                                  ),
                                );
                              } else {
                                return const Text("Revise Conexion");
                              }
                            },
                          ),
                        )),
              showbutton
                  ? Positioned(
                      bottom: 70,
                      child: ElevatedButton(
                        onPressed: () async {
                          final FirebaseAuth _auth = FirebaseAuth.instance;
                          final currentuser = _auth.currentUser;
                          final DateTime now = DateTime.now();
                          final String formatter = DateFormat.yMd().format(now);

                          final DocmentStream = FirebaseFirestore.instance
                              .collection('sensor')
                              .doc(currentuser?.uid)
                              .collection('Ejercicio')
                              .doc('sensor')
                              .collection('data')
                              .where('fechamax', isEqualTo: formatter)
                              .where('emg', isNotEqualTo: 1024)
                              .orderBy('emg', descending: true)
                              .limit(1)
                              .get()
                              .then((value) {
                            for (var element in value.docs) async {
                              DocumentReference anadevalmax =
                                  await FirebaseFirestore.instance
                                      .collection('sensor')
                                      .doc(currentuser?.uid)
                                      .collection('Ejercicio')
                                      .doc('sensor')
                                      .collection('valormax')
                                      .add({
                                'emg': element.data()['emg'],
                                'fecha': element.data()['fechamax']
                              });
                            }
                          });
                          DocumentReference stopej1 = FirebaseFirestore.instance
                              .collection('sensor')
                              .doc(currentuser?.uid)
                              .collection('Ejercicio')
                              .doc('sensor');
                          stopej1.update({
                            'STATUS': 'OFF',
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const TabBarPaciente()),
                          );
                        },
                        child: const Text('Finalizar'),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class ThermometerStreamBuilder extends StatelessWidget {
  final Stream<DocumentSnapshot> stream;

  const ThermometerStreamBuilder({Key? key, required this.stream})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Widget de carga mientras se espera la conexión
        }
        if (!snapshot.hasData || snapshot.data == null) {
          return const Text('No hay datos disponibles'); // Manejar caso sin datos
        }

        // Procesar y mostrar los datos obtenidos
        final newval = snapshot.data!['valor'];
        double _temp = newval;
        if (newval >= 100) {
          _temp = 80.0;
        }

        return ThermometerWidget(
          borderColor: Colors.red,
          innerColor: Colors.green,
          indicatorColor: Colors.red,
          temperature: (_temp * 100) / 80,
          height: 80,
        );
      },
    );
  }
}
