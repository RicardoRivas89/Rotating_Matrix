import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<int> _list = <int>[0, 0, 0, 0, 0, 0, 0, 0, 0];
  final List<int> _fibonacciList = <int>[0, 1, 1, 2, 3, 5, 8, 13, 21];
  int _sum = 0;
  bool areButtonActivated = false;
  final _initialEl = TextEditingController();
  final _finalEl = TextEditingController();
  int _id = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 65),
              const Text('Matriz de Fibonacci'),
              const SizedBox(height: 30),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                  mainAxisExtent: 80,
                ),
                itemBuilder: (BuildContext context, int index) => Text(
                  '${_list[index]}',
                  textAlign: TextAlign.center,
                ),
                itemCount: _list.length,
                shrinkWrap: true,
              ),
              Text(
                'La suma de la matriz es: $_sum',
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Elemento Inicial:'),
                  SizedBox(
                    width: 40,
                    child: TextField(
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        counterText: "",
                      ),
                      controller: _initialEl,
                    ),
                  ),
                  const Text('Elemento Final:'),
                  SizedBox(
                    width: 40,
                    child: TextField(
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        counterText: "",
                      ),
                      controller: _finalEl,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              ElevatedButton(
                  onPressed: () => _generateMatrix(),
                  child: const Text('           Generar Matriz           ')),
              ElevatedButton(
                  onPressed: areButtonActivated ? () => _rotateToRight() : null,
                  child: const Text('  Girar Matriz a la Derecha  ')),
              ElevatedButton(
                  onPressed: areButtonActivated ? () => _resetMatrix() : null,
                  child: const Text('          Resetear Matriz          ')),
            ],
          ),
        ),
      ),
    );
  }

  void _generateMatrix() {
    if (_initialEl.text != '' && _finalEl.text != '') {
      var initialVal = int.parse(_initialEl.text);
      var finalVal = int.parse(_finalEl.text);
      if (initialVal < 1 || initialVal > 9 || finalVal < 1 || finalVal > 9) {
        _initialEl.text = '';
        _finalEl.text = '';
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                title: Text('Error'),
                content: Text('Los numeros ingresados deben ser entre 1 y 9'),
              );
            });
      } else {
        if (finalVal < initialVal || finalVal == initialVal) {
          _initialEl.text = '';
          _finalEl.text = '';
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Text('Error'),
                  content: Text(
                      "El elemento final no puede ser menor o igual que el elemento inicial"),
                );
              });
        } else {
          for (int i = initialVal - 1; i <= finalVal - 1; i++) {
            _list[i] = _fibonacciList[_id];
            _sum += _fibonacciList[_id];
            _id++;
          }
          areButtonActivated = true;
          setState(() {});
        }
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('Error'),
              content: Text(
                  "Debes ingresar un numero para los elementos Inicial y Final"),
            );
          });
    }
  }

  void _rotateToRight() {
    final List<int> listAux = List.from(_list);
    final List<int> newPositionList = <int>[2, 5, 8, 1, 4, 7, 0, 3, 6];
    for (int i = 0; i < 9; i++) {
      _list[newPositionList[i]] = listAux[i];
    }
    setState(() {});
  }

  void _resetMatrix() {
    for (int i = 0; i < 9; i++) {
      _list[i] = 0;
    }
    _sum = 0;
    _id = 0;
    _initialEl.text = '';
    _finalEl.text = '';
    areButtonActivated = false;
    setState(() {});
  }
}
