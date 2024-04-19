import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  bool _obscureText = true;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    // Suscribirse a los cambios de visibilidad del teclado
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        _isKeyboardVisible = visible;
      });
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 20,
              top: 10,
              child: Image.asset('assets/images/logo.png', height: 60, width: 60,
              alignment: Alignment.centerLeft,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Iniciar Sesión',
                        style: TextStyle(
                          color: Color(0xFF2A2A2A),
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 42),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/google_logo.png',
                          height: 23,
                          width: 23,
                        ),
                        label:
                        Text(
                            'Inicia sesión con Google',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins'
                          )
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xFF2A2A2A),
                          backgroundColor: Colors.white,
                          alignment: Alignment.centerLeft,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xFFC8C8C8)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'O ingresa con tu correo electrónico',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Color(0xFFC8C8C8),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFC8C8C8)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        ),

                      ),
                      SizedBox(height: 15),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextField(
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              hintText: 'Contraseña',
                              hintStyle: TextStyle(
                                color: Color(0xFFC8C8C8),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFC8C8C8)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print('Olvidé mi contraseña');
                            },
                            child: Text(
                              'Olvidé mi contraseña',
                              style: TextStyle(
                                color: Color(0xFF262626),
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Continuar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF762B2B),
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ]
                  )
                ),
              ),
            ),
            Positioned(
              bottom: _isKeyboardVisible ? -40 : 20,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  print("Crear cuenta");
                },
                child: Container(
                  alignment: Alignment.center, // Centra el contenido horizontalmente
                  child: Text.rich(
                    TextSpan(
                      text: '¿No tienes una cuenta? ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF2A2A2A),
                        fontFamily: 'Poppins',
                      ),
                      children: [
                        TextSpan(
                          text: 'Crear cuenta',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF1F878E), // Color del enlace
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.underline, // Subraya el texto para indicar que es un enlace
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]
        )
      ),
    );
  }
  
}