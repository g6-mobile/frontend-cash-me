import 'package:flutter/material.dart';

class BaseElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const BaseElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: isLoading
          ? const Row(
              mainAxisAlignment: MainAxisAlignment.center,              
              children: [                
                SizedBox(
                  width: 8,
                ),
                CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            )
          : Text(
              text,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontSize: 18,
                fontFamily: 'Poppins',
              ),
            ),
    );
  }
}

class BaseAssetOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String asset;

  const BaseAssetOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.asset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: Image.asset(
        asset,
        height: 23,
        width: 23,
      ),
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.background,
        minimumSize: const Size(double.infinity, 50),
        alignment: Alignment.centerLeft,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      label: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
          fontSize: 18,
          fontWeight: FontWeight.normal,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
