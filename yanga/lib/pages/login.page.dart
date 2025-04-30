import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:yanga/constants.dart';
import 'package:yanga/providers/providers.dart';
import 'package:yanga/routes.dart';
import '../services/account_service.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child:
              isMobile(context) ? const SignInForm() : const SignInWebWidget(),
        ),
      ),
    );
  }
}

class SignInWebWidget extends StatelessWidget {
  const SignInWebWidget({super.key});

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
          const SignInForm()
        ],
      ),
    );
  }
}

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({super.key});

  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  final _accountService = AccountService();
  bool _isLoading = false;

  final signinForm = FormGroup({
    "email": FormControl<String>(
        validators: [Validators.email, Validators.required]),
    'password': FormControl(validators: [
      Validators.required,
    ]),
  });

  void _login() async {
    ref.read(emailProvider.notifier).state =
        signinForm.value['email'].toString();
    setState(() => _isLoading = true);
    try {
      await _accountService.login(signinForm.value);
    } catch (e) {
      showToastMessage('Login failed. Please try again.');
    }
    setState(() => _isLoading = false);
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isMobile(context) ? double.infinity : 400,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReactiveForm(
          formGroup: signinForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Welcome! Sign In',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign in to your yanga dashboard',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
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
                controller: passwordController,
                formControlName: 'password',
                onChanged: (value) {
                  setState(() {
                    signinForm.updateValueAndValidity();
                  });
                },
                validationMessages: {
                  'required': (error) => 'The password must not be empty',
                },
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  labelText: 'Enter a password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: signinForm.valid ? _login : null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide.none),
                        child: const Text('Sign In'),
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
                  QR.toName(AppRoutes.signupRoute);
                },
                child: const Text('Don\'t have an account? Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
