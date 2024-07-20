import 'package:flutter/material.dart';
import 'package:house_chores/core/theme/app_pallete.dart';
import 'package:house_chores/features/auth/presentation/pages/login_page.dart';
import 'package:house_chores/features/auth/presentation/widgets/auth_field.dart';
import 'package:house_chores/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class SignUpPage extends StatefulWidget {
  static route() =>MaterialPageRoute(builder: (context)=> const SignUpPage());

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign Up.',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthField(
                    hintText: "Email",
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthField(
                    hintText: "Password",
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const AuthGradientButton(
                    buttonText: 'Sign Up',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, LoginPage.route());
                },
                child:
                  RichText(
                      text: TextSpan(
                          text: "Already have an account?",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                        TextSpan(
                          text: ' Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold),
                        )
                      ]))
              )
                ],
              ),
            )));

    //   Column(children: [
    //   TextField(
    //     controller: emailController,
    //   ),
    //   TextField(
    //     controller: passwordController,
    //     obscureText: true,
    //   ),
    //   MaterialButton(
    //       onPressed: () async {
    //         final sm = ScaffoldMessenger.of(context);
    //         final authResponse = await supabase.auth.signUp(
    //             password: passwordController.text, email: emailController.text);
    //         sm.showSnackBar(SnackBar(
    //             content: Text('Logged in: ${authResponse.user!.email}')));
    //         print('Logged in as $authResponse');
    //       },
    //       child: Text("SignUp"))
    // ]);
  }
}
