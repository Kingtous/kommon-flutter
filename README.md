<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing video for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

## Kommon Package

Kingtous' Common Package Collection for Flutter. 
方便开发的全能类库.

Inspired by [flutter_flexible].

## Features

1. Lazy list implementation based on [pull_to_refresh].
2. Image click to view fullscreen based on [photo_view] and [animations].
2. Debug Support based on [jh_debug].
3. UI kit by [bruno] and [getwidget].
4. Global tool by [get].
5. Toast by [fluttertoast].
6. Easy Animation by [animate_do].
7. Video Player by [better player].
8. Permission Handler by [permission handler].
9. HTTP requests by [Request] based on [Dio].
10. Picker by [file picker] and [image picker].
11. Image cropper by [crop your image].

## Third Party Packages

```yaml
cached_network_image: ^3.1.0
photo_view: ^0.13.0
animations: ^2.0.2
bruno: ^2.1.0-nullsafety.1
fl_chart: ^0.45.1
get: ^4.6.1
getwidget: ^2.0.5
pull_to_refresh: ^2.0.0
jh_debug: ^1.0.1
fluttertoast: ^8.0.8
animate_do: ^2.1.0
shared_preferences: ^2.0.13 
flutter_datetime_picker: ^1.5.1
permission_handler: ^9.2.0
better_player: ^0.0.81
dio: ^4.0.3
synchronized: ^3.0.0
crop_your_image: ^0.7.2
image_picker: ^0.8.4+11
file_picker: ^4.5.1
flustars: ^2.0.1
```
## Getting started

```shell
flutter pub add kommon
```

and start your development.


## Usage

### Overview

This package contains folders below:
- cache
- dialog
- image
  - ImgView
- list
  - LazyList
- picker
- request
  - Request with Logger
- tool
  - DateUtil
  - LogUtil
  - PermUtil
  - SpUtil
  - TipsUtil(Toast)
- video
  - VideoPlayer

### Screen / Pages

- PhotoGalleryScreen
  - show a photo gallery, used by [ImgView]
- ImageCropScreen
  - Image Crop

### Services
Services are based on [GetX Service]. Please use `Get.put` or `Get.lazyPut` to initialize first.

- CacheService
- DialogService
- ImageCropService
- PickerService