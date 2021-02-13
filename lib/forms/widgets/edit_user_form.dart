import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/cubits/edit_user_cubit/edit_user_cubit.dart';

class EditUserForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<EditUserCubit, EditUserState>(
      listener: (context, state) {},
      child: SingleChildScrollView(
        child: Column(
          children: [
            _NameInput(),
            ElevatedButton(
              onPressed: () {
                context.read<EditUserCubit>().editFormSubmitted();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditUserCubit, EditUserState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('editUserForm_emailInput_textField'),
          onChanged: (name) => context.read<EditUserCubit>().nameChanged(name),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'name',
            helperText: '',
            errorText: state.name.invalid ? 'invalid name' : null,
          ),
        );
      },
    );
  }
}
