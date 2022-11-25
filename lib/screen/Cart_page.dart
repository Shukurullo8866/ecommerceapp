import 'package:ecommerceapp/data/database/local_database.dart';
import 'package:ecommerceapp/data/model/product_model.dart';
import 'package:flutter/material.dart';

class Cart_page extends StatefulWidget {
  const Cart_page({Key? key}) : super(key: key);

  @override
  State<Cart_page> createState() => _Cart_pageState();
}

class _Cart_pageState extends State<Cart_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CARTS'),
      ),
      body: Container(
        child: FutureBuilder(
          future: LocalDatabase.getList(),
          builder: (BuildContext context, AsyncSnapshot<List<Model>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return Container(
                  child: const Center(child: Text('Empty')),
                );
              }
              return PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskItem(
                    model: snapshot.data?[index],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class TaskItem extends StatefulWidget {
  Model? model;

  TaskItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.white),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(12),
              child: Image.network(
                widget.model!.image!,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              width: 328,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.white),
              padding:
                  const EdgeInsets.only(top: 2, left: 8, right: 8, bottom: 10),
              margin: const EdgeInsets.all(12),
              child: Text(
                widget.model!.title!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.deepPurple.shade900),
              padding:
                  const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
              margin: const EdgeInsets.all(12),
              child: Text(
                widget.model!.category!,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            Container(
              width: 328,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.grey),
              padding:
                  const EdgeInsets.only(top: 2, left: 8, right: 8, bottom: 10),
              margin: const EdgeInsets.all(12),
              child: Text(widget.model!.description!),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '\$${widget.model!.price.toString()}',
                  style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                const SizedBox(
                  width: 30,
                ),
                IconButton(
                    onPressed: () async {
                      showDialog(context: context,
                      builder: (context)=>AlertDialog(
                        backgroundColor: Colors.grey,
                        
                      )
                      );
                      await LocalDatabase.deleteTaskById(
                          widget.model!.id!.toInt());
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 30,
                    )),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.deepPurple),
                        child: const Text(
                          '-',
                          style: TextStyle(fontSize: 33, color: Colors.blue),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.deepPurple),
                      child: Text(
                        widget.model!.count.toString(),
                        style:
                            const TextStyle(fontSize: 33, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.deepPurple),
                        child: const Text(
                          '+',
                          style: TextStyle(fontSize: 33, color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
