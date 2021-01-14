import 'package:flutter/material.dart';

class CurrencyItem extends StatelessWidget {
  final String currencyName;
  CurrencyItem({this.currencyName});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        color: Color.fromRGBO(26, 80, 139, 1),
        child: Center(
          child: Text(
            currencyName,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
