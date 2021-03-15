import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
class Api extends StatefulWidget {
  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<Api> {

  Map<String, dynamic> data;
  var userData;


  Future getData() async {
    http.Response response = await http.get('https://reqres.in/api/users?page=2');
    setState(() {
      data = jsonDecode(response.body);
      userData = data;
    });
    // print(data['data']);
    print(data.length);

  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('API PAGE'),
        ),
        body: SafeArea(

          child: ListView.builder(
              itemCount: userData.length,
              itemBuilder: (BuildContext context,int index){
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 10,
                    child: Column(
                      children: [
                       ListTile(
                         leading: Text('ID :  ${data['data'][index]['id'].toString()}'),
                         title:  Text('  ${data['data'][index]['email'].toString()}'),
                         subtitle: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('  ${data['data'][index]['first_name'].toString()}'),
                    Text('  ${data['data'][index]['last_name'].toString()}'),
                  ],
                  ),
                         trailing:CircleAvatar(
                           radius: 18,
                           child: ClipOval(
                             child: Image.network('${data['data'][index]['avatar']}'),
                           ),
                         ),
                       ),


                      ],
                    ),
                  ),
                )
              ],
            );
          }),),
      ),
    );
  }
}
