import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:royal_taxi_beta/constants/styles.dart';

class RTTextField<T> extends StatelessWidget {
  final String hintText;
  final String? icon;
  final bool isPassword;
  final bool isDropdown;
  final Widget? suffix;
  final T? dropdownValue;
  final List<T>? dropdownItems;
  final int? lengthLimit;
  final Function(T? value)? onDropdownChanged;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  const RTTextField({
    super.key,
    required this.hintText,
    this.icon,
    this.isPassword = false,
    this.controller,
    this.isDropdown = false,
    this.dropdownValue,
    this.dropdownItems,
    this.onDropdownChanged,
    this.suffix,
    this.lengthLimit,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    bool isObscur = true;
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: whiteColor.withOpacity(.5),
        borderRadius: BorderRadius.circular(defaultBorderRadius + 5),
        border: Border.all(
          color: greyColor60,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: StatefulBuilder(builder: (context, setter) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (suffix != null) ...[suffix!],
                    if (icon != null) ...[
                      SvgPicture.asset(
                        "assets/svgs/$icon.svg",
                        height: 18.0,
                        colorFilter: const ColorFilter.mode(
                            primaryColor, BlendMode.srcIn),
                      ),
                    ],
                    const SizedBox(width: 5.0),
                    if (isPassword) ...[
                      Flexible(
                        child: TextField(
                          controller: controller,
                          keyboardType: TextInputType.text,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: blackColor80,
                                    fontWeight: FontWeight.w500,
                                  ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: hintText,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: blackColor80,
                                  fontWeight: FontWeight.w400,
                                ),
                            counterText: '',
                          ),
                          obscureText: isObscur,
                        ),
                      )
                    ] else ...[
                      if (isDropdown) ...[
                        Expanded(
                          child: DropdownButtonFormField<T>(
                            menuMaxHeight: 300,
                            dropdownColor: Colors.white,
                            focusColor: Colors.white,
                            isExpanded: true,
                            alignment: Alignment.centerLeft,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: blackColor80,
                                  fontWeight: FontWeight.w500,
                                ),
                            value: dropdownValue,
                            hint: Text(
                              hintText,
                              style: const TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: blackColor80,
                                    fontWeight: FontWeight.w500,
                                  ),
                              counterText: '',
                            ),
                            items: dropdownItems!.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: const Color.fromARGB(
                                            255, 95, 93, 93),
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              onDropdownChanged!.call(value);
                            },
                          ),
                        )
                      ] else ...[
                        Flexible(
                          child: TextField(
                            controller: controller,
                            keyboardType: keyboardType ?? TextInputType.text,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: blackColor80,
                                  fontWeight: FontWeight.w500,
                                ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: hintText,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: blackColor80,
                                    fontWeight: FontWeight.w500,
                                  ),
                              counterText: '',
                            ),
                            inputFormatters: lengthLimit != null
                                ? [
                                    LengthLimitingTextInputFormatter(
                                        lengthLimit), // Limiting to 5 characters
                                  ]
                                : null,
                          ),
                        )
                      ]
                    ]
                  ],
                ),
              ),
              if (isPassword) ...[
                GestureDetector(
                  onTap: () {
                    setter(() {
                      isObscur = !isObscur;
                    });
                  },
                  child: SvgPicture.asset(
                    !isObscur
                        ? "assets/svgs/eye-slash-alt.svg"
                        : "assets/svgs/eye-alt.svg",
                    height: 20.0,
                    colorFilter:
                        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                )
              ]
            ],
          );
        }),
      ),
    );
  }
}
