import 'package:Crypto_Time/configuration.dart';
import 'package:flutter/material.dart';
import 'package:Crypto_Time/components/currency_item.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String inputValue = "1";
  String _cryptoPickedValue = "USD";
  String _convertedAmount = "_ _ . _ _";

  _apiGetter() async {
    var jsonResponse;
    String url =
        "https://rest.coinapi.io/v1/exchangerate/BTC/$_cryptoPickedValue?apikey=3CE2C534-375F-4A3A-A2E9-66B07D1AD30C";

    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        jsonResponse = convert.jsonDecode(response.body);
      });

      print(jsonResponse["rate"]);
      var calculatedValue = jsonResponse["rate"] * double.parse(inputValue);
      print("The calculated value is: $calculatedValue");
      _convertedAmount =
          calculatedValue.toStringAsFixed(2) + " " + _cryptoPickedValue;
    } else {
      print("failed to get the api");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<CurrencyItem> items = [
      CurrencyItem(currencyName: "USD"),
      CurrencyItem(currencyName: "GBP"),
      CurrencyItem(currencyName: "HKD"),
      CurrencyItem(currencyName: "CNY"),
      CurrencyItem(currencyName: "EUR")
    ];
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(16, 20, 24, 1),
                      Colors.white,
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        "Crypto Time",
                        style: GoogleFonts.anton(
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.3),
                      ),
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(150),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      new LengthLimitingTextInputFormatter(4)
                                    ],
                                    onChanged: (text) {
                                      inputValue = text;
                                    },
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(0)),
                                    initialValue: inputValue,
                                    style: GoogleFonts.yesevaOne(
                                      fontSize: 40,
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                                Container(
                                  child: Text(
                                    "BTC",
                                    style: GoogleFonts.russoOne(
                                      fontSize: 30,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_right,
                            size: 50,
                            color: Color.fromRGBO(26, 80, 139, 1),
                          ),
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: ListWheelScrollView(
                              itemExtent: 45,
                              physics: FixedExtentScrollPhysics(),
                              diameterRatio: 1,
                              children: items,
                              // useMagnifier: true,
                              // magnification: 1.1,
                              onSelectedItemChanged: (index) => {
                                _cryptoPickedValue = items[index].currencyName
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Text(
                        _convertedAmount,
                        style: GoogleFonts.yesevaOne(
                            fontSize: 45, fontWeight: FontWeight.w500),
                      ),
                    ),
                    FlatButton(
                      color: Color.fromRGBO(26, 80, 139, 1).withOpacity(0.9),
                      minWidth: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                      onPressed: () {
                        setState(() {
                          _apiGetter();
                        });
                      },
                      child: Text(
                        "Get Rate",
                        style: GoogleFonts.mukta(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
