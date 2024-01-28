import 'package:flutter/material.dart';

extension NextPage on BuildContext {
  Future toNextPage(BuildContext context, Widget nextPage) =>
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => nextPage));

  void navigateBack(BuildContext context,String success ) => Navigator.of(context).pop(success);
}

extension Adds on String{
  String addS(int length){
    if(length > 1){
      return "${this}s";
    }
    return this;
  }
}
