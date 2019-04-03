import 'package:flutter/material.dart';

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

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                      child: Center(
                        child: Text("Aqui vai aparecer algo"),
                      ),
                    )
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
        title: Text("teste"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: <Widget>[
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
                              _showOptions(context);
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
                            setState(() {
                              _showOptions(context);
                              barber = true;
                            });
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
                                            "Cabelereiro",
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
                                            "Cabelereiro",
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w200),
                                          ),
                                          Text(
                                            "João Carlos Barbosa",
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
                            setState(() {
                              _showOptions(context);
                              date = true;
                            });
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
                                            "04/08/2019",
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
                            setState(() {
                              _showOptions(context);
                              time = true;
                            });
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
                                            "17:30",
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
