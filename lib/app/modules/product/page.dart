import 'package:app_painel_hortifruti_pratico/app/modules/product/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends GetResponsiveView<ProductController> {

  @override
  Widget builder() {
    //var product = controller.product.value!;

    return Scaffold(
        appBar: AppBar(
          title: Text('Novo Produto'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            children: [
             // if(screen.isPhone)...[
            //  ]
            //  else ...[
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
                ),

              ]
          //  ],
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

                      return ElevatedButton(
                          onPressed: () => controller.onAdd(),
                          child: const Text('Adicionar')
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
                        return 'Informe o nome do produto';
                      }

                      return null;
                    }),
                  ),
                  TextFormField(
                    controller: controller.descricaoController,
                    decoration: const InputDecoration(
                        labelText: 'Descrição'
                    ),
                    minLines: 1,
                    maxLines: 3,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: controller.priceController,
                          decoration: const InputDecoration(
                              labelText: 'Preço'
                          ),
                          validator: ((String? value){
                            if(value != null && value.isEmpty){
                              return 'Informe o nome do produto';
                            }

                            return null;
                          }),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        width: 150,
                        child: DropdownButtonFormField(
                            value: controller.unitOfMeasure.value,
                            decoration: const InputDecoration(
                              labelText: 'Unidade'
                            ),
                            items: ['UN', 'KG'].map((unit) => DropdownMenuItem(
                                value: unit,
                                child: Text(unit)
                            )).toList(),
                            onChanged: controller.changeUnitOfMeasure
                        ),
                      ),
                    ],
                  ),
                  Obx(() => DropdownButtonFormField(
                    value: controller.categoryId.value,
                    items: controller.categoryList.map((category) => DropdownMenuItem(
                      value: category.id,
                      child: Text(category.name),
                    )).toList(),
                    onChanged: controller.changeCategory!,
                    decoration: const InputDecoration(
                        labelText: 'Categoria'
                    ),
                    validator: (int? value){
                      if(value == null){
                        return 'Selecione uma categoria';
                      }

                      return null;
                    },
                  )
                ),
                const SizedBox(height: 8),
                TextButton(
                    onPressed: controller.goToNewCategory,
                    child: Text('Criar uma nova Categoria')
                )
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
            'Imagem do produto',
            style: Get.textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 16),
        Obx((){
          if(controller.image.value != null){
            return _buildProductImage(Image.memory(controller.image.value!.bytes!));
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