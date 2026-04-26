// ignore_for_file: public_member_api_docs

import 'dart:io';

class LocalMedia {
  LocalMedia({
    required this.type,
    required this.file,
    required this.blurHash,
    this.name = '',
  });

  final LocalMediaType type;
  final File file;
  final String blurHash;
  final String name;

  LocalMedia copyWith({
    LocalMediaType? type,
    File? file,
    String? blurHash,
    String? name,
  }) {
    return LocalMedia(
      type: type ?? this.type,
      file: file ?? this.file,
      blurHash: blurHash ?? this.blurHash,
      name: name ?? this.name,
    );
  }
}

enum LocalMediaType { image, video }
