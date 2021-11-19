import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/components/custom_nav_bar.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/hotelinfo.dart';
import 'package:recipe_app/screens/booking/selectionProvider.dart';

class HotelSelection extends StatefulWidget {

  DateTimeRange _dateRange;
  String _destination;
  HotelSelection({DateTimeRange dateRange, String destination}): _dateRange = dateRange, _destination = destination;

  // const HotelSelection({Key key}) : super(key: key);

  @override
  _HotelSelectionState createState() => _HotelSelectionState();
}

class _HotelSelectionState extends State<HotelSelection> {
  @override
  Widget build(BuildContext context) {
    SelectionProvider selectionProvider = Provider.of<SelectionProvider>(context, listen: true);
    DateFormat dateFormatFullEn = DateFormat('dd MMM yyyy',);
    List<HotelInfo> hotelList = generateHotelInfo(widget._destination, widget._dateRange);
    return Scaffold(
        appBar: CustomAppBar(title: 'Hotel selection',),
        backgroundColor: Colors.grey.shade200,
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.lightSand.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(Icons.hotel, color: AppColors.darkSandColor),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Hotel",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.dark,
                    ),
                  ),
                  Expanded(child: SizedBox(height: 16,)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(widget._destination, style: TextStyle(fontWeight: FontWeight.w600),),
                      SizedBox(height: 4,),
                      Text('${dateFormatFullEn.format(widget._dateRange.start)} - ${dateFormatFullEn.format((widget._dateRange.end))}'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8,),
              Expanded(
                  child: ListView.builder(
                      itemCount: hotelList.length,
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.white,
                            border: Border.all(color: selectionProvider.getSelectedHotel(hotelList, index)? AppColors.kPrimaryColor:AppColors.white)
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(hotelList[index].hotelName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, fontFamily: 'Pangram'),),

                              ],
                            ),
                            SizedBox(height: 16,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(hotelList[index].roomType, style: TextStyle(fontWeight: FontWeight.w600),),
                                SizedBox(width: 16,),
                                Text('${widget._dateRange.end.day-widget._dateRange.start.day} nights'),
                              ],
                            ),
                            SizedBox(height: 8,),
                            Divider(color: AppColors.kPrimaryColor.withOpacity(0.4),),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    hotelList[index].price,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.dark,
                                    ),
                                  ),
                                ),
                                selectionProvider.getSelectedHotel(hotelList, index) ? Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    height: 36,
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text('Selected', style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 18, fontWeight: FontWeight.w600),),
                                    ),
                                  ),
                                ) : Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    height: 36,
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.kPrimaryColor),
                                    child: TextButton(
                                      onPressed: () {
                                        selectionProvider.changeHotelSelection(hotelList, index);
                                        print(selectionProvider.getSelectedHotel(hotelList, index));
                                        //print(hotelList[index].selected);
                                      },
                                      child: Text('Select', style: TextStyle(color: AppColors.white),),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                  )
              ),

              FlatButton.icon(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 18.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: AppColors.kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                icon: const Icon(
                  Icons.airplane_ticket,
                  color: Colors.white,
                ),
                label: Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                textColor: Colors.white,
              ),
            ],
          ),
        )
    );
  }
}
