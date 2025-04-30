import 'package:flutter/material.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:yanga/constants.dart';
import 'package:yanga/routes.dart';
import 'package:yanga/services/account_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child:
              isMobile(context) ? const SignupForm() : const SignupWebWidget(),
        ),
      ),
    );
  }
}

class SignupWebWidget extends StatelessWidget {
  const SignupWebWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/yanga2.png',
                width: 400,
                fit: BoxFit.cover,
              ),
              const Positioned(
                top: 270,
                child: Text('Transforming Education for a brighter future',
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
          const SignupForm()
        ],
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool _agree = false;
  final emailController = TextEditingController();
  final passwordControll = TextEditingController();
  final nameController = TextEditingController();
  final _accountService = AccountService();

  var isProcessing = false;

  var signupForm = FormGroup({
    "name": FormControl<String>(validators: [Validators.required]),
    "email": FormControl<String>(
        validators: [Validators.email, Validators.required]),
    'password': FormControl(validators: [
      Validators.required,
      Validators.compose([
        Validators.minLength(8),
        Validators.pattern(
          r'(?=.*[a-z])',
          validationMessage:
              'Password must contain at least one lowercase letter',
        ),
        Validators.pattern(
          r'(?=.*[A-Z])',
          validationMessage:
              'Password must contain at least one uppercase letter',
        ),
        Validators.pattern(
          r'(?=.*\d)',
          validationMessage: 'Password must contain at least one digit',
        ),
        Validators.pattern(
          r'(?=.*[@$!%*?&])',
          validationMessage:
              'Password must contain at least one special character',
        ),
      ]),
    ]),
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReactiveForm(
          formGroup: signupForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Create your account to start your learning journey',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ReactiveTextField(
                controller: nameController,
                formControlName: 'name',
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  labelText: 'Your name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ReactiveTextField(
                controller: emailController,
                formControlName: 'email',
                validationMessages: {
                  'required': (error) => 'The email must not be empty',
                  'email': (error) => 'The email value must be a valid email'
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  labelText: 'Your email address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ReactiveTextField(
                controller: passwordControll,
                formControlName: 'password',
                validationMessages: {
                  'required': (error) => 'The password must not be empty',
                  'minLength': (error) =>
                      'The password must be at least 8 characters long'
                },
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  labelText: 'Create a password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _agree,
                    onChanged: (value) {
                      setState(() {
                        _agree = value!;
                      });
                    },
                  ),
                  const Text('I agree with Terms & Conditions'),
                ],
              ),
              const SizedBox(height: 24),
              isProcessing
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _agree ? _signUp : null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide.none),
                        child: const Text('Sign Up'),
                      ),
                    ),
              const SizedBox(height: 16),
              const Text(
                'Or',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.apple),
                  label: const Text('Continue with Apple'),
                  style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 218, 192, 223),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide.none),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.g_mobiledata),
                  label: const Text(
                    'Continue with Google',
                    style: TextStyle(color: Colors.red),
                  ),
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.red[100],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide.none),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.facebook),
                  label: Text(
                    'Continue with Facebook',
                    style: TextStyle(color: Colors.blue[300]),
                  ),
                  style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 211, 226, 238),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide.none),
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  QR.toName(AppRoutes.loginRoute);
                },
                child: const Text('Already registered? Log in'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    print('sign up button click');
    setState(() {
      isProcessing = true;
    });
    // print('email: ${emailController.text} pwd: ${passwordControll.text}');
    // var response =
    await _accountService.signUp(emailController.text, passwordControll.text,
        nameController.text, 'STUDENT');

    setState(() {
      isProcessing = false;
    });
  }
}
