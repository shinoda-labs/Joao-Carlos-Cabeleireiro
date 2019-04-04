import 'package:flutter/material.dart';
import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewHomeActivity extends StatefulWidget {
  @override
  _NewHomeActivityState createState() => _NewHomeActivityState();
}

class _NewHomeActivityState extends State<NewHomeActivity> {
  @override
  bool service = false;
  bool barber = false;
  bool date = false;
  bool time = false;

  String _barber;
  int timeSelected;

  DateTime _date = new DateTime.now();

  var _horarios = <String>[
    "08:00",
    "08:30",
    "08:00",
    "09:00",
    "09:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "13:00",
    "13:30",
    "14:00",
    "14:30",
    "15:00",
    "15:30",
    "16:00",
    "16:30",
    "17:00",
    "18:00",
    "18:30",
    "19:00",
    "19:30",
    "20:00",
    "20:30",
    "21:00"
  ];

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime(2019),
      lastDate: new DateTime(2020),
    );

    if (picked != null && picked != _date) {
      print("Date Selected: ${_date.toString()}");
      setState(() {
        _date = picked;
        date = true;
      });
    }
  }

  void _showTime(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Selecione um Horário",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w200)),
                    GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(1.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 1.0,
                          crossAxisSpacing: 1.0,
                          childAspectRatio: 1),
                      itemCount: _horarios.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              time = true;
                              timeSelected = index;
                              Navigator.of(context).pop();
                            });
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                color: Colors.green,
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Center(
                                    child: Text(
                                      _horarios[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        );
                      },
                    ),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        padding: EdgeInsets.all(16),
                        color: Theme.of(context).primaryColor,
                        child: Text('Fechar',
                            style: TextStyle(color: Colors.white)))
                  ],
                ),
              );
            },
          );
        });
  }

  void _showBarber(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Selecione um Cabeleireiro",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w200)),
                    FutureBuilder<QuerySnapshot>(
                      future: Firestore.instance
                          .collection("barber")
                          .getDocuments(),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                            return Center(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: 16.0, bottom: 16.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                            break;
                          case ConnectionState.none:
                          case ConnectionState.done:
                            if (!snapshot.hasData) {
                              return SizedBox(
                                height: 80,
                                child: Container(
                                  padding:
                                      EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: Center(
                                    child: Text(
                                      "Sem cabeleireiros disponiveis no momento!",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w200),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return GridView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.all(1.0),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 1.0,
                                          crossAxisSpacing: 1.0,
                                          childAspectRatio: 1),
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          barber = true;
                                          _barber = snapshot.data.documents[index].data["name"];
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 30,
                                          ),
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              child: Container(
                                                width: 80.0,
                                                height: 80.0,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          snapshot
                                                              .data
                                                              .documents[index]
                                                              .data["image"])),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          Text(
                                            snapshot.data.documents[index].data["name"],
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w200),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            }
                            break;
                        }
                      },
                    ),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        padding: EdgeInsets.all(16),
                        color: Theme.of(context).primaryColor,
                        child: Text('Fechar',
                            style: TextStyle(color: Colors.white)))
                  ],
                ),
              );
            },
          );
        });
  }

  void _showService(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Selecione um Serviço",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w200)),
                    //Aqui sera o gridview com os serviços
                    SizedBox(
                      height: 80,
                      child: Container(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Center(
                          child: Text(
                            "Sem serviços disponiveis no momento!",
                            style: TextStyle(fontWeight: FontWeight.w200),
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        padding: EdgeInsets.all(16),
                        color: Theme.of(context).primaryColor,
                        child: Text('Fechar',
                            style: TextStyle(color: Colors.white)))
                  ],
                ),
              );
            },
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("João Carlos Cabelereiro"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              //###################### TILE SERVIÇOS ######################
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: !service ? Colors.yellow : Colors.green,
                        child: SizedBox(
                          height: 55.0,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 12,
                                child: Center(
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child:
                                        Image.asset("assets/barber_chair.png"),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 55,
                                  width: 3,
                                  child: Container(
                                    color: Colors.yellow,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 55.0,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _showService(context);
                              service = true;
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Expanded(
                                flex: 3,
                                child: !service
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Serviço",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w200),
                                          )
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Serviço",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w200),
                                          ),
                                          Text(
                                            "Corte de Cabelo com Máquina",
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          )
                                        ],
                                      ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Icon(Icons.chevron_right,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //###################### TILE BARBEIRO ######################
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: !barber ? Colors.yellow : Colors.green,
                        child: SizedBox(
                          height: 55.0,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 12,
                                child: Center(
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Image.asset("assets/barber.png"),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 55,
                                  width: 3,
                                  child: Container(
                                    color: Colors.yellow,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 55.0,
                        child: InkWell(
                          onTap: () {
                            _showBarber(context);
                          },
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Expanded(
                                flex: 3,
                                child: !barber
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Cabeleireiro",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w200),
                                          )
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Cabeleireiro",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w200),
                                          ),
                                          Text(
                                            _barber,
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          )
                                        ],
                                      ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Icon(Icons.chevron_right,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //###################### TILE DATA ######################
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: !date ? Colors.yellow : Colors.green,
                        child: SizedBox(
                          height: 55.0,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 12,
                                child: Center(
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Image.asset("assets/date.png"),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 55,
                                  width: 3,
                                  child: Container(
                                    color: Colors.yellow,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 55.0,
                        child: InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Expanded(
                                flex: 3,
                                child: !date
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Data",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w200),
                                          )
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Data",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w200),
                                          ),
                                          Text(
                                            formatDate(_date,
                                                [dd, "/", MM, "/", yyyy]),
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          )
                                        ],
                                      ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Icon(Icons.chevron_right,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //###################### TILE HORARIO ######################
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: !time ? Colors.yellow : Colors.green,
                        child: SizedBox(
                          height: 55.0,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 12,
                                child: Center(
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Image.asset("assets/time.png"),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 55,
                                  width: 3,
                                  child: Container(
                                    color: Colors.yellow,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 55.0,
                        child: InkWell(
                          onTap: () {
                            _showTime(context);
                          },
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Expanded(
                                flex: 3,
                                child: !time
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Horário",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w200),
                                          )
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Horário",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w200),
                                          ),
                                          Text(
                                            _horarios[timeSelected],
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          )
                                        ],
                                      ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Icon(Icons.chevron_right,
                                    color: Colors.grey),
                              )
                            ],
                          ),
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
