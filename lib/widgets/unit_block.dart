import 'dart:ffi';
import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/models/training_unit.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart';

@immutable
class UnitBlock extends StatelessWidget
{
  final int index;
  final Color color;

  const UnitBlock({required bool isPointGained, required this.index}) : color = isPointGained ? applicationColor : Colors.red;

  @override
  Widget build(BuildContext context)
  {
    return Container(
      width: MediaQuery.of(context).size.width * 0.08,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        shape: BoxShape.rectangle,
      ),
      child: Text(index.toString(),style: applicationBlackTextStyle(10),),
    );
  }

}



Widget buildGrid(List<TrainingUnit> list)
{
  print(list.length);


  List<Row> rows = [];
  for(int i =0; i<5; i++)
  {
    List<UnitBlock> unitBlocks = [];
    for (int j=0; j<10;j++)
    {
      unitBlocks.add(UnitBlock(isPointGained: list[i*10+j].isPointGained, index: i*10+j+1));
    }

    rows.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: unitBlocks,
    ));

  }
 
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: rows,
  );
}