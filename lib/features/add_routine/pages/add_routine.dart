import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_checks_mobile/domain/enum.dart';
import 'package:routine_checks_mobile/domain/frequency.dart';
import 'package:routine_checks_mobile/domain/routine_model.dart';
import 'package:routine_checks_mobile/features/add_routine/widgets/frequency_widget.dart';
import 'package:routine_checks_mobile/providers/service_providers.dart';
import 'package:routine_checks_mobile/providers/state_notifier_providers.dart';
import 'package:routine_checks_mobile/utils/validations.dart';
import 'package:routine_checks_mobile/widgets/appbutton.dart';

class AddRoutine extends ConsumerStatefulWidget {
  const AddRoutine({Key? key}) : super(key: key);

  @override
  ConsumerState<AddRoutine> createState() => _AddRoutineState();
}

class _AddRoutineState extends ConsumerState<AddRoutine> {
  @override
  void initState() {
    ref.read(notificationProvider).initialiseNotifications();
    ref.read(addRoutineViewmdodelProvider.notifier).expireRoutine();
    super.initState();
  }

  final _routineNameController = TextEditingController();
  final _routineDescriptionController = TextEditingController();
  bool select = false;

  List<Frequency> frequencies = [
    Frequency(
      name: 'Hourly',
      frequency: DateTime.now().add(const Duration(hours: 1)),
      isSelected: false,
      type: FrequencyType.hourly,
    ),
    Frequency(
      name: 'Daily',
      frequency: DateTime.now().add(const Duration(days: 1)),
      isSelected: false,
      type: FrequencyType.daily,
    ),
    Frequency(
      name: 'Weekly',
      frequency: DateTime.now().add(const Duration(days: 7)),
      isSelected: false,
      type: FrequencyType.weekly,
    ),
    Frequency(
      name: 'Monthly',
      frequency: DateTime.now().add(const Duration(days: 30)),
      isSelected: false,
      type: FrequencyType.monthly,
    ),
    Frequency(
      name: 'Yearly',
      frequency: DateTime.now().add(const Duration(days: 365)),
      isSelected: false,
      type: FrequencyType.yearly,
    ),
  ];

  @override
  void dispose() {
    super.dispose();
    _routineNameController.dispose();
    _routineDescriptionController.dispose();
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.read(addRoutineViewmdodelProvider.notifier);
    final state = ref.watch(addRoutineViewmdodelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Routine'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: <Widget>[
              _buildTextFieldColumn(
                label: 'Title',
                hint: 'Enter a title for your routine',
                controller: _routineNameController,
              ),
              const SizedBox(height: 20),
              _buildTextFieldColumn(
                label: 'Description',
                hint: 'Enter a description for your routine',
                controller: _routineDescriptionController,
              ),
              const SizedBox(height: 50),
              FrequencyWidget(
                frequencies: frequencies,
              ),
              const SizedBox(height: 20),
              AppButton(
                onTap: state.selectedFrequency == null
                    ? () {
                        showSnackBar("You have not selected a frequency");
                      }
                    : () {
                        model.addRoutine(
                          Routine(
                            title: _routineNameController.text,
                            description: _routineDescriptionController.text,
                            frequency: state.selectedFrequency!.frequency,
                            status: Status.pending,
                          ),
                        );
                        model.filterNext12HoursRoutines();
                        showSnackBar("Routine added successfully");
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_buildTextFieldColumn({
  required String label,
  required String hint,
  required TextEditingController controller,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(label),
      const SizedBox(height: 10),
      TextFormField(
        validator: Validators.notEmpty(),
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    ],
  );
}
