import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        primary: Colors.amber.shade200,
      ),
      child: Container(
        width: double.infinity,
        child: Center(
          child: Container(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Colors.black,
              backgroundColor: Colors.grey.withOpacity(0.1),
              strokeWidth: 2,
            ),
          ),
        ),
      ),
    );
  }
}
