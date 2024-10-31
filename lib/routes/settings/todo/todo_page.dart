import 'package:flutter/material.dart';
import 'package:flutter_hub/l10n/localization_intl.dart';
import 'package:flutter_hub/models/index.dart';
import 'package:flutter_hub/services/index.dart';
import 'package:flutter_hub/widgets/empty_state.dart';
import 'package:flutter_hub/widgets/loading_indicator.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<StatefulWidget> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Todo> todos = [];
  final _apiServer = getIt<ApiService>();

  // 分页相关变量
  int _currentPage = 1;
  bool _hasMore = true;

  // 加载状态
  bool _loadingMore = false;
  bool _refreshing = false;

  // 滑动控制器
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // 初始加载数据
    _loadData(isRefresh: true);
    // 添加滚动监听
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 50) {
      if (!_loadingMore && !_refreshing && _hasMore) {
        _loadData(isRefresh: false);
      }
    }
  }

  // 加载数据
  Future<void> _loadData({required bool isRefresh}) async {
    if (isRefresh) {
      if (_refreshing) return;
      setState(() {
        _refreshing = true;
      });
    } else {
      if (_loadingMore) return;
      setState(() {
        _loadingMore = true;
      });
    }

    try {
      if (isRefresh) {
        _currentPage = 1;
      }

      List<Todo> newTodos = [];
      ResponseModel<PaginationModel<Todo>>? res = await _apiServer.fetchTodoList(context, _currentPage);
      if (res?.data != null) {
        newTodos = res?.data?.datas ?? [];
        _hasMore = !(res?.data?.over == true);
      }

      // 模拟获取数据
      // newTodos = List.generate(
      //     isRefresh ? 10 : 5,
      //         (index) =>
      //         Todo(
      //           id: 15537,
      //           completeDate: DateTime
      //               .now()
      //               .millisecondsSinceEpoch,
      //           completeDateStr: "2024-10-29",
      //           content: "这是一条测试消息内容，索引为 ${index + 1}",
      //           date: DateTime
      //               .now()
      //               .millisecondsSinceEpoch,
      //           dateStr: "2024-10-29",
      //           priority: 0,
      //           status: (index % 2 == 0) ? 1 : 0,
      //           title: "待办事项 ${index + 1}",
      //           type: 0,
      //           userId: 15337,
      //         ));

      setState(() {
        if (isRefresh) {
          todos = newTodos;
        } else {
          todos.addAll(newTodos);
        }

        if (_hasMore) {
          _currentPage++;
        }
      });
    } catch (e) {
      // TODO: 错误处理
    } finally {
      setState(() {
        if (isRefresh) {
          _refreshing = false;
        } else {
          _loadingMore = false;
        }
      });
    }
  }

  // 删除todo
  void _deleteTodo(Todo todo) async {
    setState(() {
      todos.remove(todo);
    });
    await _apiServer.deleteTodo(context, todo.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).todo_page_todo),
          actions: [
            IconButton(
              icon: Icon(Icons.search, size: 28, color: Colors.indigoAccent),
              onPressed: () {
                _showTodoSearchSheet(context);
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0.3),
            child: Container(
                decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.3),
              ),
            )),
          ),
        ),
        body: SafeArea(
            child: Container(
                padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
                child: Container(
                    //This is where the magic starts
                    child: _buildTodosWidget()))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 36),
          child: FloatingActionButton(
            elevation: 5.0,
            onPressed: () {
              _showAddOrEditTodoSheet(context, null);
            },
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              size: 32,
              color: Colors.indigoAccent,
            ),
          ),
        ));
  }

  void _showAddOrEditTodoSheet(BuildContext context, Todo? todo) {
    final _todoDescriptionFormController = TextEditingController();
    _todoDescriptionFormController.text = todo == null ? '' : todo.title;
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              color: Colors.transparent,
              child: Container(
                height: 230,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: const Radius.circular(10.0), topRight: const Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, top: 25.0, right: 15, bottom: 30),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _todoDescriptionFormController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: InputDecoration(hintText: AppLocalizations.of(context).todo_page_add_sheet_hint_text, labelText: todo == null ? AppLocalizations.of(context).todo_page_add_sheet_title_new_todo : AppLocalizations.of(context).todo_page_add_sheet_title_edit_todo, labelStyle: TextStyle(color: Colors.indigoAccent, fontWeight: FontWeight.w500)),
                              validator: (String? value) {
                                if (value != null && value.isEmpty) {
                                  return 'Empty description!';
                                }
                                return value != null && value.contains('@') ? 'Do not use the @ char.' : null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.indigoAccent,
                              radius: 18,
                              child: IconButton(
                                icon: Icon(
                                  Icons.save,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  final newTodo = _todoDescriptionFormController.value.text;
                                  if (newTodo.isNotEmpty) {
                                    /*Create new Todo object and make sure
                                    the Todo description is not empty,
                                    because what's the point of saving empty
                                    Todo
                                    */
                                    if (todo == null) {
                                      /// Add todo
                                      _apiServer.addTodo(context, newTodo, newTodo, DateFormat('yyyy-MM-dd').format(DateTime.now()));
                                    } else {
                                      /// Edit todo
                                      _apiServer.editTodo(context, todo.id, newTodo, newTodo, todo.dateStr);
                                    }
                                    // refresh Data
                                    _loadData(isRefresh: true);
                                    // dismisses the bottomSheet
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _showTodoSearchSheet(BuildContext context) {
    final _todoSearchDescriptionFormController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              color: Colors.transparent,
              child: Container(
                height: 230,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: const Radius.circular(10.0), topRight: const Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, top: 25.0, right: 15, bottom: 30),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _todoSearchDescriptionFormController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context).todo_page_search_sheet_hint_text,
                                labelText: AppLocalizations.of(context).todo_page_search_sheet_title_search,
                                labelStyle: TextStyle(color: Colors.indigoAccent, fontWeight: FontWeight.w500),
                              ),
                              validator: (String? value) {
                                return value != null && value.contains('@') ? 'Do not use the @ char.' : null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.indigoAccent,
                              radius: 18,
                              child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  /*This will get all todos
                                  that contains similar string
                                  in the textform
                                  */
                                  setState(() {
                                    todos = todos.where((todo) => todo.title.toLowerCase().contains(_todoSearchDescriptionFormController.value.text.toLowerCase())).toList();
                                  });
                                  _loadData(isRefresh: true);
                                  //dismisses the bottomSheet
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildTodosWidget() {
    return RefreshIndicator(
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: 4),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == todos.length) {
                  // 只在加载更多时显示底部加载指示器
                  return _loadingMore && _hasMore ? LoadingIndicator() : Container(height: 0);
                }
                return _buildTodoItem(todos[index]);
              },
              childCount: todos.length + (_loadingMore && _hasMore ? 1 : 0),
            )),
            // 空状态显示
            SliverToBoxAdapter(
              child: todos.isEmpty && !_refreshing
                  ? EmptyStateWidget(
                      message: AppLocalizations.of(context).todo_page_empty_todos,
                      subMessage: AppLocalizations.of(context).todo_page_empty_todos_refresh,
                      icon: BoxIcons.bx_folder_open,
                    )
                  : Container(height: 0),
            )
          ],
        ),
        onRefresh: () async {
          await _loadData(isRefresh: true);
        });
  }

  Widget _buildTodoItem(Todo todo) {
    return Dismissible(
      background: Container(
        color: Colors.greenAccent,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16),
        child: const Icon(Icons.edit, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.redAccent,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          // Left swipe (delete)
          // Show a confirmation dialog or directly delete the item// return await _showDeleteConfirmationDialog(context, todo);
          _deleteTodo(todo);
          return true; // For now, assume confirmation is always true
        } else if (direction == DismissDirection.startToEnd) {
          // Right swipe (edit)
          // Navigate to the edit screen
          // Navigator.push(context, MaterialPageRoute(builder: (context) => EditTodoScreen(todo: todo)));
          _showAddOrEditTodoSheet(context, todo);
          return false; // Prevent dismissal for edit action
        }
        return false; // Default to not dismissing
      },
      direction: DismissDirection.horizontal,
      key: ObjectKey(todo),
      child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(5),
          ),
          color: Colors.white,
          child: ListTile(
            leading: InkWell(
              onTap: () async {
                //Reverse the value
                todo.status = todo.Done() ? 0 : 1;
                /*
                  Another magic.
                  This will update Todo isDone with either
                  completed or not
                */
                await _apiServer.updateTodoCompletionStatus(context, todo.id, todo.Done());
                setState(() {
                  // todos = todos;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: todo.Done()
                    ? Icon(
                        Icons.done,
                        size: 26.0,
                        color: Colors.greenAccent,
                      )
                    : Icon(
                        Icons.check_box_outline_blank,
                        size: 26.0,
                      ),
              ),
            ),
            title: Text(
              todo.title,
              style: TextStyle(color: todo.Done() ? Colors.black45 : Colors.black87, decoration: todo.Done() ? TextDecoration.lineThrough : TextDecoration.none),
            ),
            subtitle: Text(
              todo.content,
              style: TextStyle(color: todo.Done() ? Colors.black45 : Colors.black87, decoration: todo.Done() ? TextDecoration.lineThrough : TextDecoration.none),
            ),
          )),
    );
  }
}
