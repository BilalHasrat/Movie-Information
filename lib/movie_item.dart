import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {

  final String label;
  final String value;

  const MovieItem({Key? key,
    required this.label,
    required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.greenAccent.shade400,
      shadowColor: Colors.black.withOpacity(.9),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
            SizedBox(width: 10,),
            Expanded(
                child: Text(value,))

          ],
        ),
      ),
    )
    ;
  }
}
