import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_controller.dart';
import 'package:app_coleta_lixo/colors.dart';
import 'package:flutter/material.dart';

import 'custom_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';

  Future<bool> _onWillPop() async {
    return false;
  }

  Widget _body() {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: AnimatedBuilder(
        animation: AppController.instance,
        builder: (context, child) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              //Padding da Página de login
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SafeArea(
                child: ScrollConfiguration(
                  behavior: ScrollRemove(),
                  child: ListView(
                    children: [
                      Container(
                        height: 30,
                      ),
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: SvgPicture.asset('assets/images/logo.svg'),
                      ),
                      Container(
                        height: 70,
                      ),

                      Column(
                        children: [
                          //Campo de texto para o email
                          TextField(
                            onChanged: (text) {
                              email = text;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Usuário',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                            ),
                          ),
                          const SizedBox(height: 10),

                          //Campo de texto para a senha
                          TextField(
                            onChanged: (text) {
                              password = text;
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Senha',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              //Não faço ideia o porquê de esse Flexible estar nos botoes de usuario e cadastro e não lembro porque coloquei ele, só sei que sem ele o aplicativo NÃO RODA
                              //Creio eu que seja pra nao dar erro e ele expandir os botoes quando o aplicativo estiver em orientação em paisagem
                              Flexible(
                                //Botão pressionável de "Entrar"
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0.0,
                                        minimumSize: const Size.fromHeight(50),
                                        shadowColor: Colors.transparent),
                                    //Navegação entre telas
                                    onPressed: () {
                                      if (password != '123' || email != '123') {
                                        _showSignInAlert();
                                      } else {
                                        Navigator.of(context)
                                            .pushNamed('/home');
                                      }
                                    },
                                    child: const Text(
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Roboto'),
                                        'Entrar')),
                              ),
                            ],
                          ),
                          Container(
                            height: 10,
                          ),
                          Row(
                            children: [
                              //Mesma coisa do Flexible do botão de login
                              Flexible(
                                //Botão pressionável de "Cadastrar"
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 2,
                                    shadowColor: const Color.fromARGB(
                                        216, 255, 255, 255),
                                    //If-else pra trocar a cor do botão "Cadastrar" para
                                    //deixar adaptável ao Dark Mode.
                                    backgroundColor:
                                        AppController.instance.isDarkTheme
                                            ? MyColors.grayScale
                                            : Colors.white,
                                    minimumSize: const Size.fromHeight(50),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/signup');
                                  },
                                  child: Text(
                                    'Cadastrar',
                                    style: TextStyle(

                                        //If-else pra trocar a cor do texto do botão de
                                        //"Cadastrar" para deixar mais visível no Dark Mode.
                                        color:
                                            AppController.instance.isDarkTheme
                                                ? MyColors.primary[300]
                                                : MyColors.primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Roboto'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(height: 30),
                      //Linha divisória de widget criada para as logos das redes sociais
                      const Row(
                        children: [
                          Flexible(
                            child: Divider(color: Colors.black),
                          ),
                          Text(
                            'OU',
                            style: TextStyle(
                                color: MyColors.grayScale,
                                fontSize: 16,
                                fontFamily: 'Roboto'),
                          ),
                          Flexible(
                            child: Divider(color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        height: 10,
                      ),

                      //Lista em linha criada para criar os
                      //botões pressionáveis de login com redes sociais.
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            iconSize: 50,
                            icon: SvgPicture.asset(
                                'assets/images/google_logo.svg'),
                          ),
                          IconButton(
                            onPressed: () {},
                            iconSize: 50,
                            icon: SvgPicture.asset(
                                'assets/images/instagram_logo.svg'),
                          ),
                          IconButton(
                            onPressed: () {},
                            iconSize: 50,
                            icon: SvgPicture.asset(
                                'assets/images/facebook_logo.svg'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

//Construção de widget próprio muito útil para referenciar o corpo principal da página.
//Pode ser também utilizado para equipe adicionar um background na tela de login no futuro.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          _body(),
        ],
      ),
    ));
  }

//Área de funções
  void _showSignInAlert() {
    showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        animationType: DialogTransitionType.sizeFade,
        duration: const Duration(milliseconds: 200),
        builder: (context) {
          return ClassicGeneralDialogWidget(
            contentText:
                'Senha ou email incorreto! \nVerifique suas credenciais',
            positiveText: 'Fechar',
            onPositiveClick: () {
              Navigator.pop(context);
            },
            positiveTextStyle: const TextStyle(color: MyColors.primary),
          );
        });
  }
}
