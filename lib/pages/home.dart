import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // ignore: always_specify_types
  Map data = {};

  @override
  Widget build(BuildContext context) {

    // ignore: always_specify_types
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments as Map;
    print(data);

    // ignore: unnecessary_statements
    String bgimage = data['isDatetime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDatetime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgimage'),
                fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: Column(
                children: [
                  FlatButton.icon(
                      onPressed: () async {
                        dynamic result = await Navigator.pushNamed(context, '/location');
                        setState(() {
                          data = {
                            'time': result['time'],
                            'location': result['location'],
                            'flag': result['flag'],
                            'isDatetime': result['isDatetime']
                          };
                        });
                      },
                      icon: Icon(
                        Icons.edit_location,
                        color: Colors.grey[300],
                      ),
                      label: Text(
                        'Edit Location',
                        style: TextStyle(
                          color: Colors.grey[300],
                        ),
                      ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['location'].toString(),
                        style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(
                    data['time'].toString(),
                    style: TextStyle(
                      fontSize: 66.0,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}
