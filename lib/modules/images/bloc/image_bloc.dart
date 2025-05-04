import 'dart:io';

import 'package:flutter/material.dart';

import '../data/image_service.dart';
//import '../data/image_repository.dart';
import 'package:bloc/bloc.dart';
//import '../model/image_model.dart';

part 'image_state.dart';
part 'image_event.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImageService service;

  ImageBloc(this.service) : super(ImageInitial()) {
    on<UploadImageEvent>(_handleUpload);
    on<DeleteImage>(_deleteImage);
    on<UpdateImage>(_updateImage);
    on<IsImageValid>(_isImageValid);
  }

  Future<void> _handleUpload(
      UploadImageEvent event, Emitter<ImageState> emit) async {
    emit(ImageUploading());
    try {
      final url = await service.upload(event.image, event.folder);
      url != null
          ? emit(ImageUploadSuccess(url))
          : emit(ImageError('Upload failed'));
    } catch (e) {
      emit(ImageError('Upload failed: $e'));
    }
  }

  Future<void> _deleteImage(DeleteImage event, Emitter<ImageState> emit) async {
    try {
      await service.delete(event.imageUrl);
      emit(ImageDeleted());
    } catch (e) {
      emit(ImageError('Delete failed: $e'));
    }
  }

  Future<void> _updateImage(UpdateImage event, Emitter<ImageState> emit) async {
    emit(ImageUploading());
    try {
      final url = await service.update(event.image, event.imageUrl, event.folder);
      url != null
          ? emit(ImageUploadSuccess(url))
          : emit(ImageError('Update failed'));
    } catch (e) {
      emit(ImageError('Update failed: $e'));
    }
  }

  Future<void> _isImageValid(
      IsImageValid event, Emitter<ImageState> emit) async {
    try {
      final isValid = await service.isImageValid(event.imageUrl);
      emit(ImageValidationResult(isValid));
    } catch (e) {
      emit(ImageError('Validation failed: $e'));
    }
  }
}
