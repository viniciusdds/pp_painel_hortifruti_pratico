import 'package:app_painel_hortifruti_pratico/app/modules/perfil/perfil_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

class PerfilPage extends GetResponsiveView<PerfilController> {
  @override
  Widget builder() {
    return Scaffold(
      appBar: AppBar(
          title: Text('Meu Perfil'),
          centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            Visibility(
              visible: screen.isPhone,
              replacement: Column(
                children: [
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildForm(),
                                  _buildSubmit()
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Flexible(child: _buildPickAndShowImage())
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              child: Column(
                children: [
                  _buildForm(),
                  const SizedBox(height: 16),
                  _buildPickAndShowImage(),
                  _buildSubmit(),
                ],
              ),
            )
          ],
        ),
      )
    );
  }


  Row _buildSubmit() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Obx(() {
              if(controller.loading.isTrue){
                return const ElevatedButton(
                    onPressed: null,
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                );
              }

              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ElevatedButton(
                              onPressed: (){

                              },
                              child: const Text('Atualizar')
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                            onPressed: (){

                            },
                            child: const Text('Sair da minha conta'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red
                            ),
                        ),
                      ),
                    ],
                  ),
                ],
              );

            }),
          ),
        )
      ],
    );
  }

  Form _buildForm() {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.nameController,
            decoration: const InputDecoration(
                labelText: 'Nome'
            ),
            validator: ((String? value){
              if(value != null && value.isEmpty){
                return 'Informe seu nome';
              }

              return null;
            }),
          ),
          TextFormField(
            controller: controller.emailController,
            decoration: const InputDecoration(
                labelText: 'E-mail'
            ),
            validator: ((String? value){
              if(value != null && value.isEmpty){
                return 'Informe seu nome';
              }

              return null;
            }),
          ),
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  controller: controller.passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Senha'
                  ),
                  obscureText: true,
                  validator: ((String? value){
                    if(value != null && value.isEmpty){
                      return 'Informe a sua senha';
                    }

                    return null;
                  }),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
          Obx(() => SwitchListTile(
              title: Text('Ativar Opção'),
              value: controller.isOnline.value,
              onChanged: controller.toggleSwitch,
              activeColor: Colors.green,
             inactiveThumbColor: Colors.grey,
            )
          ),

        ],
      ),
    );
  }

  Widget _buildPickAndShowImage(){
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Sua Logo',
            style: Get.textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 16),
       Obx((){
           if(controller.image.value != null){
             return _buildProductImage(Image.memory(controller.image.value!.bytes!));
           }

          if(controller.currentImage.value?.isNotEmpty ?? false){
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom:  16),
                  child: OutlinedButton(
                    onPressed: controller.onDeleteImage,
                    child: const Text('Excluir imagem'),
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red
                    ),
                  ),
                ),
               // Image.network(controller.currentImage.value!.toString()),
                _buildProductImage(
                    FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: controller.currentImage.value!
                    )
                )
              ],
            );
          }

         return const SizedBox();
       }),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          child: OutlinedButton(
            onPressed: controller.pickImage,
            child: const Text('Selecionar uma imagem'),
          ),
        )
      ],
    );
  }

  Widget _buildProductImage(Widget image){
    return Align(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 250),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: image,
        ),
      ),
    );
  }
}

