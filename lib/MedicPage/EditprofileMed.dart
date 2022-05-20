import 'package:flutter/material.dart';
import 'package:loginpage/MedicPage/homepageMed.dart';
import 'package:loginpage/MedicPage/profileinfoMed.dart';

class MyprofileMed extends StatefulWidget {
  const MyprofileMed({ Key? key }) : super(key: key);

  @override
  State<MyprofileMed> createState() => _MyprofileMedState();
}

class _MyprofileMedState extends State<MyprofileMed> {

  Widget textfield({required String hinttext}){
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle:const TextStyle(
            letterSpacing: 2,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          fillColor: Colors.white30,
          filled: true,
    
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          )
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 70, 182, 148),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff555555),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const MyproInfoMed())
            );
          }, 
          icon: Icon(Icons.arrow_back)
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 450,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textfield(hinttext: 'Nombre de Usuario'),
                    textfield(hinttext: 'Telefono'),
                    textfield(hinttext: 'Contraseña'),
                    textfield(hinttext: 'Confirm'),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white38),
                        textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      onPressed: () {
                        Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => const homePage()),
                        );
                      }, 
                      child: const Text('Guardar'))
                  ],
                ),
              ),
            ],
          ),
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text('Perfil', style: TextStyle(
                  fontSize: 35, 
                  letterSpacing: 1.5, 
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),),
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width/2,
                height: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('imageninicio.jpg'),
                  ),
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 270, left: 184),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            child: IconButton(
              icon: Icon(Icons.edit, 
              color: Colors.white
              ),
              onPressed: () {},
            ),
          ),
          ),
        ], 
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {

  @override
  void paint (Canvas canvas, Size size) {
    Paint paint = Paint()..color=Color(0xff555555);
    Path path = Path()
    ..relativeLineTo(0, 150)
    ..quadraticBezierTo(size.width/2, 255, size.width, 150)
    ..relativeLineTo(0, -150)
    ..close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}