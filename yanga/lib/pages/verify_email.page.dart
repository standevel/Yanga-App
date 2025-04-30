import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:yanga/constants.dart';
import 'package:yanga/routes.dart';
import 'package:yanga/services/account_service.dart';

import '../providers/providers.dart';

final isLoadingProvider = StateProvider<bool>((ref) => false);
final counterProvider = StateProvider<int>((ref) => 60);
final resendButtonProvider = StateProvider<bool>((ref) => false);

//
class EmailVerificationPage extends ConsumerStatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  _EmailVerificationPageState createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends ConsumerState<EmailVerificationPage> {
  final _accountService = AccountService();
  final controllers = List.generate(6, (index) => TextEditingController());
  final focusNodes = List.generate(6, (index) => FocusNode());
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    ref.read(counterProvider.notifier).state = 60;
    ref.read(resendButtonProvider.notifier).state = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int currentCounter = ref.read(counterProvider);
      if (currentCounter > 0) {
        ref.read(counterProvider.notifier).state = currentCounter - 1;
      } else {
        ref.read(resendButtonProvider.notifier).state = true;
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SizedBox(
              width:
                  isMobile(context) ? MediaQuery.of(context).size.width : 350,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Image.asset(
                      'assets/images/yanga2.png',
                      height: 200,
                      width: 200,
                      scale: 0.6,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Verify your email',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please enter authentication code sent to your email',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Consumer(
                    builder: (context, watch, _) {
                      var inputs = List.generate(6, (index) {
                        final controller = controllers[index];

                        controller.addListener(() {
                          final value = controller.text;

                          if (value.isNotEmpty) {
                            if (index < 5) {
                              FocusScope.of(context)
                                  .requestFocus(focusNodes[index + 1]);
                            } else {
                              _submitToken(context, ref, controllers);
                            }
                          }
                        });

                        return TextField(
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          controller: controller,
                          obscureText: true,
                          focusNode: focusNodes[index],
                          decoration: InputDecoration(
                            counterText: '',
                            contentPadding: const EdgeInsets.all(12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      });

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: inputs.map((input) {
                          return SizedBox(width: 50, child: input);
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 40.0),
                  Consumer(
                    builder: (context, ref, child) {
                      final counter = ref.watch(counterProvider);
                      final resendButtonEnabled =
                          ref.watch(resendButtonProvider);
                      return Column(
                        children: [
                          Text('Resend token in $counter seconds'),
                          ElevatedButton(
                            onPressed: resendButtonEnabled
                                ? () {
                                    _startTimer();
                                    // Resend token logic here
                                  }
                                : null,
                            child: const Text('Resend Token'),
                          ),
                        ],
                      );
                    },
                  ),
                  if (isLoading) const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitToken(BuildContext context, WidgetRef ref,
      List<TextEditingController> controllers) async {
    final accountService = AccountService();
    ref.read(isLoadingProvider.notifier).state = true;

    String token = controllers.map((controller) => controller.text).join();
    final email = ref.read(emailProvider);
    print('Token: $token, email: $email');
    var response = await accountService.verifyemail(email, token);
    ref.read(isLoadingProvider.notifier).state = false;
    print('token response $response');
    if (response.status) {
      QR.toName(AppRoutes.signupRoute, ignoreSamePath: true);
    }
  }
}
