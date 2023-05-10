

import 'package:crypto_application_git/model/crypto_model.dart';
import 'package:flutter/cupertino.dart';

class DetailsScreen extends StatefulWidget {
  final CryptoModel cryptoModel;
  const DetailsScreen({Key? key,required this.cryptoModel}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
