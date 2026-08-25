import 'package:app_e_commerce/shared/utils/responsive.dart';
import 'package:flutter/material.dart';

class SpecificConsoleScreen extends StatelessWidget {
  const SpecificConsoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // heightFactor: 0,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: context.padding,
                  right: context.padding,
                ),
                child: Container(
                  width: context.containerGameWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: context.spacing,
                    children: [
                      Container(
                        height: context.heightContainerConsole,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 233, 233, 233),
                              const Color.fromARGB(255, 223, 218, 218),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(200),

                            bottomRight: Radius.circular(200),
                          ),
                        ),
                        child: Center(
                          child: Container(
                            color: Colors.purple,
                            height: context.consoleImageSize,
                            width: context.consoleImageSize,
                          ),
                        ),
                      ),
                      Center(
                        child: SizedBox(
                          child: Column(
                            children: [
                              Container(
                                color: Colors.amber,

                                child: Row(
                                  spacing: context.spacingRow,
                                  children: [
                                    Text(
                                      "Nom console",
                                      style: TextStyle(
                                        fontSize: context.textTitleSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "storage capacity",
                                      style: TextStyle(
                                        fontSize: context.bodyFontSize,
                                      ),
                                    ),
                                  ],
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
                                      style: TextStyle(
                                        fontSize: context.bodyFontSize,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.green,
                                    height: 50,
                                    child: Text(
                                      "Stock: 100",
                                      style: TextStyle(
                                        fontSize: context.bodyFontSize,
                                      ),
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
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          "Descritpion fdsj kdfs lfjdsk qjlmfjdksljqkjfdksfj fkldsfj kldsjfklsqmj fkldsjmqf skql mjkl mjkqlsjd fkdlqjsk ljqk lsjskl jlj fqkdlsfjlsdf",
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
              IconButton(
                onPressed: null,
                icon: Icon(Icons.arrow_back, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
