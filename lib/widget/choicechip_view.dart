import 'package:flutter/material.dart';

import '../utilities/callback.dart';

class ChoiceChipView extends StatefulWidget {
  final List<Map<String, dynamic>> list;
  final List<String> selectedChoices;
  final int index;
  final Callback callback;

  const ChoiceChipView({Key? key, required this.list, required this.selectedChoices, required this.index, required this.callback}) : super(key: key);

  @override
  State<ChoiceChipView> createState() => _ChoiceChipViewState();
}

class _ChoiceChipViewState extends State<ChoiceChipView> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      backgroundColor: Colors.white,
      selectedColor: Color(0xff2AAB34),
      labelPadding: const EdgeInsets.only(left: -1,right: 5,top: -1,bottom: -1),
      labelStyle: widget.selectedChoices.contains(widget.list.elementAt(widget.index)['name']) ? TextStyle(
          fontSize: 12,
          color: Colors.white,
      ) : TextStyle(fontSize: 12.0,color: Color(0x7E000000)),
      shape: StadiumBorder(side: BorderSide(color: widget.selectedChoices.contains(widget.list.elementAt(widget.index)['name']) ? Color(0xff2AAB34) : Colors.grey)),
      selectedShadowColor: Color(0xff2AAB34),
      avatar: widget.selectedChoices.contains(widget.list.elementAt(widget.index)['name']) ? Image.asset("assets/images/tick.png",height: 13,width: 13,color: Colors.white,) : const Icon(Icons.add,size: 15,color: Colors.grey,),
      label: Text(widget.list.elementAt(widget.index)['name']),
      selected: widget.selectedChoices.contains(widget.list.elementAt(widget.index)['name']),
      onSelected: (bool selected) {
        setState(() {
          if(widget.selectedChoices.contains(widget.list.elementAt(widget.index)['name'])){
            widget.callback(0);
            //selectedOrderTimeChoices.remove(AppConstants.orderFilterTimeData.elementAt(index)['name']);
          }else{
            widget.callback(1);
          }
        });
        //newData.value = !newData.value;
      },
    );
  }
}