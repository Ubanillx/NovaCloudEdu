import 'package:flutter/material.dart';
import '../../../config/app_theme.dart';

class AuthCard extends StatelessWidget {
  final Widget child;

  const AuthCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 44),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(40),
      ),
      child: child,
    );
  }
}

class AuthPrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isLoading;
  final Gradient gradient;

  const AuthPrimaryButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.isLoading,
    required this.gradient,
  });

  @override
  State<AuthPrimaryButton> createState() => _AuthPrimaryButtonState();
}

class _AuthPrimaryButtonState extends State<AuthPrimaryButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final disabled = widget.onTap == null || widget.isLoading;
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: disabled ? null : widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          height: 58,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: disabled
                ? const LinearGradient(
                    colors: [
                      Color(0xFFE2E8F0),
                      Color(0xFFF1F5F9),
                    ],
                  )
                : widget.gradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: disabled
                ? []
                : [
                    BoxShadow(
                      color: (widget.gradient.colors.first).withOpacity(0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: widget.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  widget.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                    letterSpacing: 4,
                  ),
                ),
        ),
      ),
    );
  }
}

class AuthSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const AuthSecondaryButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final disabled = onTap == null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: disabled ? colors.surfaceVariant : colors.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.border),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: disabled ? colors.textTertiary : colors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class AuthSegmentedControl extends StatelessWidget {
  final List<String> items;
  final int index;
  final ValueChanged<int> onChanged;
  final Gradient activeGradient;

  const AuthSegmentedControl({
    super.key,
    required this.items,
    required this.index,
    required this.onChanged,
    required this.activeGradient,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final itemW = w / items.length;
        return Container(
          height: 48,
          decoration: BoxDecoration(
            color: colors.surfaceVariant,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.border),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                left: itemW * index + 2,
                top: 2,
                bottom: 2,
                width: itemW - 4,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: activeGradient,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: (activeGradient.colors.first).withOpacity(0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: List.generate(items.length, (i) {
                  final active = i == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onChanged(i),
                      behavior: HitTestBehavior.opaque,
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 160),
                          style: TextStyle(
                            color: active ? Colors.white : colors.textSecondary,
                            fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                          ),
                          child: Text(items[i]),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final TextInputType keyboardType;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffix;
  final FormFieldValidator<String>? validator;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmitted;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.keyboardType,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffix,
    this.validator,
    required this.textInputAction,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      cursorColor: const Color(0xFF3B5BFF),
      cursorWidth: 1.5,
      cursorRadius: const Radius.circular(1),
      style: TextStyle(
        color: colors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: colors.surfaceVariant.withOpacity(0.5),
        hintText: hintText,
        hintStyle: TextStyle(
          color: colors.textTertiary, 
          fontSize: 15, 
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Icon(prefixIcon, color: colors.iconPrimary, size: 20),
        ),
        suffixIcon: suffix,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFF3B5BFF), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: colors.error.withOpacity(0.3), width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: colors.error, width: 1.5),
        ),
        errorStyle: TextStyle(color: colors.error, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class AuthBgPainter extends CustomPainter {
  final Color primary;
  final Color secondary;

  AuthBgPainter({required this.primary, required this.secondary});

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Paint()
      ..color = primary.withOpacity(0.22)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);
    final p2 = Paint()
      ..color = secondary.withOpacity(0.20)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 70);

    canvas.drawCircle(Offset(size.width * 0.15, size.height * 0.18), size.width * 0.42, p1);
    canvas.drawCircle(Offset(size.width * 0.92, size.height * 0.28), size.width * 0.46, p2);
    canvas.drawCircle(Offset(size.width * 0.55, size.height * 0.92), size.width * 0.55, p1..color = primary.withOpacity(0.10));
  }

  @override
  bool shouldRepaint(covariant AuthBgPainter oldDelegate) {
    return oldDelegate.primary != primary || oldDelegate.secondary != secondary;
  }
}
