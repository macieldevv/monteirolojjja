import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:monteirolojjja/checagem_page.dart';
class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastra-se'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    label: Text('Nome Completo')
                  ),
                  validator: (nome){
                    if(nome == null || nome.isEmpty){
                      return 'Digite seu nome completo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    label: Text('E-mail')
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
                  decoration: InputDecoration(
                    label: Text('Senha')
                  ),
                  validator: (senha){
                    if(senha == null || senha.isEmpty){
                      return 'Digite sua senha';
                    }else if (senha.length < 6){
                      return 'Digite uma senha mais forte';
                    }
                    return null;
                  },
                ),
                ElevatedButton(onPressed: (){
                  cadastrar();
                  if(_formKey.currentState!.validate()){

                  }
                },
                  child: Text('Cadastrar-se'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  cadastrar() async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
               email: _emailController.text, password: _passwordController.text);
      if (userCredential != null){
        userCredential.user!.updateDisplayName(_nomeController.text);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ChecagemPage(),
            ),
                (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if(e.code == 'weak-password'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Crie uma senha mais forte.'),
            backgroundColor: Colors.redAccent,
          )
        );
      }else if(e.code == 'email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Este e-mail já foi cadastrado'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

}
