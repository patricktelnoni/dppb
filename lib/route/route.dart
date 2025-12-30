import 'package:dppb/view/comment/comment_list.dart';
import 'package:dppb/view/content/content_list.dart';
import 'package:dppb/view/products/get_data_http.dart';
import 'package:go_router/go_router.dart';
import 'package:dppb/main.dart';
import 'package:dppb/view/auth/login_form.dart';
import 'package:dppb/view/comment/comment_list.dart';

final List<GoRoute> routes = [
    /*
    * '/login' : (context) => LoginForm(),
        '/second': (context) => const SecondPage(),
        '/third': (context) =>const ThirdPage(),
        '/http':(context) => const GetDataHttp(),
        '/posts':(context) => const PostList(),*/

    // GoRoute(
    //   name: 'Login',
    //   path: '/login',
    //   builder: (context, state) => const LoginForm(),
    // ),
    GoRoute(
      name: 'Product',
      path: '/products',
      builder: (context, state) => const GetDataHttp(),
    ),

    GoRoute(
      name: 'Posts Comment',
      // The path includes a parameter
      path: '/post/:postId/comments',
      builder: (context, state) {
        // Access path parameters using state.pathParameters
        final postId = state.pathParameters['postId']!;
        return CommentList(postId: int.parse(postId));
      },
    ),
    GoRoute(
      name: 'content',
      // The path includes a parameter
      path: '/content',
      builder: (context, state) => const ContentList(),
    ),
  ];