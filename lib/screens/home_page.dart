import 'package:Crypto_Time/configuration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedItem = 0;

  String _cryptoPickedValue = "USD";
  _apiGetter() async{
    String url = "https://rest.coinapi.io/v1/exchangerate/BTC/$_cryptoPickedValue?apikey=3CE2C534-375F-4A3A-A2E9-66B07D1AD30C";
    
    var response = await http.get(url);
    if(response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse["rate"]);
      print("The selected item is: $_selectedItem");
    }else{
      print("failed to get the api");
    }
  }
  @override
  Widget build(BuildContext context) {

      List <Container>items = [
                              Container(
                                width: 50,
                                color: Colors.redAccent,
                                child: Center(
                                  child: Text("BTC", 
                                    style: TextStyle(
                                      fontSize: 20
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 50,
                                color: Colors.redAccent,
                                child: Center(
                                  child: Text("BTC", 
                                    style: TextStyle(
                                      fontSize: 20
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 50,
                                color: Colors.redAccent,
                                child: Center(
                                  child: Text("BTC", 
                                    style: TextStyle(
                                      fontSize: 20
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 50,
                                color: Colors.redAccent,
                                child: Center(
                                  child: Text("BTC", 
                                    style: TextStyle(
                                      fontSize: 20
                                    ),
                                  ),
                                ),
                              )
  ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.transparent,
              ),
              Column(
                children: [
                  Container(
                    color: Colors.grey[200],
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 200,
                          width: 72,
                          child: ListWheelScrollView(
                            itemExtent: 45, 
                            physics: FixedExtentScrollPhysics(),
                            diameterRatio: 1,
                            children: items,
                            useMagnifier: true,
                            magnification: 1.5,
                            onSelectedItemChanged: (index)=>{
                              setState((){
                                _selectedItem = index;
                              })
                            },
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Write the amount in BTC",
                              fillColor: Colors.red,
                            ),
                          ),
                        ),
                        DropdownButton(
                          value: _cryptoPickedValue,
                          icon: Icon(
                            Icons.arrow_downward,
                          ),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                            color: Colors.deepPurple,
                            ),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue){
                            setState(() {
                              _cryptoPickedValue = newValue;
                            });
                          },
                          items: <String>["USD","GBP","HKD", "CNY"].map<DropdownMenuItem<String>>((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()
                        )
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: (){
                      _apiGetter();
                    }, 
                    child: Text("push here")
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}