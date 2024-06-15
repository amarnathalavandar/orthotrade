import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:orthotrade/common/widgets/appbar/appbar.dart';
import 'package:orthotrade/utils/constants/sizes.dart';
import 'package:orthotrade/utils/constants/text_strings.dart';

import '../../../../../common/widgets/dialog/dialog.dart';
class ClientRegistrationForm extends StatelessWidget {
  const ClientRegistrationForm({super.key, required this.formTitle});
final String formTitle;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MOAppBar(showBackArrow: true,title: Text(formTitle)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MOSizes.defaultSpace),
          child: Column(
              children: [
                const SizedBox(height: MOSizes.spaceBtwInputFields),
                TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: MOTexts.businessName,prefixIcon: Icon(Iconsax.building)
                  ),
                ),
                const SizedBox(height: MOSizes.spaceBtwInputFields),
                /// FIRST NAME AND LAST NAME
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        expands: false,
                        decoration: const InputDecoration(labelText: MOTexts.firstName,prefixIcon:Icon(Iconsax.user)),
                      ),
                    ),
                    const SizedBox(width: MOSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        expands: false,
                        decoration: const InputDecoration(labelText: MOTexts.lastName,prefixIcon:Icon(Iconsax.user)),
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: MOSizes.spaceBtwInputFields),
                /// STREET ADDRESS
                TextFormField(
                  expands: false,
                  decoration: const InputDecoration(labelText: MOTexts.streetAddress,prefixIcon:Icon(Iconsax.location)),
                ),
                const SizedBox(height: MOSizes.spaceBtwInputFields),
                /// STREET ADDRESS 1
                TextFormField(
                  expands: false,
                  decoration: const InputDecoration(labelText: MOTexts.streetAddress1,prefixIcon:Icon(Iconsax.location)),
                ),
                const SizedBox(height: MOSizes.spaceBtwInputFields),
                /// CITY
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        expands: false,
                        decoration: const InputDecoration(labelText: MOTexts.city,prefixIcon:Icon(Iconsax.location)),
                      ),
                    ),
                    const SizedBox(width: MOSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        expands: false,
                        decoration: const InputDecoration(labelText: MOTexts.state,prefixIcon:Icon(Iconsax.location)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: MOSizes.spaceBtwInputFields),
                 /// ZIPCODE AND COUNTRY
                 Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        expands: false,
                        decoration: const InputDecoration(labelText: MOTexts.zipcode,prefixIcon:Icon(Iconsax.location)),
                      ),
                    ),
                    const SizedBox(width: MOSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        expands: false,
                        decoration: const InputDecoration(labelText: MOTexts.country,prefixIcon:Icon(Iconsax.location)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: MOSizes.spaceBtwInputFields),
                /// STREET ADDRESS 1
                TextFormField(
                  expands: false,
                  decoration: const InputDecoration(labelText: MOTexts.email,prefixIcon:Icon(Iconsax.edit)),
                ),
                const SizedBox(height: MOSizes.spaceBtwInputFields),
                TextFormField(
                  expands: false,
                  minLines: 2,
                  maxLines: 4,
                  maxLength: 200,
                  maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                  decoration: const InputDecoration(
                      labelText: MOTexts.specialRequests,
                    prefixIcon: Icon(
                      Iconsax.edit_2,
                    ),
                  ),
                ),
                const SizedBox(height: MOSizes.spaceBtwSections),
                // Sign Up Button
                SizedBox(width: double.infinity,
                  child:
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const MODialog(
                          nextScreen: 'navigationmenu',
                          title: 'Successfull!',
                          message: 'Your business has been registered Successfully!',
                        );
                      },
                    );
                  },
                  child: const Text(MOTexts.register),
                ),),
              ],
          ),
        ),
      ),
    );
  }
}
