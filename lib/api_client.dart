import 'package:dio/dio.dart';

class ApiClient {
  Dio dio = Dio(BaseOptions(baseUrl: 'https://todo-app-utvk.onrender.com'));

  Future<List> getAllTodos() async {
    final response = await dio.get('/todos');
    print(response.data['data'] as List);
    return response.data['data'] as List;
  }

  Future createTodo(String content) async {
    final response = await dio.post('/todo/create', data: {
      'content': content,
    });
    print(response.data);
  }

  Future deleteTodo(String id) async {
    final response = await dio.delete('/todo/$id');
    print(response.data);
  }
}
