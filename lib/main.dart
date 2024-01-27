//import 'dart:ffi';

import 'package:flutter/material.dart';


//Made for Assignment 1 for MAPD 722 - By Rahul Edirisinghe

//REFERENCES USED:
//https://docs.flutter.dev/cookbook/forms/retrieve-input
//https://stackoverflow.com/questions/65931281/change-widgets-text-dynamically-flutter-dart
//https://www.youtube.com/watch?v=ccHt0cfDsOM
//https://stackoverflow.com/questions/52774921/space-between-columns-children-in-flutter
//https://docs.flutter.dev/cookbook/forms/validation
//https://www.flutterbeads.com/card-border-in-flutter/#How-to-add-border-to-a-card-in-Flutter


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: MainStructure()
        ),
      ),
    );
  }
}

class MainStructure extends StatelessWidget {
  const MainStructure({super.key});
   
  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          color: Colors.white70,
          child: const Column(
      children:[
        //InputHours(),
        //InputRate(),
        PayCalcInputForm(),
        IDPart()
      ]
      ),
    );
  }
}

//ID Part Name and ID
class IDPart extends StatelessWidget {
  const IDPart({super.key});

  @override 
  Widget build(BuildContext context){
    return const Card(
          color: Colors.white38,
          child: 
          Padding(padding: EdgeInsets.all(25), child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Name: Rahul Edirisinghe', style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold
              ),),
              Text('College ID: 301369991', style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold
              ),)
            ],
          ),
        )
    );
  }
}

//Main Part: Calculator
class PayCalcInputForm extends StatefulWidget {
  const PayCalcInputForm({super.key});

  @override
  State<PayCalcInputForm> createState() => CreatePayCalcInputForm();
}

class CreatePayCalcInputForm extends State<PayCalcInputForm>{

  //final isvalidFormKey = GlobalKey<FormState>();
  final hoursTextValueController = TextEditingController();
  final rateTextValueController = TextEditingController();
  var totalValue = "--.-";
  var regularValue = "--.-";
  var overtimeValue = "--.-";
  var taxValue = "--.-";

  @override
  Widget build(BuildContext context){
    return //Form(key: isvalidFormKey,child: 
    Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 70,),
                TextFormField(
                  // validator: (value){
                  //   if(value == null || value.isEmpty){
                  //     return 'Hours Value cannot be Empty';
                  //   }else{
                  //     return null;
                  //   }
                  // },
                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Number of Hours',
                    ), 
                    controller: hoursTextValueController,
                    keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  // validator: (value){
                  //   if(value == null || value.isEmpty){
                  //     return 'Rate Value cannot be Empty';
                  //   }else{
                  //     return null;
                  //   }
                  // },
                    decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Hourly Rate',
                    ), 
                    controller: rateTextValueController,
                    keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20,),
                ElevatedButton(onPressed: (){calculatePay();}, style: ButtonStyle( padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
                const EdgeInsets.fromLTRB(70, 10, 70, 10)),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)//?
                ) ,child: const Text('Calculate', style: TextStyle(fontSize: 18, color: Colors.black),)),
                const SizedBox(height: 20,),
                Card(
                  shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.black, width: 4),),
                  child: Padding(padding: const EdgeInsets.all(12), child: Column( children: [
                    const Text("Report", style: TextStyle(fontSize: 25, color: Colors.black)),
                    Text(regularValue, style: const TextStyle(fontSize: 20, color: Colors.black)),
                    Text(overtimeValue, style: const TextStyle(fontSize: 20, color: Colors.black)),
                    Text(totalValue, style: const TextStyle(fontSize: 20, color: Colors.black)),
                    Text(taxValue, style: const TextStyle(fontSize: 20, color: Colors.black)),
                ])))
              ],
          ),
      );
    //);
}

  void calculatePay(){
    var hours = 0.0; //double.parse(hoursTextValueController.text);
    var rate = 0.0; //double.parse(rateTextValueController.text);
    var total = 0.0;
    var tax = 0.0;

    if((hoursTextValueController.text).isEmpty || (rateTextValueController.text).isEmpty){
      showDialog(
            context: context,
            builder: (context) { return
      const AlertDialog(content: Text('Enter Values for Both Fields'),);});
    }else{
      try{
        hours = double.parse(hoursTextValueController.text);
        rate = double.parse(rateTextValueController.text);
        if( hours  > 40){
          total = ((hours - 40)*rate)*1.5 + 40.0*rate;
          tax = total*0.18;
          setState(() {
            totalValue = "Total Pay: $total";
            taxValue = "Taxed Amount: $tax";
            overtimeValue = "Overtime Pay: ${total - (40*rate)}";
            regularValue = "Regular Pay: ${40*rate}";
          });
        }else{
          total = rate*hours;
          tax = total*0.18;
          setState(() {
            totalValue = "Total Pay: $total";
            taxValue = "Taxed Amount: $tax";
            overtimeValue = "Overtime Pay: 0.0";
            regularValue = "Regular Pay: $total";
          });
        }
      }catch(e){
        showDialog(
              context: context,
              builder: (context) { return
              AlertDialog(content: const Text('Error Occured: Enter Numeric Values'),actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],);
              }
        );
      }
    }
}
}