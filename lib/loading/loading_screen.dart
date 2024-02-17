

import 'dart:async';

import 'package:english_learning_app/loading/loading_screen_controller.dart';
import 'package:flutter/material.dart';

class LoadingScreen
{

  LoadingScreen._sharedInstance();
  static late final _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;


  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    required String text,
  })
  {
     if (_controller?.update(text) ?? false)
     {
      return;
     }
     else
     {
       _controller = _showOverlay(context: context,
        text: text);
     }
  }

  void hide()
  {
    _controller?.close();
    _controller = null;
  }


  LoadingScreenController _showOverlay(
    {
      required BuildContext context,
      required String text,
    }
  )
  {
    final _text = StreamController<String>();
    _text.add(text);

    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(builder: (context)
    {
      return Material(
        color: Colors.black.withOpacity(0.8),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: size.width * 0.8,
              maxHeight: size.height * 0.8,
              minWidth: size.width * 0.5,
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.green,width: 3),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    const CircularProgressIndicator(color: Colors.green,),
                    const SizedBox(
                      height: 20,
                    ),
                    StreamBuilder<String>(stream: _text.stream, builder: (context,snapshot) 
                    {
                      if (snapshot.hasData)
                      {
                        return Text(snapshot.data!,textAlign: TextAlign.center,);
                      }
                      else
                      {
                        return Container();
                      }
                    })
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });

    state.insert(overlay);

    return LoadingScreenController(
      update: (text)
      {
        _text.add(text);
        return true;
      }, close: ()
      {
        _text.close();
        overlay.remove();
        return true;
      });
  
  }

}