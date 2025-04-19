part of 'image_bloc.dart';

abstract class ImageState {}

class ImageUploadSuccess extends ImageState {
  final String url;
  ImageUploadSuccess(this.url);
}

class ImageInitial extends ImageState {}

class ImageUploading extends ImageState {}

class ImageUploaded extends ImageState {
  final String url;

  ImageUploaded(this.url);

  // Add this getter
  String get imageUrl => url;
}
class ImageDeleted extends ImageState {}


class ImageError extends ImageState {
  final String message;

  ImageError(this.message);
}

class ImageValidationResult extends ImageState {
  final bool isValid;

  ImageValidationResult(this.isValid);
}