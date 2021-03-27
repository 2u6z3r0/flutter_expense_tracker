import 'package:universal_platform/universal_platform.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.orangeAccent,
        textTheme: GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme)
            .copyWith(
          headline6:
              GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        appBarTheme: AppBarTheme.of(context).copyWith(
          textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)
              .copyWith(
            headline6:
                GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        id: DateTime.now().toString(),
        date: txDate);
    setState(() {
      _transactions.add(newTx);
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(_addTransaction);
        });
  }

  void _deleteTx(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Widget> _buildPotrait(_chartWidget, _txListWidget) {
    return [_chartWidget, _txListWidget];
  }

  List<Widget> _buildLandscape(_chartWidget, _txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Show Chart'),
          Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              }),
        ],
      ),
      _showChart ? _chartWidget : _txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandscape = mediaQuery.orientation == Orientation.landscape;
    final _appBar = AppBar(
      title: const Text(
        'Expense Tracker',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _startNewTransaction(context);
          },
        )
      ],
    );

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              _appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_transactions, _deleteTx),
    );

    final chartWidget = Container(
      height: (mediaQuery.size.height -
              _appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.3,
      child: Chart(_recentTransactions),
    );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: UniversalPlatform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                _startNewTransaction(context);
              },
            ),
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_isLandscape) ..._buildLandscape(chartWidget, txListWidget),
            if (!_isLandscape) ..._buildPotrait(chartWidget, txListWidget),
          ],
        ),
      ),
    );
  }
}
