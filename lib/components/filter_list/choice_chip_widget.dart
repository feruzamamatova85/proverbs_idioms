import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChoicechipWidget extends StatelessWidget {
  const ChoicechipWidget(
      {Key key,
      this.text,
      this.selected,
      this.selectedTextColor,
      this.unselectedTextColor,
      this.onSelected,
      this.unselectedTextBackgroundColor,
      this.selectedTextBackgroundColor})
      : super(key: key);

  final String text;
  final bool selected;
  final Function(bool) onSelected;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final Color unselectedTextBackgroundColor;
  final Color selectedTextBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(children: [
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:
                      selected ? Colors.white : Theme.of(context).primaryColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: selected ? Theme.of(context).primaryColor : null,
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
        ),
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: Image.asset(
                'assets/images/$text.JPG',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ChoiceChip(
                    backgroundColor: selected
                        ? selectedTextBackgroundColor
                        : unselectedTextBackgroundColor,
                    selectedColor: selected
                        ? selectedTextBackgroundColor
                        : unselectedTextBackgroundColor,
                    label: selected
                        ? Icon(
                            Icons.check_box_outlined,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.check_box_outline_blank,
                            color: Theme.of(context).primaryColor,
                          ),
                    selected: selected,
                    onSelected: onSelected),
              ),
            )
          ],
        )
      ]),
    );
  }
}
