import 'package:colorize/colorize.dart';
import 'package:counter_with_bloc/bloc/get/cubit/get_contact_cubit.dart';
import 'package:counter_with_bloc/const/enums.dart';
import 'package:counter_with_bloc/data/model/contact.dart';
import 'package:counter_with_bloc/extension/context_extension.dart';
import 'package:counter_with_bloc/screen/edit_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'add_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: UniqueKey(),
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Center(
          child: Text("Home Page"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddPage()));
          if (result != null && result == RouteSuccess.success.name) {
            if (context.mounted) {
              BlocProvider.of<GetContactCubit>(context).getContact();
            }
          }
        },
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<GetContactCubit, GetContactState>(
        builder: (BuildContext context, state) {
          if (state is GetContactSuccess) {
            List<Contact> contacts = state.contacts;
            return Center(child: ContactCard(contacts: contacts,));
          } else if (state is GetContactFail) {
            return const Center(child: Text("Error occurring..."));
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.cyan,
            ),
          );
        },
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard({
    required this.contacts,
  }): super(key: key);

  final List<Contact> contacts;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (contexts, index) {
       return Card(
          child: Slidable(
            dragStartBehavior: DragStartBehavior.start,
            startActionPane: ActionPane(motion: const StretchMotion(), children: [
              SlidableAction(
                backgroundColor: Colors.blueAccent,
                onPressed: (contexts)  {
                    Navigator.of(contexts).push(MaterialPageRoute(
                    builder: (_) => EditPage(contact: contacts[index]),
                  ));
                    if(context.mounted){
                      BlocProvider.of<GetContactCubit>(context).getContact();
                    }

                },
                icon: Icons.edit,
              )
            ]),
            endActionPane: ActionPane(motion: const StretchMotion(), children: [
              SlidableAction(
                backgroundColor: Colors.red,
                onPressed: (context) {},
                icon: Icons.delete_outline_rounded,
              )
            ]),
            child: ListTile(
              title: Text(contacts[index].name),
              subtitle: Text(contacts[index].job),
              trailing: Text("Age: ${contacts[index].age}"),
            ),
          ),
        );
      },
    );
  }
}


