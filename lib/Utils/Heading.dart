import 'package:flutter/material.dart';

class Heading extends StatefulWidget {
  final String songTypeTitle;
  final String songTypeButtonTitle;
  final bool? fullScreenTouch;
  final Function? fullScreenTouchFunction;
  final Function? buttonFunction;
  const Heading({super.key,required this.songTypeTitle,required this.songTypeButtonTitle, this.fullScreenTouch, this.fullScreenTouchFunction,this.buttonFunction});

  @override
  State<Heading> createState() => _HeadingState();
}

class _HeadingState extends State<Heading> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(widget.fullScreenTouch??false){
          widget.fullScreenTouchFunction?.call();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0)
            .copyWith(right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.songTypeTitle,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold)),
            InkWell(
              onTap: () {
                widget.buttonFunction?.call();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black26,
                    border: Border.all(color: Colors.white70)),
                child: Text(
                  widget.songTypeButtonTitle,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
