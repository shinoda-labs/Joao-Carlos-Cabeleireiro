import 'package:flutter/material.dart';
import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:joao_carlos_cabelereiro/model/new_schedule_model.dart';
import 'package:scoped_model/scoped_model.dart';

class NewHomeActivity extends StatefulWidget {
  @override
  _NewHomeActivityState createState() => _NewHomeActivityState();
}

class _NewHomeActivityState extends State<NewHomeActivity> {
  @override
  bool service = false;
  //bool barber = false;
  bool date = false;
  bool time = false;

  //String _barber;
  String _time;
  String _service;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime _date = new DateTime.now();

  //###################### FUNÇÃO SELECIONAR DATA ######################
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

  //###################### FUNÇÃO SELECIONAR HORÁRIO ######################
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
                    SizedBox(height: 8.0),
                    FutureBuilder<QuerySnapshot>(
                      future: Firestore.instance
                          .collection("schedules")
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
                                      "Sem horários disponiveis no momento!",
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
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        childAspectRatio: 2.7),
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) {
                                  //CHECA SE O HORARIO JA ESTA RESERVADO OU NAO
                                  /*return StreamBuilder(
                                    stream: Firestore.instance
                                        .collection("schedule")
                                        .document(formatDate(
                                            _date, [dd, "/", mm, "/", yyyy]))
                                        .collection(snapshot
                                            .data.documents[index].data["hour"])
                                        .document(snapshot
                                            .data.documents[index].data["hour"])
                                        .snapshots(),
                                    builder: (context, snap) {*/
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        time = true;
                                        _time = snapshot
                                            .data.documents[index].data["hour"];
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        //color: snap.hasData ? Colors.red: Colors.green,
                                        color: Colors.green,
                                        child: Padding(
                                          padding: EdgeInsets.all(4),
                                          child: Center(
                                            child: Text(
                                              snapshot.data.documents[index]
                                                  .data["hour"],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                  /*},
                                  );*/
                                },
                              );
                            }
                        }
                      },
                    ),
                    SizedBox(height: 8.0),
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

  //###################### FUNÇÃO SELECIONAR SERVIÇOS ######################
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
                    SizedBox(height: 8.0),
                    FutureBuilder<QuerySnapshot>(
                      future: Firestore.instance
                          .collection("services")
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
                                      "Sem serviços disponiveis no momento!",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w200),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      setState(() {
                                        service = true;
                                        _service = snapshot.data
                                            .documents[index].data["title"];
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    leading: CircleAvatar(
                                      radius: 25.0,
                                      backgroundColor: Colors.yellow,
                                      backgroundImage: NetworkImage(snapshot
                                          .data.documents[index].data["image"]),
                                    ),
                                    title: Text(
                                      snapshot
                                          .data.documents[index].data["title"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                    trailing: Column(
                                      children: <Widget>[
                                        Text(
                                          "R\$${snapshot.data.documents[index].data["price"]}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                            "${snapshot.data.documents[index].data["time"]} min")
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                        }
                      },
                    ),
                    SizedBox(height: 8.0),
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

  //###################### METODO PARA MOSTRAS AS SNACKBAR ######################
  void _showSnackbar(String text, Color color, int seconds) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
      duration: Duration(seconds: seconds),
    ));
  }

  //###################### METODO QUANDO DA SUCESSO AO AGENDAR O HORARIO ######################
  void _onSuccess() {
    _showSnackbar("Horário agendado com sucesso!", Colors.green, 5);
    setState(() {
      service = false;
      date = false;
      time = false;
    });
  }

  //###################### METODO QUANDO DA ERRO AO AGENDAR O HORARIO ######################
  void _onFail() {
    _showSnackbar("Falha ao agendar seu horário. Tente novamente mais tarde!",
        Colors.red, 3);
  }

  Widget build(BuildContext context) {
    return ScopedModel<NewScheduleModel>(
      model: NewScheduleModel(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("João Carlos Cabeleireiro"),
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
                                      child: Image.asset(
                                          "assets/barber_chair.png"),
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
                              _showService(context);
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
                                              _service,
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
                              service
                                  ? _selectDate(context)
                                  : _showSnackbar(
                                      "Selecione um serviço para escolher a data",
                                      Colors.green,
                                      3);
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
                              date
                                  ? _showTime(context)
                                  : _showSnackbar(
                                      "Selecione uma data para escolher o horário",
                                      Colors.green,
                                      3);
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
                                              _time,
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
                //###################### BOTÃO AGENDAR ######################
                SizedBox(height: 5.0),
                SizedBox(
                  width: 200.0,
                  child: ScopedModelDescendant<NewScheduleModel>(
                    builder: (context, child, model) {
                      if (model.isLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return RaisedButton(
                          onPressed: () {
                            if (service && date && time) {
                              model.savesSchedule(
                                  service: _service,
                                  date: formatDate(
                                      _date, [dd, ".", mm, ".", yyyy]),
                                  time: _time,
                                  onFail: _onFail,
                                  onSuccess: _onSuccess);
                            } else {
                              _showSnackbar(
                                  "Escolha um serviço, data e um horário para agendar!",
                                  Colors.yellow,
                                  3);
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)),
                          padding: EdgeInsets.all(16),
                          color: Colors.yellow,
                          child: Text(
                            "Agendar",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 18.0),
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
