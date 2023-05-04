import 'package:flutter/material.dart';
import 'package:flutter_application/Business%20Logic%20Layer/Characters/bloc/characters_bloc.dart';
import 'package:flutter_application/Helpers/Route/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userID = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocListener<CharactersBloc,CharactersState>(
        listener: (context, state) {
          if(state is CharactersLoaded){
            Navigator.pushNamed(context,layoutScreen);
          }
        },
        child:Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/background.jpg"),
                          fit: BoxFit.fill)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: userID,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          userID.text = value;
                        },
                        onSubmitted: (value) {
                          userID.text = value;
                        },
                        style: TextStyle(color: Colors.black, fontSize: 13),
                        decoration: InputDecoration(
                          hintText: "Enter Your ID",
                          hintStyle: TextStyle(color: Colors.white, fontSize: 13),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.white, width: 1)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: password,
                        obscureText: true,
                        onChanged: (value) {
                          password.text = value;
                        },
                        onSubmitted: (value) {
                          password.text = value;
                        },
                        style: TextStyle(color: Colors.black, fontSize: 13),
                        decoration: InputDecoration(
                          hintText: "Enter Your Password",
                          hintStyle: TextStyle(color: Colors.white, fontSize: 13),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.white)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      ElevatedButton(onPressed: () {
                        BlocProvider.of<CharactersBloc>(context).add(LoginEvent());
                      }, child: Text("Login"))
                    ],
                  ),
                ),
      )
    );
  }
}
