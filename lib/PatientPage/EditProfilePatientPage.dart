import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key}) : super(key: key);

  @override
  State<EditNameFormPage> createState() => _EditNameFormPageState();
}

class _EditNameFormPageState extends State<EditNameFormPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final NombreController = TextEditingController();

  @override
  void dispose() {
    NombreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Nombre'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                width: 330,
                child: Text('Ingrese su Nombre completo',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(
                height: 6,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                    child: SizedBox(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Porfavor Ingrese su Nombre Completo';
                          } else {
                            return null;
                          }
                        },
                        decoration:
                            const InputDecoration(labelText: 'Nombre completo'),
                        controller: NombreController,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                    child: SizedBox(
                      height: 70,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () async {
                          final data = _auth.currentUser;
                          final editar = FirebaseFirestore.instance
                              .collection('Usuario')
                              .doc(data?.uid);
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              editar.update({'Nombre': NombreController.text});
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Guardar',
                            style: TextStyle(fontSize: 15)),
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}

class EditPhoneFormPage extends StatefulWidget {
  const EditPhoneFormPage({Key? key}) : super(key: key);

  @override
  State<EditPhoneFormPage> createState() => _EditPhoneFormPageState();
}

class _EditPhoneFormPageState extends State<EditPhoneFormPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TelefController = TextEditingController();

  @override
  void dispose() {
    TelefController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Telefono'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                width: 330,
                child: Text('Ingrese su Numero de Telefono',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(
                height: 6,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                    child: SizedBox(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Porfavor Ingrese numero de telefono';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(labelText: 'Telefono'),
                        controller: TelefController,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                    child: SizedBox(
                      height: 70,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () async {
                          final data = _auth.currentUser;
                          final editar = FirebaseFirestore.instance
                              .collection('Usuario')
                              .doc(data?.uid);
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              editar.update({'Telefono': TelefController.text});
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Guardar',
                            style: TextStyle(fontSize: 15)),
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}

class EditEmailFormPage extends StatefulWidget {
  const EditEmailFormPage({Key? key}) : super(key: key);

  @override
  State<EditEmailFormPage> createState() => _EditEmailFormPageState();
}

class _EditEmailFormPageState extends State<EditEmailFormPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Email'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                width: 330,
                child: Text('Ingrese su Email',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const SizedBox(
                height: 6,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                    child: SizedBox(
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Porfavor Ingrese su Email';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(labelText: 'Email'),
                        controller: emailController,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                    child: SizedBox(
                      height: 70,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          final data = _auth.currentUser;
                          final editar = FirebaseFirestore.instance
                              .collection('Usuario')
                              .doc(data?.uid);
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              editar.update({'Email': emailController.text});
                              data?.updateEmail(emailController.text);
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Guardar',
                            style: TextStyle(fontSize: 15)),
                      ),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}

class EditImagePage extends StatefulWidget {
  const EditImagePage({Key? key}) : super(key: key);

  @override
  State<EditImagePage> createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Imagen de perfil'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
              width: 330,
              child: Text(
                'Subir una foto',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              width: 330,
              child: GestureDetector(
                onTap: () async {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 330,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Guardar', style: TextStyle(fontSize: 15)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const DisplayImage(
      {Key? key, required this.imagePath, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Color.fromRGBO(64, 105, 225, 1);

    return Center(
      child: Stack(
        children: [
          buildImage(color),
          Positioned(
            child: buildEditIcon(color),
            right: 4,
            top: 10,
          ),
        ],
      ),
    );
  }

  Widget buildImage(Color color) {
    //final image= imagePath.contains('https://')
    //? NetworkImage(imagePath) : FileImage(File(imagePath));
    return CircleAvatar(
      radius: 75,
      backgroundColor: color,
      child: const CircleAvatar(
        // backgroundImage:
        radius: 70,
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
      all: 8,
      child: Icon(
        Icons.edit,
        color: color,
        size: 20,
      ));

  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: Colors.white,
          child: child,
        ),
      );
}
