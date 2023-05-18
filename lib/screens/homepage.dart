import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ny_times/bloc/news_bloc.dart';
import 'package:dio/dio.dart';
import 'package:ny_times/bloc/theme_cubit.dart';

   final dio = Dio(BaseOptions(
    sendTimeout: const Duration(seconds: 20),
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout:const Duration(seconds: 20)));

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewsBloc(dio)..add(Newsfetch()),
        child: Scaffold(
          body: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state.status == NewsStatus.success) {
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      expandedHeight: 250.0,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          ' ',
                          textScaleFactor: 1,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        background: Image.network(
                          'https://library.northwestu.edu/wp-content/uploads/2019/06/nytimes.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: BlocBuilder<ThemeCubit, bool>(
                        builder: (context, state) {
                          return SwitchListTile(
                            value: state,
                            title: Text('Theme'),
                            onChanged: ( value) {
                              BlocProvider.of<ThemeCubit>(context)
                                  .toggleTheme(value: value);
                            },
                          );
                        },
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((_, index) {
                        return Container(
                          decoration: BoxDecoration(border: Border.symmetric()),
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                      state.allResults?.results?[index].title ??
                                          "")),
                              Expanded(
                                  flex: 1,
                                  child: CircleAvatar(
                                    backgroundImage:NetworkImage (state.allResults?.results?[index].media?[index].mediaMetadata[index].url ?? "https://library.northwestu.edu/wp-content/uploads/2019/06/nytimes.png")
                                  ))
                            ],
                          ),
                        );
                      }, childCount: state.allResults?.results?[index].media?[index].mediaMetadata?.length,
                    )
                  ],
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
