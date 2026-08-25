import 'package:app_e_commerce/shared/utils/responsive.dart';
import 'package:flutter/material.dart';

class SpecificGameScreen extends StatelessWidget {
  const SpecificGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              IconButton(
                onPressed: null,
                icon: Icon(Icons.arrow_back, color: Colors.black),
              ),
              Padding(
                padding: EdgeInsets.all(context.padding),
                child: Container(
                  width: context.containerGameWidth,
                  // color: Colors.indigo,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: context.spacing,
                    children: [
                      Center(
                        child: Container(
                          height: context.imageGameWidth,
                          width: context.imageGameWidth,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 233, 233, 233),
                                const Color.fromARGB(255, 223, 218, 218),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.amber,

                        child: Text(
                          "BATMAN Arkham City",
                          style: TextStyle(
                            fontSize: context.textTitleSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.brown,

                        child: Text(
                          "Platforme: PC, XBOX Serie S, PS5",
                          style: TextStyle(fontSize: context.bodyFontSize),
                        ),
                      ),
                      Row(
                        spacing: 200,
                        children: [
                          Container(
                            color: Colors.red,
                            height: 50,
                            child: Text(
                              "Price: 15000 Ar",
                              style: TextStyle(fontSize: context.bodyFontSize),
                            ),
                          ),
                          Container(
                            color: Colors.green,
                            height: 50,
                            child: Text(
                              "Stock: 100",
                              style: TextStyle(fontSize: context.bodyFontSize),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.blue,
                        // height: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Descritpion",
                              style: TextStyle(
                                fontSize: context.bodyFontSize,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Wrap(
                              children: [
                                Text(
                                  "fdsj kdfs lfjdsk qjlmfjdksljqkjfdksfj fkldsfj kldsjfklsqmj fkldsjmqf skql mjkl mjkqlsjd fkdlqjsk ljqk lsjskl jlj fqkdlsfjlsdf",
                                  style: TextStyle(
                                    fontSize: context.bodyFontSize,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: context.buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                          ),
                          child: Text("Ajouter au panier"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
