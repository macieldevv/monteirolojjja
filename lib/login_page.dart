import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:monteirolojjja/home_page.dart';

import 'cadastro_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;
  bool _verSenha = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    label: Text('e-mail'),
                    hintText: 'nome@gmail.com'
                  ),
                  validator: (email){
                    if(email == null || email.isEmpty){
                      return 'Digite seu e-mail';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_verSenha,
                  decoration: InputDecoration(
                    label: Text('senha'),
                    hintText: 'Digite sua senha',
                    suffixIcon: IconButton(
                      icon: Icon(_verSenha ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined),
                      onPressed: () {
                        setState(() {
                          _verSenha = !_verSenha;
                        });
                      },
                    )
                  ),
                  validator: (senha){
                    if(senha == null || senha.isEmpty){
                      return 'digite sua senha';
                    } else if (senha.length < 6){
                      return 'Digite uma senha mais forte';
                    }
                    return null;
                  },
                ),
                Align( alignment: Alignment.centerRight,
                  child: TextButton( onPressed: () {},
                  child: const Text('Esqueci minha senha'), ), ),
                const SizedBox( height: 12, ),

                ElevatedButton(onPressed: (){
                  login();
                  if(_formKey.currentState!.validate()){

                  }
                },
                    child: Text(
                        'ENTRAR'
                    ),
                ),
                TextButton(onPressed: (){
                  Navigator.push(
                      context,
                    MaterialPageRoute(builder: (context) => CadastroPage(),
                    ),
                  );
                },
                    child: Text('Criar Conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  login() async {
    try{
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text
          );
      if (userCredential != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage()
            ),
        );
      }
    } on FirebaseAuthException catch (e){
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Usuario não cadastrado'),
            backgroundColor:  Colors.redAccent,
          ),
        );
      }else if (e.code == 'wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Sua senha está errada'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}



