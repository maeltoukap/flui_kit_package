import 'package:flui_kit/flui_kit.dart';
import 'package:flutter/material.dart';

class AccordionExample extends StatelessWidget {
  AccordionExample({super.key});

  AccordionTheme accordionTheme = AccordionTheme(
    titleStyle: const TextStyle(),
    childStyle: const TextStyle(),
    titleBackgroundColor: Colors.white,
    childBackgroundColor: Colors.white,
    arrowColor: Colors.grey,
    borderRadius: BorderRadius.circular(8),
    borderWidth: 1,
    borderColor: Colors.grey,
    backgroundColor: Colors.white,
    padding: const EdgeInsets.all(0),
    margin: const EdgeInsets.all(0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accordion example app'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Accordion(
          children: [
            AccordionItem(
              value: 'item1',
              title: 'Item 1',
              child: 'Contenu de l\'item 1',
            ),
            AccordionItem(
              value: 'item2',
              title: 'Item 2',
              child: 'Contenu de l\'item 2',
            ),
            AccordionItem(
              value: 'item3',
              title: 'Item 3',
              child: 'Contenu de l\'item 3',
            ),
          ],
          initialValue: "first",
          theme: accordionTheme,
        ),
      ),
      // ),
    );
  }
}
