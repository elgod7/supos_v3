
part of 'image_bloc.dart';

abstract class ImageEvent {}

class UploadImageEvent extends ImageEvent {
  final File image;
  final String folder;
  UploadImageEvent(this.image, this.folder);
}

class DeleteImage extends ImageEvent {
  final String imageUrl;

  DeleteImage(this.imageUrl);
}

class UpdateImage extends ImageEvent {
  final File image;
  final String imageUrl;
  final String folder;

  UpdateImage(this.image, this.imageUrl, this.folder);
}

class IsImageValid extends ImageEvent {
  final String imageUrl;

  IsImageValid(this.imageUrl);
}