import 'dart:async';
import 'dart:math';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DragAndDropDemo extends StatelessWidget {
  const DragAndDropDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [DraggableObject(), DraggableObjectTarget()],
    );
  }
}

class DraggableObject extends StatefulWidget {
  const DraggableObject({super.key});

  @override
  State<DraggableObject> createState() => _DraggableObjectState();
}

class _DraggableObjectState extends State<DraggableObject> {
  Widget CardBase() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      width: 68.4,
      height: 102.4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      child: UnoCard('assets/uno/images/blue0.png'),
      feedback: UnoCard('assets/uno/images/blue0.png'),
      childWhenDragging: CardBase(),
      data: Colors.orange,
      onDragStarted: () {
        debugPrint('onDragStarted(), 開始拖動');
      },
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        debugPrint('onDraggableCanceled(), 被放掉＋沒被接受');
      },
      onDragCompleted: () {
        debugPrint('onDragCompleted(), 被放掉＋接受');
      },
      onDragEnd: (DraggableDetails details) {
        debugPrint('onDragEnd(), 被放掉');
      },
    );
  }
}

class DraggableObjectTarget extends StatefulWidget {
  const DraggableObjectTarget({super.key});

  @override
  State<DraggableObjectTarget> createState() => _DraggableObjectTargetState();
}

class _DraggableObjectTargetState extends State<DraggableObjectTarget> {
  var _targetColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 200,
          height: 200,
          color: _targetColor,
        );
      },
      onWillAcceptWithDetails: (DragTargetDetails detail) {
        return true;
      },
      onAcceptWithDetails: (DragTargetDetails data) {
        setState(() {
          _targetColor = Colors.pink;
        });
      },
    );
  }
}

class UnoCard extends StatelessWidget {
  String cardAsset;
  UnoCard(this.cardAsset, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: Image(
        width: 68.4,
        height: 102.4,
        image: AssetImage(cardAsset),
        fit: BoxFit.cover,
      ),
    );
  }
}

class PlayingUnoCardState extends StatelessWidget {
  const PlayingUnoCardState(this.card, {super.key});
  final UnoCard card;

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: card,
      data: PlayingCardInfo(),
      child: card,
    );
  }
}

class BoardState {
  List<UnoCard> allCards = [];
}

@immutable
class PlayingCardInfo {
  final UnoCard card;
  const PlayingCardInfo(this.card);
}

class Player extends ChangeNotifier {
  static const maxCards = 7;

  // final List<UnoCard> handcards =
  //     List.generate(maxCards, (index) => UnoCard.random());

  // void removeCard(UnoCard card) {
  //   hand.remove(card);
  //   notifyListeners();
  // }
}
