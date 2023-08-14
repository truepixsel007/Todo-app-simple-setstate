import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../widgets/todo_item.dart';
import '../model/todo.dart';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // const Home({super.key});
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _fondToDo = [];

@override
  void initState() {
  _fondToDo = todosList;
  // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50,bottom: 20),
                        child: Text('All ToDos',style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),),
                      ),

                      for ( ToDo todoo in _fondToDo.reversed)
                      ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment:Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child:Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow:const[ BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0,0.0),
                      ),],
                        borderRadius: BorderRadius.circular(10),

                    ),
                   child: TextField(
                     controller: _todoController,
                     decoration: InputDecoration(
                       hintText: 'Add a new todo item',
                       border: InputBorder.none
                     ),
                  ),
                )
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20,right: 20,),
                  child: ElevatedButton(
                    child: Text('+',style: TextStyle(fontSize: 40),),
                    onPressed: (){
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: tdBlue,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );

  }

  void _runFilter(String enteredkeyword){
    List<ToDo> results = [];
    if(enteredkeyword.isEmpty) {
      results = todosList;
    }
    else{
      results = todosList
      .where((item) => item.todoText!
          .toLowerCase()
          .contains(enteredkeyword.toLowerCase()))
      .toList();
    }
    setState(() {
      _fondToDo = results;
    });
  }

  void _handleToDoChange(ToDo  todo){
    setState(() {

    });
    todo.isDone = !todo.isDone;
  }

  void _deleteToDoItem(String id){
    setState(() {
      
    });
    todosList.removeWhere((item) => item.id == id);
  }

  void _addToDoItem(String toDo){
    todosList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(),
      todoText: toDo,
    ));
    _todoController.clear();
  }

  Widget searchBox(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding:EdgeInsets.all(0),
          prefix: Icon(Icons.search,color: tdBlack,size: 20,),
          prefixIconConstraints: BoxConstraints(maxWidth: 25,minHeight: 20),
          border: InputBorder.none,
          hintText: 'search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu,color: tdBlack,size: 30,),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/avtar.jpg'),
            ),
          )
        ],
      ),
    );
  }
}





