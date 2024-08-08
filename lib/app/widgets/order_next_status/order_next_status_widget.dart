import 'package:app_painel_hortifruti_pratico/app/data/models/next_status.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/order.dart';
import 'package:app_painel_hortifruti_pratico/app/data/models/order_status.dart';
import 'package:app_painel_hortifruti_pratico/app/modules/order_list/widgets/order_list/order_list.dart';
import 'package:flutter/material.dart';

typedef OnChangeStatus = void Function(int order);

class OrderNextStatusWidget extends StatelessWidget {
  final OnChangeStatus onChangeStatus;
  final OrderStatusModel currentStatus;
  OrderNextStatusWidget(this.currentStatus, this.onChangeStatus, {super.key});

  final nextStatusList = {
    1 : [
      NextStatus(2, 'Confirmar'),
      NextStatus(5, 'Recusar', isOk: false),
    ],
    2 : [
      NextStatus(3, 'Saiu para entrega'),
      NextStatus(5, 'Cancelar', isOk: false),
    ],
    3 : [
      NextStatus(4, 'Entregue'),
      NextStatus(5, 'Cancelar', isOk: false),
    ],
    4 : [
      NextStatus(4, 'Concluído'),
    ],
  };

  @override
  Widget build(BuildContext context) {
    var options = nextStatusList[currentStatus.id];

    if(options == null){
      return SizedBox();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(var nextStatus in options) ...[
          const SizedBox(width: 4),
          Visibility(
            visible: nextStatus.id == 4,
            replacement: OutlinedButton(
              onPressed: () => onChangeStatus(nextStatus.id),
              child: Text(nextStatus.text),
              style: OutlinedButton.styleFrom(
                foregroundColor: nextStatus.isOk ? Colors.green : Colors.red,
                side: BorderSide(color: nextStatus.isOk ? Colors.green : Colors.red)
              ),
            ),
            child: Container(
              child: Text(
                nextStatus.text,
                style: TextStyle(
                    color: Colors.blue
                ),
              ),
            ),
          )
        ]
      ],
    );
  }
}
