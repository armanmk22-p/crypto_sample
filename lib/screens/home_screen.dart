import 'package:crypto_application_git/theme/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../api/crypto_api.dart';
import '../model/crypto_model.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CryptoModel> cryptoList =[];
  bool _isListUpdated = false;
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    _getCryptoList();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crypto Assets',
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
           onPressed: (){
             setState(() {
               if(isDark == false){
                 isDark = true;
               }else{
                 isDark = false;
               }
             });
            BlocProvider.of<ThemeCubit>(context).themeChanges(isDark);
           },
            icon: Icon(
              Icons.nightlight,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body:Column(
        children: [
          _getSearchTextField(),
          Visibility(
              visible: _isListUpdated,
              child: Text(
                'Updating The List ...',
                style: Theme.of(context).textTheme.titleSmall,
              )),
          Padding(
            padding: EdgeInsets.only(left: 18, right: 40, bottom: 12, top: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Assets',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Change(24H)',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 14),
                )
              ],
            ),
          ),
          Expanded(
              child: RefreshIndicator(
                  backgroundColor: Colors.green,
                  color: Colors.white,
                  child:ListView.separated(
                    itemCount: cryptoList.length,
                    itemBuilder: (context, index) {
                      return _getListTileItems(cryptoList[index]);
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                  onRefresh: () async {
                    return _getCryptoList();
                  })),
        ],
      ),
    );
  }

  Future<void> _getCryptoList() async {
    try {
      List<CryptoModel> _cryptoList = await getCryptos();
      setState(() {
        cryptoList = _cryptoList;
      });
    } catch (e) {
      Center(
        child: Text(
          'Something Went Wrong',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
    }
  }

  Widget _getListTileItems(CryptoModel cryptoModel) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailsScreen(cryptoModel: cryptoModel),
      )),
      child: ListTile(
        leading: SizedBox(
          width: 28,
          child: Center(
            child: Text(
              cryptoModel.rank.toString(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        title: Text(
          cryptoModel.symbol,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
          cryptoModel.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: _getTrailingRow(cryptoModel),
      ),
    );
  }

  Widget _getTrailingRow(CryptoModel cryptoModel) {
    return SizedBox(
      width: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$' + cryptoModel.priceUsd.toStringAsFixed(2),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontSize: 14),
              ),
              SizedBox(height: 6),
              Text(
                cryptoModel.changePercent24Hr.toStringAsFixed(2),
                style: TextStyle(
                  color:
                      _getChangePercentColor24Hr(cryptoModel.changePercent24Hr),
                ),
              ),
              SizedBox(
                width: 40,
                child: Center(
                  child: _getIconChangeColor(cryptoModel.changePercent24Hr),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _getIconChangeColor(num changePercent) {
    return changePercent <= 0
        ? Icon(
            Icons.trending_down,
            color: Colors.red,
          )
        : Icon(
            Icons.trending_up,
            color: Colors.green,
          );
  }

  _getChangePercentColor24Hr(num changePercent) {
    return changePercent <= 0 ? Colors.red : Colors.green;
  }

  Widget _getSearchTextField() {
    return Padding(
      padding: EdgeInsets.all(4),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(width: 0, style: BorderStyle.none)),
          contentPadding: EdgeInsets.all(12),
          hintText: 'search your cryptoCurrency ...',
          hintStyle: TextStyle(fontSize: 16, color: Color(0XFFE0F2F1)),
          filled: true,
          fillColor: Color.fromARGB(255, 17, 118, 88),
        ),
        onChanged: (value) => _onSearchAction(value),
      ),
    );
  }

  Future<void> _onSearchAction(String searchKey) async {
    List<CryptoModel> filteredList = [];
    if (searchKey.isEmpty) {
      setState(() {
        _isListUpdated = true;
      });

      List<CryptoModel> _updatedList = await getCryptos();
      setState(() {
        cryptoList = _updatedList;
        _isListUpdated = false;
      });

      FocusScope.of(context).unfocus();
      return;
    }

    filteredList = cryptoList!
        .where((element) =>
            element.name.toLowerCase().contains(searchKey.toLowerCase()))
        .toList();
    setState(() {
      cryptoList = filteredList;
    });
  }
}
