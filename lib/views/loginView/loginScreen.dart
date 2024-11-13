import 'package:flutter/material.dart';
import 'package:margintop_solutions/components/colors.dart';
import 'package:margintop_solutions/views/homePageView/bottomNavBar.dart';
import 'package:margintop_solutions/views/loginView/loginProvider.dart';
import 'package:margintop_solutions/views/splashView/splashClipper.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: MountainCurveClipper(),
                child: Container(
                  height: size.height / 2.8,
                  width: size.width,
                  color: appColor,
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Material(
                    elevation: 2,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/images/logo.jpg"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 60,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Let's get something",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Good to see you back.",
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter Your Email',
                    counterText: '',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Consumer<LoginProvider>(
                  builder: (context, value, child) {
                    return TextField(
                      controller: passwordController,
                      obscureText: value.passwordVisibility,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: "Enter Your Password",
                        counterText: "",
                        labelStyle: const TextStyle(color: Colors.black),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        suffixIcon: IconButton(onPressed: () {
                          loginProvider.changePasswordVisibility();
                        }, icon: Consumer<LoginProvider>(
                          builder: (context, value, child) {
                            return value.passwordVisibility == true
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off);
                          },
                        )),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: size.height / 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  tileColor: appColor,
                  onTap: () {
                    /**********Apply conditions like incorrect password, empty fields to navigate to the home page********/
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavView()));
                  },
                  title: const Text(
                    "Log In",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("Don't have an account? Sign Up"),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {}, child: const Text("Forgot password?"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
