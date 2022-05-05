//import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/PasswordMed.dart';
import 'package:loginpage/loginPage.dart';
import 'package:loginpage/homepageMed.dart';
import 'package:loginpage/profileMed.dart';
import 'package:loginpage/profileinfoMed.dart';

class MedicPage extends StatelessWidget {
  const MedicPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: 
      BottomBar(),
    );
  }
}

class BottomBar extends StatefulWidget {
  const BottomBar({ Key? key }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex= 0;
  final screens = const [
    homePage(),
    alertaMed(),
    MyproInfoMed(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedFontSize: 20,
        unselectedFontSize: 16,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Listas',
            backgroundColor: Colors.greenAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
            backgroundColor: Colors.lightGreenAccent,
          ),
        ],
      ),
    );
  }
}

