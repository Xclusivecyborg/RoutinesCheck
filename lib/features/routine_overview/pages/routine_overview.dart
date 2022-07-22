import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_checks_mobile/domain/routine_model.dart';
import 'package:routine_checks_mobile/features/add_routine/notifier/add_routine_notifier.dart';
import 'package:routine_checks_mobile/providers/state_notifier_providers.dart';
import 'package:routine_checks_mobile/utils/validations.dart';
import 'package:routine_checks_mobile/widgets/appbutton.dart';
import 'package:routine_checks_mobile/widgets/routine_card.dart';

class RoutineOverView extends ConsumerStatefulWidget {
  const RoutineOverView({
    Key? key,
    required this.routine,
  }) : super(key: key);
  final Routine routine;

  @override
  ConsumerState<RoutineOverView> createState() => _RoutineOverViewState();
}

class _RoutineOverViewState extends ConsumerState<RoutineOverView> {
  late final TextEditingController _routineNameController;
  late final TextEditingController _routineDescriptionController;
  final _formKey = GlobalKey<FormState>();

  bool value = false;
  @override
  void dispose() {
    super.dispose();
    _routineNameController.dispose();
    _routineDescriptionController.dispose();
  }

  @override
  void initState() {
    _routineNameController = TextEditingController(text: widget.routine.title);
    _routineDescriptionController =
        TextEditingController(text: widget.routine.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.read(addRoutineViewmdodelProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routine overview'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UpNextRoutineWidet(
                  routine: widget.routine,
                  canChange: widget.routine.status == Status.pending,
                  value: widget.routine.status == Status.completed,
                  onChange: (p0) {
                    widget.routine.status == Status.missed
                        ? null
                        : setState(() {
                            _changeRoutineStatus(widget.routine, model);
                          });
                  },
                ),
                const SizedBox(height: 100),
                const Text(
                  "Edit routine",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
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
                AppButton(
                  text: 'Save',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      model.editRoutine(
                        widget.routine.copyWith(
                          title: _routineNameController.text,
                          description: _routineDescriptionController.text,
                        ),
                      );
                      Navigator.pop(context, widget.routine);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _changeRoutineStatus(Routine routine, AddRoutineNotifier model) {
  routine.isCompleted = !routine.isCompleted;
  if (routine.status == Status.pending) {
    routine.status = Status.completed;
    model.editRoutine(
      routine.copyWith(status: Status.completed),
    );
  } else {
    routine.status = Status.pending;
    model.editRoutine(
      routine.copyWith(
        status: Status.pending,
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
