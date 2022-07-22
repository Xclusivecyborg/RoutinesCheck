import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_checks_mobile/domain/frequency.dart';
import 'package:routine_checks_mobile/providers/state_notifier_providers.dart';

class FrequencyWidget extends ConsumerStatefulWidget {
  const FrequencyWidget({
    Key? key,
    required this.frequencies,
  }) : super(key: key);
  final List<Frequency> frequencies;

  @override
  ConsumerState<FrequencyWidget> createState() => _FrequencyWidgetState();
}

class _FrequencyWidgetState extends ConsumerState<FrequencyWidget> {
  @override
  Widget build(BuildContext context) {
    final model = ref.read(addRoutineViewmdodelProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Frequency'),
        const SizedBox(height: 10),
        ...widget.frequencies.map((frequency) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(frequency.name),
                  Switch(
                    value: frequency.isSelected,
                    onChanged: (value) {
                      setState(() {
                        for (var element in widget.frequencies) {
                          element.isSelected = false;
                        }
                        frequency.isSelected = true;
                      });
                      model.selectFrequency(frequency);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          );
        }),
      ],
    );
  }
}
