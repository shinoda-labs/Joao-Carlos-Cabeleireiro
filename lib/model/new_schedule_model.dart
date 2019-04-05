import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';

class NewScheduleModel extends Model {
  bool isLoading = false;

  Future<Null> savesSchedule(
      {@required String service,
      @required String date,
      @required String time,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    Map<String, dynamic> schedule;
    schedule = {"service": service, "date": date, "time": time};

    

    await Firestore.instance.collection("schedule").document(date).collection(time).document(time).setData(schedule)
        .then((_) async {
      isLoading = false;
      onSuccess();
      notifyListeners();
    }).catchError((e) {
      print("Erro ao agendar o horário: ${e}");
      isLoading = false;
      notifyListeners();
    });
  }
}
