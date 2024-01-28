import 'package:counter_with_bloc/bloc/post/cubit/post_contact_cubit.dart';
import 'package:counter_with_bloc/const/enums.dart';
import 'package:counter_with_bloc/data/data.dart';
import 'package:counter_with_bloc/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostContactCubit>(
      create: (context) => PostContactCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Center(
            child: Text("Add Page"),
          ),
        ),
        body: BlocBuilder<PostContactCubit, PostContactState>(
          builder: (context, state) {
            if (state is PostContactLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.cyan,
                ),
              );
            } else if (state is PostContactSuccess) {
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
            } else if (state is PostContactError) {
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
            return ContactForm();
          },
        ),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

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
                  Contact contact = Contact("",_name, _job, _age);
                  context.read<PostContactCubit>().addContact(contact);
                }
              },
              color: Colors.cyan,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: const Text("Add to Contact"),
            )
          ],
        ));
  }
}
