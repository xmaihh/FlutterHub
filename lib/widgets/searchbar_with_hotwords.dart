import 'package:flutter/material.dart';

class SearchBarWithHotWords extends StatefulWidget {
  const SearchBarWithHotWords({super.key});

  @override
  State<SearchBarWithHotWords> createState() => _SearchBarWithHotWordsState();
}

class _SearchBarWithHotWordsState extends State<SearchBarWithHotWords> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isFocused = false;
  List<String> _hotWords = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_searchController.text.isNotEmpty && !_isFocused) {
      setState(() {
        _isFocused = true;
      });
      _fetchHotWords();
    } else if (_searchController.text.isEmpty && _isFocused) {
      setState(() {
        _isFocused = false;
        _hotWords.clear();
      });
    }
  }

  void _onFocusChanged() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
      if (!_isFocused) {
        _hotWords.clear();
      }
    });
  }

  Future<void> _fetchHotWords() async {
    // 模拟网络请求
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _hotWords = [
        'Flutter',
        'Android',
        'iOS',
        'React Native',
        'Kotlin',
        'Swift',
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (_isFocused) {
            _focusNode.unfocus();
          }
        },
        child: FocusScope(
          onFocusChange: (focused) {
            debugPrint("点击了区域外");
            if (!focused) {
              setState(() {
                _isFocused = false;
                _hotWords.clear();
              });
            }
          },
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: '搜索',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                onTap: () {
                  if (!_isFocused) {
                    setState(() {
                      _isFocused = true;
                    });
                    _fetchHotWords();
                  }
                },
              ),
              if (_isFocused)
                LayoutBuilder(builder: (context, constraints) {
                  return Container(

                      /// 将 Container 的宽度设置为父控件的最大宽度
                      width: constraints.maxWidth,
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: _hotWords.map((word) {
                              return ActionChip(
                                label: Text(word),
                                onPressed: () {
                                  _searchController.text = word;
                                },
                              );
                            }).toList(),
                          ),
                          Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isFocused = false;
                                      _hotWords.clear();
                                    });
                                  },
                                  child: const Text('收起'),
                                ),
                              ))
                        ],
                      ));
                }),
            ],
          ),
        ));
  }
}
