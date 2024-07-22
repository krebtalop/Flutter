import 'package:flutter/material.dart';

class ComplaintForm extends StatefulWidget {
  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  final _formKey = GlobalKey<FormState>();
  final _tcController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "E-Buski Bilgi Edinme",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tcController,
                decoration: InputDecoration(labelText: 'T.C. Kimlik No'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen T.C. kimlik numaranızı giriniz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Ad Soyad giriniz.'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen ad syoadınızı giriniz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration:
                    InputDecoration(labelText: 'Telefon Numaranızı giriniz.'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen telefon numaranızı giriniz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Mailinizi giriniz.'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen mailinizi giriniz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(labelText: 'Mesajınız'),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen mesajınızı giriniz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Şikayetiniz gönderildi!')),
                    );
                    // Formu temizle
                    _tcController.clear();
                    _nameController.clear();
                    _phoneController.clear();
                    _emailController.clear();
                    _messageController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 20),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white),
                child: Text(
                  'Gönder',
                ),
              ),
              SizedBox(
                height: 55,
              ),
              Image.asset(
                'assets/buski.png',
                height: 110,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tcController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
