import 'package:Crypto_Time/configuration.dart';
import 'package:flutter/material.dart';
import 'package:Crypto_Time/components/currency_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedItem = 0;

  String _cryptoPickedValue = "USD";
  _apiGetter() async {
    String url =
        "https://rest.coinapi.io/v1/exchangerate/BTC/$_cryptoPickedValue?apikey=3CE2C534-375F-4A3A-A2E9-66B07D1AD30C";

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse["rate"]);
      print("The selected item is: $_selectedItem");
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
      CurrencyItem(currencyName: "CNY")
    ];
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.red,
              ),
              Column(
                children: [
                  Text("CRYPTO TIME"),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.grey[200],
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white
                          ),
                          
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: "Write the amount in BTC",
                              border: InputBorder.none,

                            ),
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
                              setState(() {
                                _selectedItem = index;
                                _cryptoPickedValue = items[index].currencyName;
                              })
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  FlatButton(
                      onPressed: () {
                        _apiGetter();
                      },
                      child: Text("push here"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
