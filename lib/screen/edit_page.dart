import 'package:counter_with_bloc/bloc/bloc.dart';
import 'package:counter_with_bloc/const/enums.dart';
import 'package:counter_with_bloc/data/data.dart';
import 'package:counter_with_bloc/extension/context_extension.dart';
import 'package:counter_with_bloc/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class EditPage extends StatelessWidget {
  final Contact contact;
  const EditPage({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditContactCubit>(
      create: (context) => EditContactCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Center(
            child: Text("Edit Page"),
          ),
        ),
        body: BlocBuilder<EditContactCubit, EditContactState>(
          builder: (context, state) {
            if (state is EditContactLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.cyan,
                ),
              );
            } else if (state is EditContactSuccess) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Success!",
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20,),
                    OutlinedButton(
                      onPressed: () {
                        //context.navigateBack(context,RouteSuccess.success.name);
                        Navigator.pop(context,RouteSuccess.success.name);
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back_outlined,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Back Home",style: TextStyle(fontSize: 13,fontWeight: FontWeight.normal,color: Colors.black),)
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else if (state is EditContactFail) {
              return const Center(
                child: Text(
                  "Fail",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              );
            }
            return ContactForm(contact: contact,);
          },
        ),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  final Contact contact;
  const ContactForm({super.key, required this.contact});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name, _age, _job;
  @override
  Widget build(BuildContext context) {

    return Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            TextFormField(
              initialValue: widget.contact.name,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Name"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter name";
                }
                return null;
              },
              onSaved: (name) {
                _name = name!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: widget.contact.age,

              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Age"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter age";
                }
                return null;
              },
              onSaved: (age) {
                _age = age!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: widget.contact.job,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Job"),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter job ";
                }
                return null;
              },
              onSaved: (job) {
                _job = job!;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();
                  Contact contact = Contact(widget.contact.id,_name, _job, _age);
                  context.read<EditContactCubit>().editContact(contact.id, contact);
                }
              },
              color: Colors.cyan,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: const Text("Edit Contact",style: TextStyle(color: Colors.white),),
            )
          ],
        ));
  }
}
