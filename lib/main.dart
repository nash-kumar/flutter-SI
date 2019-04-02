import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SiForm(),
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.greenAccent[200],
        accentColor: Colors.lightGreen[300]),
  ));
}

class SiForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SimpleInterest();
  }
}

class _SimpleInterest extends State<SiForm> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollars', 'Pounds', 'Others'];
  var _minPadding = 5.0;
  var _currentValue = '';

  @override
  void initState() {
    super.initState();
    _currentValue = _currencies[0];
  }

  TextEditingController principal = TextEditingController();
  TextEditingController roi = TextEditingController();
  TextEditingController term = TextEditingController();
  var display = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minPadding * 2),
          child: ListView(
            children: <Widget>[
              imageUpload(),
              Padding(
                padding:
                    EdgeInsets.only(top: _minPadding, bottom: _minPadding * 2),
                child: TextFormField(
                  style: textStyle,
                  controller: principal,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter princpal amount';
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Principal',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(fontSize: 17.0),
                      hintText: 'Enter amount eg:1000',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: _minPadding, bottom: _minPadding * 2),
                child: TextFormField(
                  style: textStyle,
                  controller: roi,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter Rate of Interest';
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(fontSize: 17.0),
                      hintText: 'In percentage',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: _minPadding, bottom: _minPadding * 2),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        style: textStyle,
                        controller: term,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter term in years';
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Term',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(fontSize: 17.0),
                            hintText: 'In years eg: 2',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Container(width: _minPadding * 5),
                    Expanded(
                      child: DropdownButton<String>(
                        style: textStyle,
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                        value: _currentValue,
                        onChanged: (String newValue) {
                          _onDropDown(newValue);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: _minPadding, bottom: _minPadding * 2),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                          color: Theme.of(context).primaryColor,
                          textColor: Theme.of(context).primaryColorDark,
                            child: Text('Calculate', textScaleFactor: 1.5),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState.validate()) {
                                this.display = _simpleInterestCalculator();
                              }
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Reset',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _onReset();
                            });
                          },
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding:
                    EdgeInsets.only(top: _minPadding, bottom: _minPadding * 2),
                child: Text(
                  this.display,
                  textScaleFactor: 1.2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//Image Upload Widget
  Widget imageUpload() {
    AssetImage assetRoot = AssetImage('images/money.png');
    Image image = Image(
      image: assetRoot,
      width: 125.0,
      height: 125.0,
    );

    return Container(child: image, margin: EdgeInsets.all(50.0));
  }

  void _onDropDown(String newValue) {
    setState(() {
      this._currentValue = newValue;
    });
  }

  String _simpleInterestCalculator() {
    double principle = double.parse(principal.text);
    double rate = double.parse(roi.text);
    double terms = double.parse(term.text);

    double totalAmount = principle + (principle * rate * terms) / 100;

    String result =
        'After $terms, your investment will be worth $totalAmount in $_currentValue';
    return result;
  }

  void _onReset() {
    principal.text = '';
    roi.text = '';
    term.text = '';
    _currentValue = _currencies[0];
    display = '';
  }
}
