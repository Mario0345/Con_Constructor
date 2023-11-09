
import 'package:flutter/material.dart';

import '../core/values/icons.dart';
import '../core/values/colors.dart';

List<Icon> getIcons(){

 return const [

  Icon(IconData(oneIcon, fontFamily: 'MaterialIcons'), color: purple),

  Icon(IconData(twoIcon, fontFamily: 'MaterialIcons'), color: pink),

  Icon(IconData(threeIcon, fontFamily: 'MaterialIcons'), color: green),

  Icon(IconData(fourIcon, fontFamily: 'MaterialIcons'), color: yellow),

  Icon(IconData(fiveIcon, fontFamily: 'MaterialIcons'), color: deepPink),

  Icon(IconData(sixIcon, fontFamily: 'MaterialIcons'), color: lightBlue),

  Icon(IconData(sevenIcon, fontFamily: 'MaterialIcons'), color: Colors.blueAccent),

  Icon(IconData(eightIcon, fontFamily: 'MaterialIcons'), color: Colors.indigo),

 ];
}