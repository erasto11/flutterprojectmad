import 'package:flutter/material.dart';
import'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleControll = TextEditingController();
  final amountControll = TextEditingController();
  DateTime _selectedDate=DateTime.now();

  void addNw() {
    if(amountControll.text.isEmpty){
      return;
    }
    final titleIn = titleControll.text;
    final amountIn = double.parse(amountControll.text);
    if (titleIn.isEmpty || amountIn <= 0 || _selectedDate==null) {
      return;
    }
    widget.addNewTransaction(
      titleIn,
      amountIn,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePiker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate){
     if (pickedDate==null){
       return;
     }
     _selectedDate=pickedDate;
    });

    }
  

  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'title'),
              controller: titleControll,
              onSubmitted: (_) => addNw(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'amount'),
              controller: amountControll,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => addNw(),
            ),
            Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(child: Text(_selectedDate==null? 'no date selected': 'picked date: ${DateFormat.yMd().format(_selectedDate)}')),
                     FlatButton(
                          textColor: Theme.of(context).primaryColor,
                          child: Text('add date',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          onPressed: _presentDatePiker),
                    
                  ],
                )),
            RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                //textColor: Theme.of(context).textTheme.button.color,
                textColor: Colors.white,
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
