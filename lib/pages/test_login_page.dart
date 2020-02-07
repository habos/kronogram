import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class usernamebox extends StatelessWidget {
  const usernamebox({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children:<Widget>[Row(children:<Widget>[
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),


          shape: BoxShape.circle,


        ),

      ),
      Container(
        width: 230,
        height: 29,
        decoration: BoxDecoration(
          color: const Color(0xffffffff).withOpacity(0.79),

          borderRadius: BorderRadius.circular(10),



        ),
        child:const Text(
          'username',

          style: TextStyle(
            fontFamily: 'Helvetica Neue',
            fontSize: 20,

            color: Color(0xff707070),


          ),
        ),
      )],),
      Container(
        width: 230,
        height: 1,
        color: const Color(0xff707070),

      )],);
  }
}

class passwordbox extends StatelessWidget {
  const passwordbox({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children:<Widget>[Row(children:<Widget>[
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),


          shape: BoxShape.circle,


        ),

      ),
      Container(
        width: 230,
        height: 29,
        decoration: BoxDecoration(
          color: const Color(0xffffffff).withOpacity(0.79),

          borderRadius: BorderRadius.circular(10),



        ),
        child:const Text(
          'username',

          style: TextStyle(
            fontFamily: 'Helvetica Neue',
            fontSize: 20,

            color: Color(0xff707070),


          ),
        ),
      )],),
      Container(
        width: 230,
        height: 1,
        color: const Color(0xff707070),

      ),Row(children:<Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),


            shape: BoxShape.circle,


          ),

        ),Column(children:<Widget>[
          Container(
            width: 230,
            height: 29,
            decoration: BoxDecoration(
              color: const Color(0xffffffff).withOpacity(0.79),

              borderRadius: BorderRadius.circular(10),



            ),
            child:const Text(
              'password',

              style: TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 20,

                color: Color(0xff707070),


              ),
            ),
          ),
          Container(
            width: 230,
            height: 1,
            color: const Color(0xff707070),

          )],)],)],);
  }
}

class loginbutton extends StatelessWidget {
  const loginbutton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children:<Widget>[Row(children:<Widget>[
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),


          shape: BoxShape.circle,


        ),

      ),
      Container(
        width: 230,
        height: 29,
        decoration: BoxDecoration(
          color: const Color(0xffffffff).withOpacity(0.79),

          borderRadius: BorderRadius.circular(10),



        ),
        child:const Text(
          'username',

          style: TextStyle(
            fontFamily: 'Helvetica Neue',
            fontSize: 20,

            color: Color(0xff707070),


          ),
        ),
      )],),
      Container(
        width: 230,
        height: 1,
        color: const Color(0xff707070),

      ),Row(children:<Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),


            shape: BoxShape.circle,


          ),

        ),Column(children:<Widget>[
          Container(
            width: 230,
            height: 29,
            decoration: BoxDecoration(
              color: const Color(0xffffffff).withOpacity(0.79),

              borderRadius: BorderRadius.circular(10),



            ),
            child:const Text(
              'password',

              style: TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 20,

                color: Color(0xff707070),


              ),
            ),
          ),
          Container(
            width: 230,
            height: 1,
            color: const Color(0xff707070),

          )],)],),
      Container(
        width: 100,
        height: 29,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),

          borderRadius: BorderRadius.circular(10),



        ),
        child:const Text(
          'LOGIN',

          style: TextStyle(
            fontFamily: 'Helvetica Neue',
            fontSize: 15,

            color: Color(0xff707070),


          ),
        ),
      )],);
  }
}

class cancelbutton extends StatelessWidget {
  const cancelbutton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children:<Widget>[Row(children:<Widget>[
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),


          shape: BoxShape.circle,


        ),

      ),
      Container(
        width: 230,
        height: 29,
        decoration: BoxDecoration(
          color: const Color(0xffffffff).withOpacity(0.79),

          borderRadius: BorderRadius.circular(10),



        ),
        child:const Text(
          'username',

          style: TextStyle(
            fontFamily: 'Helvetica Neue',
            fontSize: 20,

            color: Color(0xff707070),


          ),
        ),
      )],),
      Container(
        width: 230,
        height: 1,
        color: const Color(0xff707070),

      ),Row(children:<Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),


            shape: BoxShape.circle,


          ),

        ),Column(children:<Widget>[
          Container(
            width: 230,
            height: 29,
            decoration: BoxDecoration(
              color: const Color(0xffffffff).withOpacity(0.79),

              borderRadius: BorderRadius.circular(10),



            ),
            child:const Text(
              'password',

              style: TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 20,

                color: Color(0xff707070),


              ),
            ),
          ),
          Container(
            width: 230,
            height: 1,
            color: const Color(0xff707070),

          )],)],),Row(children:<Widget>[
        Container(
          width: 100,
          height: 29,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),

            borderRadius: BorderRadius.circular(10),



          ),
          child:const Text(
            'LOGIN',

            style: TextStyle(
              fontFamily: 'Helvetica Neue',
              fontSize: 15,

              color: Color(0xff707070),


            ),
          ),
        ),
        Container(
          width: 100,
          height: 29,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),

            borderRadius: BorderRadius.circular(10),



          ),
          child:const Text(
            'CANCEL',

            style: TextStyle(
              fontFamily: 'Helvetica Neue',
              fontSize: 15,

              color: Color(0xff707070),


            ),
          ),
        )],)],);
  }
}

class loggedin extends StatelessWidget {
  const loggedin({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children:<Widget>[Row(children:<Widget>[
      Container(
        width: 230,
        height: 1,
        color: const Color(0xff707070),

      ),SvgPicture.asset(
        'assets/login background.svg',
        width: 211.62,
        height: 160.77,
      )],),Row(children:<Widget>[
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),


          shape: BoxShape.circle,


        ),

      ),
      Container(
        width: 230,
        height: 29,
        decoration: BoxDecoration(
          color: const Color(0xffffffff).withOpacity(0.79),

          borderRadius: BorderRadius.circular(10),



        ),
        child:const Text(
          'username',

          style: TextStyle(
            fontFamily: 'Helvetica Neue',
            fontSize: 20,

            color: Color(0xff707070),


          ),
        ),
      )],),Row(children:<Widget>[
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),


          shape: BoxShape.circle,


        ),

      ),Column(children:<Widget>[
        Container(
          width: 230,
          height: 29,
          decoration: BoxDecoration(
            color: const Color(0xffffffff).withOpacity(0.79),

            borderRadius: BorderRadius.circular(10),



          ),
          child:const Text(
            'password',

            style: TextStyle(
              fontFamily: 'Helvetica Neue',
              fontSize: 20,

              color: Color(0xff707070),


            ),
          ),
        ),
        Container(
          width: 230,
          height: 1,
          color: const Color(0xff707070),

        )],)],),Row(children:<Widget>[
      Container(
        width: 100,
        height: 29,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),

          borderRadius: BorderRadius.circular(10),



        ),
        child:const Text(
          'LOGIN',

          style: TextStyle(
            fontFamily: 'Helvetica Neue',
            fontSize: 15,

            color: Color(0xff707070),


          ),
        ),
      ),
      Container(
        width: 100,
        height: 29,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),

          borderRadius: BorderRadius.circular(10),



        ),
        child:const Text(
          'CANCEL',

          style: TextStyle(
            fontFamily: 'Helvetica Neue',
            fontSize: 15,

            color: Color(0xff707070),


          ),
        ),
      )],)],);
  }




}
