import 'package:flutter/material.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onTap: (){

          },
          child: Container(
            alignment: Alignment.center,
            width: 150,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.deepPurple
            ),
            child:  const Text("Check Out",style: TextStyle(
              color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold
            ),),
          ),
        ),
      ),
    );
  }
}
