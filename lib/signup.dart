import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _usernameController = TextEditingController();
  // final _passwordController = TextEditingController();
  final ValueNotifier<String> _passwordInput = ValueNotifier<String>("");

  bool hasMinimumLength = false;
  bool hasUpperCase = false;
  bool hasLowerCase = false;

  bool obscuretext = true;

  void togglePasswordVisibility() {
    setState(() {
      obscuretext = !obscuretext;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordInput.dispose();
    super.dispose();
  }

  Widget buildLoginDetails() {
    return AutofillGroup(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              controller: _usernameController,
              autofillHints: const [AutofillHints.username],
              decoration: InputDecoration(
                labelText: 'Username',
                border: outlineinput(),
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              autofillHints: const [AutofillHints.password],
              decoration: InputDecoration(
                border: outlineinput(),
                labelText: 'Password',
                suffixIcon: GestureDetector(
                  onTap: togglePasswordVisibility,
                  child: Icon(
                    obscuretext == false
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
              onChanged: (value) => _passwordInput.value = value,
              obscureText: obscuretext,
              obscuringCharacter: '*',
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder outlineinput() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        width: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Center(
                child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 2.5,
              ),
              child: Image.asset("assets/logo.png"),
            )),
          ),
          Expanded(
            flex: 4,
            child: Form(
              child: Column(
                children: [
                  const Expanded(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 8,
                      ),
                      child: buildLoginDetails(),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: size.height / 15,
                      width: size.width / 1.5,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        child: const Text('Submit'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: SizedBox(
                        child: ValueListenableBuilder(
                          valueListenable: _passwordInput,
                          builder: (context, value, child) {
                            final String check = String.fromCharCode(0x2713);
                            final String cancel = String.fromCharCode(0x1F5D9);
                            hasMinimumLength = value.length >= 8;
                            hasUpperCase = RegExp(r'[A-Z]').hasMatch(value);
                            hasLowerCase = RegExp(r'[a-z]').hasMatch(value);
                            return Column(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Minimum of 8 characters: ${hasMinimumLength ? check : cancel}",
                                    style: TextStyle(
                                      color: hasMinimumLength
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Has Capital Letter: ${hasUpperCase ? check : cancel}",
                                    style: TextStyle(
                                      color: hasUpperCase
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Has Lowercase letter: ${hasLowerCase ? check : cancel}",
                                    style: TextStyle(
                                      color: hasLowerCase
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 3,
                    child: SizedBox(),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
