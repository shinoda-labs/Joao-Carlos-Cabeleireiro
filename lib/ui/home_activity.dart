import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeActivity extends StatefulWidget {
  @override
  _HomeActivityState createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBackground() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            const Color.fromARGB(255, 20, 20, 20),
            const Color.fromARGB(255, 30, 30, 30)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        );

    Widget _tile(IconData icon, String text) {
      return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          elevation: 2.0,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(text, style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, ),)
                  ],
                )
                /*CircleAvatar(
                  backgroundColor: color,
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                )*/,
              )));
    }

    return Stack(
      children: <Widget>[
        _buildBodyBackground(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("João Carlos Cabelereiro"),
                centerTitle: true,
              ),
            ),
            SliverStaggeredGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              staggeredTiles: [
                StaggeredTile.count(2, 1),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(1, 2),
                StaggeredTile.count(1, 1),
                StaggeredTile.count(2, 1),
              ],
              children: <Widget>[
                _tile(Icons.donut_small, "Agendar Horário"),
                _tile(Icons.grade, "Meus Horários"),
                _tile(Icons.group_add, "Teste"),
                _tile(Icons.bug_report, "Teste"),
                _tile(Icons.opacity, "Teste")
              ],
            )
          ],
        )
      ],
    );
  }
}
