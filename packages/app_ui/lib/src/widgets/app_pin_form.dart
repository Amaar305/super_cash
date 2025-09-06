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
    this.obscured = true,
    this.enabled = true,
    this.error = false,
  });
  final void Function(String) onCompleted; // Callback when OTP is completed
  final int length;
  final void Function(String)? onChange; // Callback when OTP is changing
  final VoidCallback? onFingerprintAuthentication;
  final bool obscured;
  final bool enabled;
  final bool error;

  @override
  State<AppPinForm> createState() => _AppPinFormState();
}

class _AppPinFormState extends State<AppPinForm> {
  late final List<String> _otpValues; // Stores OTP values
  int _currentIndex = 0; // Tracks the active input field

  @override
  void initState() {
    super.initState();
    _otpValues = List.filled(widget.length, '');
  }

  void _onNumberPressed(String value) {
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
        // OTP Fields
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSpacing.md,
          children: List.generate(widget.length, (index) {
            return AnimatedContainer(
              duration: 200.ms,
              width: 54,
              height: 54,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.error
                      ? AppColors.red
                      : _currentIndex == index
                          ? AppColors.blue
                          : AppColors.brightGrey,
                ),
                borderRadius: BorderRadius.circular(AppSpacing.xs),
              ),
              child: Text(
                widget.obscured && _otpValues[index].isNotEmpty
                    ? '*'
                    : _otpValues[index],
                style: const TextStyle(fontSize: AppSpacing.lg + 2),
              ),
            );
          }),
        ),
        const SizedBox(height: 20),

        // Custom Keyboard
        _buildKeyboard(),
      ],
    );
  }

  /// Custom numeric keyboard layout
  Widget _buildNumberPad(String digit, {String? option}) {
    final text = Text(
      digit,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
    return Expanded(
      child: Container(
        // width: 130,
        height: 88,
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
        ),
        child: InkWell(
          onTap: () => _onNumberPressed(digit),
          borderRadius: BorderRadius.circular(2),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: option == null
                  ? text
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        text,
                        Text(
                          option,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildFingerprintButton() {
    return Expanded(
      child: Container(
        height: 88,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
        ),
        child: InkWell(
          onTap: widget.onFingerprintAuthentication,
          borderRadius: BorderRadius.circular(2),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5,
              children: [
                Icon(Icons.fingerprint_outlined),
                Text(
                  'Fingerprints',
                  style: TextStyle(
                    color: Color(0xff171B2A),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackSpaceButton() {
    return Expanded(
      child: Container(
        height: 88,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
        ),
        child: InkWell(
          onTap: _onBackspacePressed,
          borderRadius: BorderRadius.circular(2),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Icon(
                Icons.backspace_outlined,
                size: 21,
                color: AppColors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildKeyboard() => Column(
        children: [
          const Divider(thickness: 0.5),
          Row(
            children: [
              _buildNumberPad('1'),
              _buildNumberPad('2'),
              _buildNumberPad('3'),
            ],
          ),
          Row(
            children: [
              _buildNumberPad('4'),
              _buildNumberPad('5'),
              _buildNumberPad('6'),
            ],
          ),
          const Divider(thickness: 0.5),
          Row(
            children: [
              _buildNumberPad('7'),
              _buildNumberPad('8'),
              _buildNumberPad('9'),
            ],
          ),
          const Divider(thickness: 0.5),
          Row(
            children: [
              _buildBackSpaceButton(),
              _buildNumberPad('0', option: '+'),
              _buildFingerprintButton(),
            ],
          ),
        ],
      );
}
