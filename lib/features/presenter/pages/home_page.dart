import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_clean_architecture/features/presenter/controller/home_store.dart';
import 'package:nasa_clean_architecture/features/presenter/widgets/custom_app_bar.dart';
import 'package:nasa_clean_architecture/features/presenter/widgets/round_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'NASA',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Bem vindo ao projeto da nasa',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  height: 150,
                ),
                RoundButton(
                  label: 'Selecione a data e hora',
                  onTap: () async {
                    var datePicked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1989, 09, 02),
                      lastDate: DateTime.now(),
                    );

                    await store.getSpaceMediaFromDateUseCase(datePicked);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
