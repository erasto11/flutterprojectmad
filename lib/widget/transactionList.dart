import 'package:flutter/material.dart';
import '../moder/transaction.dart';
import 'package:intl/intl.dart';
class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTransaction;
  TransactionList(this.transaction, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return  transaction.isEmpty?
      Column(children: [
        Text('you have no any transaction',style: Theme.of(context).textTheme.title,),
        SizedBox(height:10 ,),
        Container(
          height: 300,
          child: Image.asset('assets/images/waiting.png',fit: BoxFit.cover,)),
      ],)
      : ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
            child: ListTile(
              
              leading:CircleAvatar(radius: 40,child: Padding(
                padding: const EdgeInsets.all(6),
                child: FittedBox(child: Text('\$${transaction[index].amount}')),
              ),),
               title:Text(transaction[index].title, style: Theme.of(context).textTheme.title,),
               subtitle: Text(DateFormat.yMMMEd().format(transaction[index].date1),
          
            ),
            trailing: IconButton(icon:Icon(Icons.delete),color: Theme.of(context).errorColor,onPressed: ()=>deleteTransaction(transaction[index].id),),
            ),
          );
        },
        itemCount: transaction.length,
      );
    
    
  }
}
