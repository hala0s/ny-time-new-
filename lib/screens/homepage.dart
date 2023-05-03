import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ny_times/bloc/news_bloc.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(http.Client())..add(Newsfetch()),
      child: Scaffold(
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state.status == NewsStatus.success)
         {   
          state.allResults.length;
          return  CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 250.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'New York News',
                      textScaleFactor: 1,
                    ),
                    background: Image.network(
                      'https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((_, index) {
                    return Column(
                      children: [
                       
                      ],
                    );
                  }, childCount: state.allResults.length),
                )
              ],
            );
         } 
           return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
