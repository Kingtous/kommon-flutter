part of widgets;

class ImageSelector extends StatefulWidget {
  final Rx<XFile?> file;
  final double aspectRatio;
  final double? maxWidth;
  final double? maxHeight;

  const ImageSelector({
    Key? key,
    this.aspectRatio = 2.0,
    required this.file,
    this.maxWidth,
    this.maxHeight,
  }) : super(key: key);

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Obx(
        () {
          final hasSelected = widget.file.value != null;
          return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              color: hasSelected ? null : Colors.grey.shade600,
              decoration: hasSelected
                  ? BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: (kIsWeb
                                  ? NetworkImage(widget.file.value!.path)
                                  : FileImage(File(widget.file.value!.path)))
                              as ImageProvider))
                  : null,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: DottedBorder(
                    strokeWidth: hasSelected ? 0 : 1,
                    color: Colors.white70,
                    child: Align(
                        alignment:
                            hasSelected ? Alignment.topRight : Alignment.center,
                        child: InkWell(
                          onTap: () => _handleAddImg(),
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4)),
                            child: Icon(
                                hasSelected ? Icons.close : Icons.add_outlined),
                          ),
                        ))),
              ));
        },
      ).marginAll(4.0),
    );
  }

  _handleAddImg() {
    if (widget.file.value != null) {
      widget.file.value = null;
      return;
    }
    if (kIsWeb) {
      ImagePicker()
          .pickImage(
              source: ImageSource.gallery,
              maxHeight: widget.maxHeight,
              maxWidth: widget.maxWidth)
          .then((f) {
        widget.file.value = f;
      });
    } else {
      Get.bottomSheet(
          BrnCommonActionSheet(
            title: "选择添加图片方式",
            actions: [
              BrnCommonActionSheetItem("相机",
                  actionStyle: BrnCommonActionSheetItemStyle.alert),
              BrnCommonActionSheetItem("相册")
            ],
            clickCallBack: (index, __) {
              if (index == 0) {
                ImagePicker()
                    .pickImage(
                        source: ImageSource.camera,
                        maxHeight: widget.maxHeight,
                        maxWidth: widget.maxWidth)
                    .then((f) {
                  widget.file.value = f;
                });
              } else {
                ImagePicker()
                    .pickImage(
                        source: ImageSource.gallery,
                        maxHeight: widget.maxHeight,
                        maxWidth: widget.maxWidth)
                    .then((f) {
                  widget.file.value = f;
                });
              }
            },
          ),
          backgroundColor: Colors.grey);
    }
  }
}
