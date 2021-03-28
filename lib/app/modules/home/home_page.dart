import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/auth/auth_controller.dart';
import '../../shared/models/todo_model.dart';
import '../../shared/widgets/header_widget.dart';
import '../login/login_page.dart';
import 'todos_cubit.dart';
import 'todos_states.dart';

class HomePage extends StatefulWidget {
  static final String route = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextStyle headerStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );

  TodosCubit _todos$;
  AuthController _auth$;

  @override
  void initState() {
    _auth$ = Modular.get<AuthController>();
    _todos$ = Modular.get<TodosCubit>()..getAllTodos();
    super.initState();
  }

  @override
  void dispose() {
    _todos$.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(
                backgroundColor: primaryColor,
                height: screenHeight * .2,
                child: buildHeader(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<TodosCubit, TodosState>(
                    bloc: _todos$,
                    builder: (context, state) {
                      if (state is InitTodosState ||
                          state is LoadingTodosState) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(primaryColor),
                          ),
                        );
                      } else if (state is LoadedTodosState) {
                        return buildTodosList(state);
                      } else {
                        return Center(
                          child: Text('Error loading todos'),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          buildLogoutButton(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
            ),
            builder: (context) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 20.0,
                ),
                child: SingleChildScrollView(
                  child: buildModalBottomSheet(context),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildModalBottomSheet(BuildContext context) {
    return Form(
      key: _todos$.modalBottomSheetFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10.0),
          TextFormField(
            controller: _todos$.description$,
            validator: _todos$.descriptionValidator,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Descrição',
            ),
          ),
          const SizedBox(height: 30.0),
          Container(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                _todos$.description$.clear();
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _todos$.addTodo,
              child: Text('Confirmar'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLogoutButton(BuildContext context) {
    return Positioned(
      right: 0.0,
      top: MediaQuery.of(context).padding.top,
      child: IconButton(
        icon: Icon(Icons.logout),
        color: Colors.white,
        onPressed: () {
          _auth$.logout();
          Modular.to.navigate(LoginPage.route, replaceAll: true);
        },
      ),
    );
  }

  Widget buildTodosList(LoadedTodosState state) {
    return ListView.separated(
      separatorBuilder: (_, __) => Divider(),
      itemCount: state.todos.length,
      itemBuilder: (context, index) {
        final TodoModel currentTodo = state.todos[index];
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: const EdgeInsets.only(right: 16.0),
          title: Text(
            currentTodo.description,
            style: TextStyle(
              color: currentTodo.isCompleted ? Colors.grey : Colors.black,
              decoration:
                  currentTodo.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          value: currentTodo.isCompleted,
          onChanged: (value) => _todos$.updateTodo(currentTodo, value),
        );
      },
    );
  }

  Widget buildHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${_greeting(DateTime.now().hour)},',
          style: headerStyle,
        ),
        Text(
          '${_auth$.user?.name ?? ''}!',
          style: headerStyle.copyWith(
            fontSize: 44.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  String _greeting(int hour) {
    if (hour > 0 && hour < 12) {
      return 'Bom dia';
    } else if (hour < 18) {
      return 'Boa tarde';
    } else {
      return 'Boa noite';
    }
  }
}
