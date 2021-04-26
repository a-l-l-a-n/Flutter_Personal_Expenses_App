import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spentAmount;
  final double totalSpendingAmount;

  ChartBar(this.label, this.spentAmount, this.totalSpendingAmount);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Column(
          children: [
            SizedBox(height: 7),
            Container(
              height: constraint.maxHeight * 0.05,
              child: FittedBox(
                child: Text('\$${spentAmount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(height: constraint.maxHeight * 0.05),
            Container(
                height: constraint.maxHeight * 0.55,
                width: constraint.maxWidth * 0.3,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2.0),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FractionallySizedBox(
                        heightFactor: totalSpendingAmount,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        )),
                  ],
                )),
            SizedBox(height: constraint.maxHeight * 0.05),
            Container(
              height: constraint.maxHeight * 0.05,
              child: FittedBox(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
