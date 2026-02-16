import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;
  final AuthService _auth = AuthService();

  bool isLoading = false;

  Future<void> signUp() async {
    setState(() => isLoading = true);

    try {
      await _auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                //     Icons.person_add_outlined,
                //     size: 50,
                //     color: Colors.white,
                //   ),
                // ),
                const SizedBox(height: 32),

                // Welcome Text
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                const Text(
                  'Sign up to get started',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF8E8E93),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Full Name TextField
                _buildIOSTextField(
                  controller: _nameController,
                  hintText: 'Full Name',
                  prefixIcon: Icons.person_outline,
                  keyboardType: TextInputType.name,
                ),

                const SizedBox(height: 16),

                // Email TextField
                _buildIOSTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  prefixIcon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 16),

                // Password TextField
                _buildIOSTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF8E8E93),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Confirm Password TextField
                _buildIOSTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: const Color(0xFF8E8E93),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Terms and Conditions Checkbox
                Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _agreeToTerms,
                        onChanged: (value) {
                          setState(() {
                            _agreeToTerms = value ?? false;
                          });
                        },
                        activeColor: const Color(0xFF007AFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Wrap(
                        children: [
                          const Text(
                            'I agree to the ',
                            style: TextStyle(
                              color: Color(0xFF8E8E93),
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Handle terms tap
                            },
                            child: const Text(
                              'Terms & Conditions',
                              style: TextStyle(
                                color: Color(0xFF007AFF),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Text(
                            ' and ',
                            style: TextStyle(
                              color: Color(0xFF8E8E93),
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Handle privacy policy tap
                            },
                            child: const Text(
                              'Privacy Policy',
                              style: TextStyle(
                                color: Color(0xFF007AFF),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Sign Up Button
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF007AFF), Color(0xFF00C7FF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
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
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        // Handle sign up
                      },
                      child: const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

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
                        'or sign up with',
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

                const SizedBox(height: 32),

                // Social Login Buttons
                _buildSocialButton(
                  icon: Icons.apple,
                  text: 'Continue with Apple',
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                ),

                const SizedBox(height: 12),

                _buildSocialButton(
                  icon: Icons.g_mobiledata,
                  text: 'Continue with Google',
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  hasBorder: true,
                ),

                const SizedBox(height: 40),

                // Sign In Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Color(0xFF8E8E93), fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle navigate to sign in
                      },
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Color(0xFF007AFF),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),
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
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFF8E8E93), fontSize: 16),
          prefixIcon: Icon(
            prefixIcon,
            color: const Color(0xFF8E8E93),
            size: 22,
          ),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
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
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: hasBorder
            ? Border.all(color: const Color(0xFFE5E5EA), width: 1)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            // Handle social login
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textColor, size: 24),
              const SizedBox(width: 12),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
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
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
