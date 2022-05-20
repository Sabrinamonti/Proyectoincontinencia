import 'package:flutter/material.dart';
import 'package:loginpage/MedicPage/EditprofileMed.dart';
import 'package:loginpage/MedicPage/homepageMed.dart';

class MyproInfoMed extends StatefulWidget {
  const MyproInfoMed({ Key? key }) : super(key: key);

  @override
  State<MyproInfoMed> createState() => _MyproInfoMedState();
}

class _MyproInfoMedState extends State<MyproInfoMed> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: BackButton( 
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const homePage()),
            );
          },
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, 
            MaterialPageRoute(builder: (context) => const MyprofileMed()),
            );
          }, 
            icon: const Icon(Icons.edit)
          ),
        ],
      ),
      body: 
       Stack(
         alignment: Alignment.center,
         children: [
           Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [ const
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Perfil', style: TextStyle(
                        fontSize: 35, 
                        letterSpacing: 1.5, 
                        color: Colors.black38,
                        fontWeight: FontWeight.w600,
                      ),),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width/2,
                      height: MediaQuery.of(context).size.width/2,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                         image: AssetImage('assets/imageninicio/imageninicio.jpg'),
                        ),
                      ),
                    ),
                 ],
               ),
               Container(
                 height: 370,
                 width: double.infinity,
                 margin: EdgeInsets.symmetric(horizontal: 10),
                 padding: EdgeInsets.only(top: 30, bottom: 25),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     ShowName(),
                     ShowTelef(),
                     ShowUserType(),
                   ],
                 ),
                ),
             ],
           )
         ],
       )
    );
  }
}

Widget ShowName() {
    return Container(
      padding: const EdgeInsets.only(top: 3, bottom: 15),
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black
        ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        new BoxShadow(
          color: Colors.grey,
          offset: new Offset(2, 2),
        ),
      ]),
      child: Row(
        children: [
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 1, bottom: 8),
                child: const Text('Nombre Completo'),
              ),
              const Text('Sabrina Montaño', 
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
              ),)
            ],
          ))
        ],
      )
    );
  }

  Widget ShowTelef() {
    return Container(
      padding: const EdgeInsets.only(top: 3, bottom: 15),
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black
        ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        new BoxShadow(
          color: Colors.grey,
          offset: new Offset(2, 2),
        ),
      ]),
      child: Row(
        children: [
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 1, bottom: 8),
                child: const Text('Telefono'),
              ),
              const Text('72224048', 
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
              ),)
            ],
          ))
        ],
      )
    );
  }

  Widget ShowUserType() {
    return Container(
      padding: const EdgeInsets.only(top: 3, bottom: 15),
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black
        ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        new BoxShadow(
          color: Colors.grey,
          offset: new Offset(2, 2),
        ),
      ]),
      child: Row(
        children: [
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 1, bottom: 8),
                child: const Text('Tipo de Usuario'),
              ),
              const Text('Medico', 
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
              ),)
            ],
          ))
        ],
      )
    );
  }


