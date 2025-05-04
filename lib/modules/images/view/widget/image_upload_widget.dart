// image_uploader.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supos_v3/modules/images/bloc/image_bloc.dart';
import 'package:supos_v3/modules/images/view/widget/safe_network_image.dart';

import '../../data/image_service.dart';

class ImageUploader extends StatelessWidget {
  final Function(String) onUploaded;
  final String folder;
  final String imageUrl;
  final bool isEdit;

  const ImageUploader({
    required this.onUploaded,
    required this.folder,
    required this.imageUrl,
    super.key,
    required this.isEdit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ImageBloc(ImageService()),
      child: _ImageUploaderContent(
        onUploaded: onUploaded,
        folder: folder,
        imageUrl: imageUrl,
        isEdit: isEdit,
      ),
    );
  }
}

class _ImageUploaderContent extends StatelessWidget {
  final Function(String) onUploaded;
  final String folder;
  final String imageUrl;
  final bool isEdit;

  const _ImageUploaderContent(
      {required this.onUploaded,
      required this.folder,
      required this.imageUrl,
      required this.isEdit});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImageBloc, ImageState>(
      listener: (context, state) {
        if (state is ImageUploadSuccess) {
          onUploaded(state.url);
        }
        if (state is ImageError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            state is ImageUploading
                ? const CircularProgressIndicator()
                : SafeNetworkImage(
                    imageUrl: imageUrl,
                    width: 100,
                    height: 100,
                  ),
            IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () => _pickImage(context, isEdit, imageUrl),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(
      BuildContext context, bool isEdit, String imageUrl) async {
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (picked != null) {
        if (!isEdit) {
          context
              .read<ImageBloc>()
              .add(UploadImageEvent(File(picked.path), folder));
        } else {
          context
              .read<ImageBloc>()
              .add(UpdateImage(File(picked.path), imageUrl, folder));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }
}
