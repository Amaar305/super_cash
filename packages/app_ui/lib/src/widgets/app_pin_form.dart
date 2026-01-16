// ignore_for_file: public_member_api_docs

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class AppPinForm extends StatefulWidget {
  const AppPinForm({
    required this.onCompleted,
    super.key,
    this.length = 4,
    this.onChange,
    this.onFingerprintAuthentication,
    this.onForgotPinPressed,
    this.obscured = true,
    this.enabled = true,
    this.error = false,
  });
  final void Function(String) onCompleted; // Callback when OTP is completed
  final int length;
  final void Function(String)? onChange; // Callback when OTP is changing
  final VoidCallback? onFingerprintAuthentication;
  final VoidCallback? onForgotPinPressed;
  final bool obscured;
  final bool enabled;
  final bool error;

  @override
  State<AppPinForm> createState() => _AppPinFormState();
}

class _AppPinFormState extends State<AppPinForm> {
  late List<String> _otpValues; // Stores OTP values
  int _currentIndex = 0; // Tracks the active input field

  @override
  void initState() {
    super.initState();
    _otpValues = List.filled(widget.length, '');
  }

  void _onNumberPressed(String value) {
    if (!widget.enabled) return;

    if (_currentIndex < widget.length) {
      setState(() {
        _otpValues[_currentIndex] = value;
        _currentIndex++; // Move to the next field
      });

      // Call onChange method
      widget.onChange?.call(_otpValues.join());

      // Call onCompleted method
      if (_currentIndex == widget.length) {
        widget.onCompleted(_otpValues.join());
      }
    }
  }

  void _onBackspacePressed() {
    if (!widget.enabled) return;

    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _otpValues[_currentIndex] = ''; // Clear last entry
      });

      // Call onChange method
      widget.onChange?.call(_otpValues.join());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildMeta(),
        const Gap.v(AppSpacing.lg),
        _buildOtpFields(),
        const SizedBox(height: 24),
        _buildKeyboard(),
      ],
    );
  }

  Widget _buildOtpFields() {
    final hasError = widget.error;
    final shadow = [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 14,
        offset: const Offset(0, 8),
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: AppSpacing.md,
      children: List.generate(widget.length, (index) {
        final active = _currentIndex == index;
        final filled = _otpValues[index].isNotEmpty;

        return AnimatedContainer(
          duration: 180.ms,
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            gradient: hasError || !active
                ? null
                : const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.white,
                      Color(0xFFE8F6FF),
                    ],
                  ),
            color: hasError
                ? AppColors.red.shade50
                : active
                    ? null
                    : null,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: hasError
                  ? AppColors.red
                  : active
                      ? AppColors.blue
                      : AppColors.brightGrey,
              width: active ? 1.4 : 1,
            ),
            boxShadow: active || filled ? shadow : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedDefaultTextStyle(
                duration: 150.ms,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                  color: hasError ? AppColors.red : AppColors.black,
                ),
                child: Text(
                  widget.obscured && filled ? '•' : _otpValues[index],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  /// Custom numeric keyboard layout
  Widget _buildNumberPad(String digit, {String? option}) {
    final text = Text(
      digit,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
    );
    return TextButton(
      onPressed: widget.enabled ? () => _onNumberPressed(digit) : null,
      child: text,
    );
  }

  Expanded buildFingerprintButton() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Material(
          color: Colors.transparent,
          child: Ink(
            height: 74,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.brightGrey.withValues(alpha: 0.7),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: InkWell(
              onTap: widget.enabled ? widget.onFingerprintAuthentication : null,
              borderRadius: BorderRadius.circular(18),
              splashColor: AppColors.blue.withValues(alpha: 0.12),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 6,
                  children: [
                    Icon(Icons.fingerprint_outlined),
                    Text(
                      'Fingerprint',
                      style: TextStyle(
                        color: Color(0xff171B2A),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackSpaceButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          height: 74,
          child: InkWell(
            onTap: widget.enabled ? _onBackspacePressed : null,
            borderRadius: BorderRadius.circular(18),
            splashColor: AppColors.blue.withValues(alpha: 0.12),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Icon(
                  Icons.backspace_outlined,
                  size: 22,
                  color: AppColors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildKeyboard() => Column(
        children: [
          Column(
            spacing: AppSpacing.md,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNumberPad('1'),
                  _buildNumberPad('2'),
                  _buildNumberPad('3'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNumberPad('4'),
                  _buildNumberPad('5'),
                  _buildNumberPad('6'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNumberPad('7'),
                  _buildNumberPad('8'),
                  _buildNumberPad('9'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBackSpaceButton(),
                  _buildNumberPad('0', option: '+'),
                  // Delete all
                  TextButton(
                    onPressed: () {
                      // Clear all values
                      if (!widget.enabled) return;
                      setState(() {
                        _otpValues = List.filled(widget.length, '');
                        _currentIndex = 0;
                      });
                    },
                    child: const Text('Clear'),
                  ),
                ],
              ),
            ],
          ),
        ],
      );

  Row _buildMeta() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Enter Secure Pin',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          TextButton(
            onPressed: widget.onForgotPinPressed,
            child: const Text(
              'Forgot Pin?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.red,
              ),
            ),
          ),
        ],
      );
}
