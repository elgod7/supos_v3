class AppImage {
  final String? url; // For stored images
  final String? path; // For new images before upload
  //final String? bucketName;   // For new images before upload

  AppImage.existing(this.url) : path = null;
  AppImage.newFile(this.path) : url = null;

  bool get isUploaded => url != null;
  
}
