import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/transaction_list.dart';
import './models/transactions.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /* //To not switch to landscape use this code below
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  */
  runApp(HomeApp());
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.deepPurpleAccent,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              button: TextStyle(
                color: Colors.purpleAccent,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'QuickSand',
                  fontSize: 22,
                  fontWeight: FontWeight.w100,
                ),
              ),
        ),
      ),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transactions> transactionList = [];
  bool _switch = true;

  List<Transactions> get chartTransaction {
    return transactionList.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (context) {
          return NewTransaction(addTransaction: addTransaction);
        });
  }

  void addTransaction(String title, double amount, DateTime cusDate) {
    String id = DateTime.now().toString();
    DateTime date = cusDate;
    Transactions tx =
        Transactions(id: id, title: title, amount: amount, date: date);
    print(transactionList.length);
    setState(() {
      transactionList.add(tx);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      transactionList
          .removeWhere((element) => (id == element.id) ? true : false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _landScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('X_pense'),
      titleTextStyle: Theme.of(context).textTheme.headline6,
      actions: [
        Builder(
          builder: (context) => IconButton(
              icon: Icon(Icons.add),
              onPressed: () => startAddNewTransaction(context)),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_landScape)
              Row(
                children: [
                  Text('Show Chart'),
                  Switch(
                      value: _switch,
                      onChanged: (val) {
                        setState(() {
                          _switch = val;
                        });
                      }),
                ],
              ),
            if (!_landScape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.4,
                child: Chart(chartTransaction),
              ),
            if (!_landScape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.6,
                child: TransactionList(
                  userTransactions: transactionList,
                  deleteTransaction: deleteTransaction,
                ),
              ),
            if (_landScape)
              _switch
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.4,
                      child: Chart(chartTransaction),
                    )
                  : Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.6,
                      child: TransactionList(
                        userTransactions: transactionList,
                        deleteTransaction: deleteTransaction,
                      ),
                    ),
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => startAddNewTransaction(context)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
