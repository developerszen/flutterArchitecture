import 'package:arch_flutter/data/repository.dart';
import 'package:arch_flutter/data/user.dart';
import 'package:arch_flutter/screens/bloc/user_bloc.dart';
import 'package:flutter/material.dart';

class UserBlocScreen extends StatefulWidget {
    UserBlocScreen(this._repository);
    final Repository _repository;

    @override
    State<StatefulWidget> createState() => _UserBlocScreenState();
}

class _UserBlocScreenState extends State<UserBlocScreen> {
    UserBloc _userBloc;

    @override
    void initState() {
        _userBloc = UserBloc(widget._repository);
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Bloc'),
            ),
            body: SafeArea(
                child: StreamBuilder<UserState>(
                    stream: _userBloc.user,
                    initialData: UserInitState(),
                    builder: (context, snapshot) {
                        if (snapshot.data is UserInitState) {
                            return _buildInit();
                        }
                        if (snapshot.data is UserDataState) {
                            UserDataState state = snapshot.data;
                            return _buildContent(state.user);
                        }
                        if (snapshot.data is UserLoadingState) {
                            return _buildLoading();
                        }
                    },
                ),
            ),
        );
    }

    Widget _buildInit() {
        return Center(
            child: RaisedButton(
                child: const Text('Cargar datos de usuario'),
                onPressed: () {
                    _userBloc.loadUserData();
                },
            ),
        );
    }

    Widget _buildContent(User user) {
        return Center(
            child: Text('Hola ${user.name} ${user.surname}'),
        );
    }

    Widget _buildLoading() {
        return const Center(
            child: CircularProgressIndicator(),
        );
    }

    @override
    void dispose() {
        _userBloc.dispose();
        super.dispose();
    }
}
