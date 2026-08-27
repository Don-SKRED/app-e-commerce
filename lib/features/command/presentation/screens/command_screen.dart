import 'package:app_e_commerce/shared/utils/responsive.dart';
import 'package:flutter/material.dart';

class CommandScreen extends StatelessWidget {
  const CommandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.padding,
            vertical: context.spacing,
          ),
          child: Center(
            child: SizedBox(
              width: context.containerGameWidth,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(context.padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Commande n°1044",
                            style: TextStyle(
                              fontSize: context.textTitleSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Date: 23-03-2026",
                            style: TextStyle(
                              fontSize: context.bodyFontSize - 2,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.fieldSpacing * 2),
                      const Divider(),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return const CardCommand();
                        },
                        separatorBuilder: (contextSeparated, indexSeparated) {
                          return const Divider();
                        },
                        itemCount: 3,
                      ),
                      const Divider(height: 20, color: Colors.grey),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.fieldSpacing,
                          vertical: context.fieldSpacing,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Total : ",
                              style: TextStyle(
                                fontSize: context.textTitleSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "120000 F",
                              style: TextStyle(
                                fontSize: context.textTitleSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardCommand extends StatelessWidget {
  const CardCommand({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: context.fieldSpacing,
        vertical: context.fieldSpacing / 2,
      ),
      leading: Icon(
        Icons.sports_esports,
        size: context.imageGameWidth * 0.15,
        color: Colors.purple,
      ),
      title: Text(
        "PlayStation 5",
        style: TextStyle(
          fontSize: context.bodyFontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        "300 € × 2",
        style: TextStyle(fontSize: context.bodyFontSize - 2),
      ),
      trailing: Text(
        "600 €",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: context.bodyFontSize,
          color: Colors.purple,
        ),
      ),
    );
  }
}
