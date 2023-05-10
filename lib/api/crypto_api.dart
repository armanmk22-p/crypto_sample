


import 'package:crypto_application_git/model/crypto_model.dart';
import 'package:dio/dio.dart';


  Future<List<CryptoModel>> getCryptos() async{

    var response = await Dio().get('https://api.coincap.io/v2/assets');
    var cryptoList = (response.data['data'] as List).map((e) => CryptoModel.fromJson(e)).toList();
    return cryptoList;

  }
