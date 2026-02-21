import 'package:flutter/material.dart';
import 'package:price_scrapper/screens/signup.dart';
import '../services/auth_service.dart';
import 'package:price_scrapper/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _auth = AuthService();
  // to make the password look like dotted or star rather that whole alphabets

  bool obscurePassword = true;

  bool isLoading = false;
  //functrion for login

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });
    try {
      await _auth.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                // App Icon/Logo
                // Container(
                //   width: 100,
                //   height: 100,
                //   decoration: BoxDecoration(
                //     gradient: const LinearGradient(
                //       colors: [Color(0xFF007AFF), Color(0xFF00C7FF)],
                //       begin: Alignment.topLeft,
                //       end: Alignment.bottomRight,
                //     ),
                //     borderRadius: BorderRadius.circular(22),
                //     boxShadow: [
                //       BoxShadow(
                //         color: const Color(0xFF007AFF).withOpacity(0.3),
                //         blurRadius: 20,
                //         offset: const Offset(0, 10),
                //       ),
                //     ],
                //   ),
                //   child: const Icon(
                //     Icons.lock_outline,
                //     size: 50,
                //     color: Colors.white,
                //   ),
                // ),
                const SizedBox(height: 20),

                // Welcome Text
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 6),

                const Text(
                  'Sign in to continue',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF8E8E93),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                // Email TextField
                _buildIOSTextField(
                  controller: emailController,
                  hintText: 'Email',
                  prefixIcon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 12),

                // Password TextField
                _buildIOSTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF8E8E93),
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFF007AFF),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Sign In Button
                Container(
                  height: 42,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF007AFF), Color(0xFF00C7FF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF007AFF).withOpacity(0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        await login();
                      },
                      child: const Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Divider
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xFFE5E5EA),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or',
                        style: TextStyle(
                          color: Color(0xFF8E8E93),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: const Color(0xFFE5E5EA),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Social Login Buttons
                _buildSocialButton(
                  icon: Icons.apple,
                  text: 'Continue with Apple',
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                ),

                const SizedBox(height: 10),

                _buildSocialButton(
                  icon: Icons.g_mobiledata,
                  text: 'Continue with Google',
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  hasBorder: true,
                ),

                const SizedBox(height: 32),

                // Sign Up Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Color(0xFF8E8E93), fontSize: 13),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFF007AFF),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIOSTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: const TextStyle(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFF8E8E93), fontSize: 13),
          prefixIcon: Icon(
            prefixIcon,
            color: const Color(0xFF8E8E93),
            size: 20,
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String text,
    required Color backgroundColor,
    required Color textColor,
    bool hasBorder = false,
  }) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: hasBorder
            ? Border.all(color: const Color(0xFFE5E5EA), width: 1)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Handle social login
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 20),
              const SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
