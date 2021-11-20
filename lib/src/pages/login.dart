import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:practica_1_180012/src/models/clientModel.dart';
import 'package:practica_1_180012/src/states/login_state.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final usr = new Client();
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Consumer<LoginState>(
          builder: (BuildContext context, LoginState value, Widget child) {
            if (value.isLoading()) {
              return CircularProgressIndicator();
            } else {
              return Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://i.pinimg.com/736x/57/64/48/5764486ed4717e16b3ec11ecc1a9a0d8.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                        height: _screenSize.height * 0.7, child: child),
                  )
                ],
              );
            }
          },
          child: Column(children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 15,
              color: Colors.white,
              margin: EdgeInsets.all(18),
              child: Column(
                children: <Widget>[
                  Container(
                      child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(8),
                          height: 100,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                'https://i.pinimg.com/originals/00/ec/0c/00ec0c0007f680fa547dc0db7e8be401.png',
                                fit: BoxFit.cover,
                              ))),
                      Text(
                        'Car Wash',
                        style: TextStyle(
                            fontSize: 22, fontStyle: FontStyle.italic),
                      ),
                    ],
                  )),
                  _formulario(),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'Registrar'),
                    child: Text(
                      "Regitrarse",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  _formulario() {
    return Container(
      padding: EdgeInsets.all(25),
      child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              _email(),
              _pass(),
              _botonlogin(),
            ],
          )),
    );
  }

  _email() {
    return TextFormField(
      onSaved: (email) => usr.clEmail = email,
      decoration: InputDecoration(labelText: 'Usuario'),
      validator: (text) {
        return !EmailValidator.validate(text) ? 'Verifica el mail' : null;
      },
    );
  }

  _pass() {
    return TextFormField(
      obscureText: true,
      onSaved: (pwd) => usr.clPassword = pwd,
      decoration: InputDecoration(labelText: 'Password'),
      validator: (text) {
        return text.isEmpty || text.length < 0
            ? 'Verifica tu contraseña'
            : null;
      },
    );
  }

  _botonlogin() {
    return RaisedButton.icon(
      shape: StadiumBorder(),
      color: Colors.lightBlue,
      onPressed: () {
        _submit();
      },
      icon: Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
      ),
      label: Text(
        'Login ',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    Provider.of<LoginState>(context, listen: false)
        .login(email: usr.clEmail, contrasenia: usr.clPassword);
  }
}
