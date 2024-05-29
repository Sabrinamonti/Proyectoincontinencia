import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/TecnicoPage/EdituserPage.dart';
import 'package:loginpage/backend/Adminusuarioslist.dart';
import 'package:loginpage/loginPage.dart';

class TecnicoPage extends StatefulWidget {
  const TecnicoPage({Key? key}) : super(key: key);

  @override
  State<TecnicoPage> createState() => _TecnicoPageState();
}

class _TecnicoPageState extends State<TecnicoPage> {
  final TextEditingController? _textEditingController = TextEditingController();
  List Usuarioslista = [];
  final _auth = FirebaseAuth.instance.currentUser;
  List items = [];
  List datosusuarios = [];
  var idusuario;
  var emailuser;
  var passuser;

  @override
  void initState() {
    super.initState();
    fetchdatabaselist();
  }

  fetchdatabaselist() async {
    dynamic resultant = await AdminUsuarios().getUsers();
    if (resultant == null) {
      print('No se puede obtener ls informacion');
    } else {
      setState(() {
        items = resultant;
        datosusuarios = items;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Bienvenido'),
            backgroundColor: Colors.blue,
            leading: ElevatedButton(
              child: const Icon(Icons.logout),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            )),
        body: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Buscar el Nombre del Usuario',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(29)))),
              onChanged: (value) {
                setState(() {
                  datosusuarios = items
                      .where((element) => element
                          .toString()
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
                //filterUsers = usuarioslista;
              },
              controller: _textEditingController,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _textEditingController!.text.isNotEmpty
                      ? datosusuarios.length
                      : items.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text(datosusuarios[index]['Nombre'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text(datosusuarios[index]['TipoUsuario']),
                        trailing: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              idusuario = datosusuarios[index]['Id'];
                              emailuser = datosusuarios[index]['Email'];
                              passuser = datosusuarios[index]['Contrasena'];
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => Editpage(
                                        value: idusuario,
                                        email: emailuser,
                                        pass: passuser))));
                            FirebaseAuth.instance.signOut();
                            FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: emailuser, password: passuser);
                          },
                          child: const Icon(Icons.edit),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
