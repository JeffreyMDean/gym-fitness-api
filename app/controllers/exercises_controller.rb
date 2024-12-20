require 'http'

class ExercisesController < ApplicationController
  BASE_URL = "https://wger.de/api/v2" 
  # https://wger.de/api/v2/exercise/

  EXERCISE_DETAILS = {
    "2 Handed Kettelbell Swing" => {
      descrition: "Standard kettlebell swing that targets the hips, glutes, and core.",
      image_url: "https://www.nsca.com/contentassets/ec565b123b994f93a9b6128217de98f4/kinetic-select-two-arm-kettlebell-swing.jpg",
      video_url: "https://www.youtube.com/watch?v=m-S9H2XVvYg"
    },
    "3D lunge warmup" => {
      description: "A dynamic warm-up that combines a forward lunge, side lunge, and curty lunge preparing the athlete for more rigorous activity.",
      image_url: "https://www.bodybuilding.com/images/2019/metaburn90/mb90-xdb-3d-dumbbell-lunge-1.jpg",
      video_url: "https://www.google.com/search?sca_esv=e5ef70f8f2be8644&rlz=1C5CHFA_enUS1103US1103&sxsrf=ADLYWIKTEitt7GBNUskZX9HWKdhBzti5_w:1734377219223&q=3d+lunge&udm=7&fbs=AEQNm0DvD4UMlvdpwktgGj2ZHhIXGAJa2ynEsR_PkpzyY3-5iXmC2MAZD4oHfv8rQvObNClFtmz3Piv2BNTAaundgz7JWf701AHCW6YVbzUyzVo55l490f8X20CnCQT41reGfte9fiav0jY6JctFyHj_kY-vbGT5gl0DOJtqzI3-Ie6yNs7elDyTDwEjF3iWFTwhqQVgTDY_Cr5fdf87P3xD72LRPNK5fw&sa=X&ved=2ahUKEwjsrbvQgq2KAxWdl4kEHVu0OmYQtKgLegQIDRAB&biw=960&bih=934&dpr=1#fpstate=ive&vld=cid:f7bcbbdb,vid:zoCmgEzqkQQ,st:0"
    },
    "4-Hitung burpe" => {
      description: "A variant of the classic Burpee exercise that is also great for strength and conditioning.",
      image_url: "https://lh3.googleusercontent.com/mwNk92_njIH84En4n30bUl1pfEQ4aKsNeJJIWsPsHHZV31YIM9-azZqphC5tijzuG3Lx5P0qq4sOKR3gRjBgnQ=s800",
      video_url: "https://www.google.com/search?sca_esv=e5ef70f8f2be8644&rlz=1C5CHFA_enUS1103US1103&sxsrf=ADLYWIIzCq7TYrwOpfBGo45fPwgRr8qAvQ:1734377611799&q=advanced+burpee+exercise&udm=7&fbs=AEQNm0DvD4UMlvdpwktgGj2ZHhIXGAJa2ynEsR_PkpzyY3-5iXmC2MAZD4oHfv8rQvObNCmK88Qj7r931uIdbKpKo6rLlxAn_3ocB4k4beoC7ie0cOBu1fDXoyrV7e-FvenyhPRq_11f67gQ8wdvYsb9N_kz9YEPBVDTOjWkEbhMEwvxjirWVlfUdnBRtBzQ-_SNzbp0JIpUgAJDARgFI8FDV3D4bljKVg&sa=X&ved=2ahUKEwiHm9SLhK2KAxXpGtAFHVjsL-0QtKgLegQICxAB&biw=960&bih=934&dpr=1#fpstate=ive&vld=cid:3e2e1e0b,vid:_xd774h84ao,st:0"
    },
    "4-count burpees" => {
      description: "The original Burpee exercise that involves moving the a low squat position and then transitioning to a plank position and then returning to the low squat position and then exploding updward.",
      image_url: "https://www.eszterboros.com/uploads/8/5/4/6/85462056/burpee_1.jpg?300",
      video_url: "https://www.google.com/search?sca_esv=e5ef70f8f2be8644&rlz=1C5CHFA_enUS1103US1103&sxsrf=ADLYWIILmiwvKizntHiSS-V6jYGgANfGCw:1734377836779&q=4+count+burpees&udm=7&fbs=AEQNm0DvD4UMlvdpwktgGj2ZHhIXGAJa2ynEsR_PkpzyY3-5iXmC2MAZD4oHfv8rQvObNClFtmz3Piv2BNTAaundgz7JWf701AHCW6YVbzUyzVo55l490f8X20CnCQT41reGfte9fiav0jY6JctFyHj_kY-vbGT5gl0DOJtqzI3-Ie6yNs7elDyTDwEjF3iWFTwhqQVgTDY_Cr5fdf87P3xD72LRPNK5fw&sa=X&ved=2ahUKEwjd-vf2hK2KAxUn6ckDHeE7IWIQtKgLegQICRAB&biw=960&bih=934&dpr=1#fpstate=ive&vld=cid:8fcfaa23,vid:idRaKSD5iHI,st:0"
    },
    "4-tel burpees" => {
      description: "A variation of burpees with unique timing or movement pattern",
      image_url: "https://www.24hourfitness.com/24life/fitness/2018/media_12c73b297296596ac7b695b29c2adb146893ae13b.jpeg?width=750&format=jpeg&optimize=medium",
      video_url: "https://www.google.com/search?sca_esv=e5ef70f8f2be8644&rlz=1C5CHFA_enUS1103US1103&sxsrf=ADLYWIJIMj_mzwj6IkISn8TmvOVXC4ZMPw:1734378138502&q=burpee+exercise&udm=7&fbs=AEQNm0DvD4UMlvdpwktgGj2ZHhIXGAJa2ynEsR_PkpzyY3-5iXmC2MAZD4oHfv8rQvObNCmK88Qj7r931uIdbKpKo6rLlxAn_3ocB4k4beoC7ie0cOBu1fDXoyrV7e-FvenyhPRq_11f67gQ8wdvYsb9N_kz9YEPBVDTOjWkEbhMEwvxjirWVlfUdnBRtBzQ-_SNzbp0JIpUgAJDARgFI8FDV3D4bljKVg&sa=X&ved=2ahUKEwip3ueGhq2KAxXmMtAFHSBaGaUQtKgLegQIDxAB&biw=960&bih=934&dpr=1#fpstate=ive&vld=cid:f5a30f42,vid:auBLPXO8Fww,st:0"
    },
    "4-العد burpees" => {
      description: "Another burpee variation common to Arabice speaking countries.",
      image_url: "https://wildworkoutsandwellness.com/wp-content/uploads/2018/01/burpee.jpg",
      video_url: "https://www.google.com/search?sca_esv=e5ef70f8f2be8644&rlz=1C5CHFA_enUS1103US1103&sxsrf=ADLYWILLd_XP6irrCewB4G1xqmqlQTn4Cw:1734378272524&q=4-%D8%A7%D9%84%D8%B9%D8%AF+burpees&udm=7&fbs=AEQNm0DvD4UMlvdpwktgGj2ZHhIXi58ra1MCmgeKkVE8y_uPCA_VArK8eDJ3eXUe-YWeaCBH-amb2Pf6-dxDrKVpML-nj-Q0usp9oUfQBWygHdzlPQyK7ekinri2xZNEevPNnSWXBwllpEgX7aD0z7Bz9Smf6FJNeCdJxssgOmj0CiTHs___g-FoVbY408ufrjMLdYcAMcnx3YBi6Ge-Y81wpmFeMjBDzQ&sa=X&ved=2ahUKEwis3dvGhq2KAxWSw8kDHZM1LI8QtKgLegQIDxAB&biw=960&bih=934&dpr=1#fpstate=ive&vld=cid:1dfa2026,vid:-7Sfx2N9L1Y,st:0"
    },
    "Abdominal" => {
      description: "Abdominal exercise",
      image_url: "https://www.shutterstock.com/shutterstock/photos/1847940811/display_1500/stock-vector-man-doing-sit-ups-exercise-abdominals-exercise-flat-vector-illustration-isolated-on-white-1847940811.jpg",
      video_url: "https://www.youtube.com/watch?v=UMaZGY6CbC4"
    },
    "Abdominal Stabilization" => {
      description: "Plank exercise for building core endurance.",
      image_url: "https://hips.hearstapps.com/hmg-prod/images/hdm119918mh15842-1545237096.png?crop=0.668xw:1.00xh;0.117xw,0&resize=1200:*",
      video_url: "https://www.google.com/search?sca_esv=32e55b09f5ce6c02&rlz=1C5CHFA_enUS1103US1103&sxsrf=ADLYWIKUsxpHdD3XkIqgPvaZhsAaNH7ZAQ:1734457389408&q=plank+exercise&udm=7&fbs=AEQNm0DvD4UMlvdpwktgGj2ZHhIXi58ra1MCmgeKkVE8y_uPCA_VArK8eDJ3eXUe-YWeaCDTaS-9KZxf_q_lXbj36rBvuqGrPvZdhrjnynD_idsOjM-7uBtmOoAiwbCyei1nztc60277totLhOMYt_eqX11K7Wtq2aCdy3i9Nk9IA_FDD64Goj3F18tZAWLN8F88SAagzc2LkNaRSskpuGKCB21ljiiBXQ&sa=X&ved=2ahUKEwiMlcukra-KAxWkjokEHf9XHR4QtKgLegQICRAB&biw=960&bih=934&dpr=1#fpstate=ive&vld=cid:0e421513,vid:pvIjsG5Svck,st:0"
    },
    "Abdominales" => {
      description: "Another abdominal exercise.",
      image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTloft0bs7t8XXHQiOj02Of1Ltk4BwMHMc9nA&s",
      video_url: "https://www.google.com/search?sca_esv=32e55b09f5ce6c02&rlz=1C5CHFA_enUS1103US1103&sxsrf=ADLYWIK3POW4yiIVWHijWRTU5QFBpm-r-g:1734457536756&q=pike+exercise&udm=7&fbs=AEQNm0Aa4sjWe7Rqy32pFwRj0UkWd8nbOJfsBGGB5IQQO6L3J7pRxUp2pI1mXV9fBsfh39Jw_Y7pXPv6W9UjIXzt09-Y8iKCeX3IocKUiK3MDxH8WV0UwxrluXjeT3eYNHOsrKfPFwudHhi9uwwU_OQdb2ZKMrEuhjw52wOUp2GIgbjGX5PMgtpafaAxH9pNR_wMyqPqGx8CggCelN_5mMziBal4umV7Wg&sa=X&ved=2ahUKEwiDvezqra-KAxXIG9AFHfInJQoQtKgLegQIFBAB&biw=960&bih=934&dpr=1#fpstate=ive&vld=cid:877af6e1,vid:COXMyJ5WQwk,st:0"
    },
    "Abdominales" => {
      description: "Ab exercise that engages the rectus abdominis, obliques, shoudlers, and legs.",
      image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTF8jaXk8E9xY2_KZQgjK-umew0Gmq2eVfXA&s",
      video_url: "https://www.google.com/search?sca_esv=32e55b09f5ce6c02&rlz=1C5CHFA_enUS1103US1103&sxsrf=ADLYWIIFGnMMj0j5gHx8p9wlhsdOCiAHIw:1734457667711&q=mountain+climbers+ab+workout&udm=7&fbs=AEQNm0DvD4UMlvdpwktgGj2ZHhIXGAJa2ynEsR_PkpzyY3-5iXmC2MAZD4oHfv8rQvObNClFtmz3Piv2BNTAaundgz7JWf701AHCW6YVbzUyzVo55l490f8X20CnCQT41reGfte9fiav0jY6JctFyHj_kY-vbGT5gl0DOJtqzI3-Ie6yNs7elDyTDwEjF3iWFTwhqQVgTDY_Cr5fdf87P3xD72LRPNK5fw&sa=X&ved=2ahUKEwjWqKWprq-KAxWD78kDHaxjG6MQtKgLegQIExAB&biw=960&bih=934&dpr=1#fpstate=ive&vld=cid:a5bc9dd5,vid:i7fYCgfoyP0,st:0"
    },
    "Abdominales HD" => {
      description: "This exercise involves lying on one's back while raising and lowering opposite arms and legs.",
      image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfMMM4NioxIGxuF_K7gC23Nloxia60FyCjZQ&s",
      video_url: "https://www.google.com/search?sca_esv=32e55b09f5ce6c02&rlz=1C5CHFA_enUS1103US1103&sxsrf=ADLYWIJPMIXzl0x8grqQzPZuVNTxiyr3Mw:1734457911445&q=dead+bug+exercise&udm=7&fbs=AEQNm0DvD4UMlvdpwktgGj2ZHhIXi58ra1MCmgeKkVE8y_uPCA_VArK8eDJ3eXUe-YWeaCAvvVJnEBjtyIQpxZVe6rk5W7J-SxQZxDEV7UhCPDhYtjWOTC_dbRWeqealUqlNOO65by0QUN24q1cEpMh_n0YtJB1LBxa57Gyr6dvbN1CrQTJB5eylxbQB8BKf4YlG0k-GTldFOQMbxAS3cpVR14_Ym2I4ng&sa=X&ved=2ahUKEwiy58Gdr6-KAxUkDHkGHdtSKTcQtKgLegQIEhAB&biw=960&bih=934&dpr=1#fpstate=ive&vld=cid:b4dfdb3c,vid:bxn9FBrt4-A,st:0"
    },
    "Abdominales sovieticas" => {
      description: "This exercise involves sitting on the floor and rotating your torso from side to side.",
      image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpi58JRr5EC8cbhCQj7IwExTDKRj-jPF-FAQ&s",
      video_url: "https://www.google.com/search?sca_esv=32e55b09f5ce6c02&rlz=1C5CHFA_enUS1103US1103&sxsrf=ADLYWIJitDoGrfi_NMU9jwseqRssCgMYUA:1734458131419&q=Abdominales+sovieticas&udm=7&fbs=AEQNm0Aa4sjWe7Rqy32pFwRj0UkWd8nbOJfsBGGB5IQQO6L3J7pRxUp2pI1mXV9fBsfh39Jw_Y7pXPv6W9UjIXzt09-YEIs5ATTcnTjDJVNBp4RbjWfOwdDigA7cgGTMAUqYq-XHEDvQBj6Tl1QS1iTN88pVlmn091C3m1whg-P_znMBPc134Mo5pdLl6dOdpk_DVU2P2jhAuxqhhJeiHOdPxH_lV-0F7w&sa=X&ved=2ahUKEwidgLSGsK-KAxUBMNAFHRMpCSMQtKgLegQIGBAB&biw=960&bih=934&dpr=1#fpstate=ive&vld=cid:21b0f831,vid:6MaGBhDDZ5w,st:0"
    },
    "Abdominaux" => {
      description: "Similar to a situp, except the athlete only raises themselves off the ground slightly while engaging the core.",
      image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTcz35IPlUHCWbw2_q8oGouIphFELiH3et0qA&s",
      video_url: "https://www.google.com/search?sca_esv=32e55b09f5ce6c02&rlz=1C5CHFA_enUS1103US1103&sxsrf=ADLYWIJ4depRMAPPXTtRisDNeP_0Ohz_cQ:1734458280524&q=crunch+exercise&udm=7&fbs=AEQNm0Aa4sjWe7Rqy32pFwRj0UkWd8nbOJfsBGGB5IQQO6L3J7pRxUp2pI1mXV9fBsfh39Jw_Y7pXPv6W9UjIXzt09-YDFw5jdLalJGTuCXHbQcty_EBVVxoW_MbFuNpau2R2xJ4G5pPVLpZydMDNFChslFu8qHypRl4bk1tbCF2fhdwqkH0o1q5_C-kgC6b7a68vFnYSwSLStepl-bJ8kfm0LJSZqkzbQ&sa=X&ved=2ahUKEwjCxcDNsK-KAxUnMdAFHfiTOg8QtKgLegQIEhAB&biw=960&bih=934&dpr=1#fpstate=ive&vld=cid:9a1e5c31,vid:5ER5Of4MOPI,st:0"
    },
    "Abduktion im Stand" => {
      description: "This exercise strengthens the hip abductors.",
      image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTacdRsx3dLzey4L11Csr7ksyjlPTj6wLzq4A&s",
      video_url: "https://www.google.com/search?sca_esv=32e55b09f5ce6c02&rlz=1C5CHFA_enUS1103US1103&sxsrf=ADLYWIKOplEnUkdgAK9laQngdvGVQZUvtQ:1734458590464&q=standing+hip+abduction&udm=7&fbs=AEQNm0CI3085mQvq38n2Ub64z3TRfpRK3g8q4O-xBtJsSic-cIV0T0xPWbSDKEp9B2zrGNV43pDGmAmrizK5im04hsONuRbpLmlnmUEJ4HNEcAJaUU9b43FpRHtfAjZCh6kfFPCDRTDF3O-0JMVCk4ZPIDYqx_Ny-WICONc74oYm_BD2b2u5cRSPPng5HNwyNHackf8-fDoc2HoQYU--jy_U2BkzibWnpQ&sa=X&ved=2ahUKEwiN6KXhsa-KAxV0m4kEHWqWIooQtKgLegQIExAB&biw=960&bih=934&dpr=1#fpstate=ive&vld=cid:57b95768,vid:LzuvLW_gJ8w,st:0"
    },
    "Abduktion im Stand" => {
      description: "This is another example of an exercise that targets the hip abductors.",
      image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8cXLqcR9Q88tdj18qDdo_4FPPKhwzvr0Biw&s",
      video_url: "https://www.google.com/search?sca_esv=32e55b09f5ce6c02&rlz=1C5CHFA_enUS1103US1103&sxsrf=ADLYWIJvvDQGYWv6-43C2AJ2qJW-S9d95g:1734458841695&q=lying+down+hip+abduction&udm=7&fbs=AEQNm0Aa4sjWe7Rqy32pFwRj0UkWd8nbOJfsBGGB5IQQO6L3J7pRxUp2pI1mXV9fBsfh39JCKYzNzXO6dfdIIE6ViBeP7nek4lwWCLzlulT7htUOv44DXj-uZAP4_PgPPgWAK4hn38BipYnR98JREAi-_GPJki9prxEOj3tChnLu9Sn8R8zuy4lf_C0moKsnseyvrafjiaFU6dYO0MbtI-JQL6wCT5YaCw&sa=X&ved=2ahUKEwiM4YvZsq-KAxWi4skDHZHULOYQtKgLegQIExAB&biw=960&bih=934&dpr=1#fpstate=ive&vld=cid:056b48e7,vid:mxWissvKVj0,st:0"
    },
    "Abduktoren-Maschine" => {
      description: "This is how to strengthen the hip abductors while utilizing a machine deisgned for this purpose.",
      image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxVC4yBd4b5A8wFzGv-IZCJAgnIqHKsdJhSA&s",
      video_url: "https://www.google.com/search?q=hip+abduction+machine&sca_esv=32e55b09f5ce6c02&rlz=1C5CHFA_enUS1103US1103&udm=7&biw=960&bih=934&sxsrf=ADLYWIJ10Jw4UebqHpl0jIpaCL1b2QRrOg%3A1734459048547&ei=qL5hZ8WCIbbfp84P2I3W4AQ&ved=0ahUKEwjF9ty7s6-KAxW278kDHdiGFUwQ4dUDCBA&uact=5&oq=hip+abduction+machine&gs_lp=EhZnd3Mtd2l6LW1vZGVsZXNzLXZpZGVvIhVoaXAgYWJkdWN0aW9uIG1hY2hpbmUyChAAGIAEGEMYigUyChAAGIAEGBQYhwIyChAAGIAEGBQYhwIyBRAAGIAEMgUQABiABDIFEAAYgAQyBRAAGIAEMgUQABiABDIFEAAYgAQyBRAAGIAESJQIUNsBWNsBcAF4AZABAJgBV6ABV6oBATG4AQPIAQD4AQGYAgKgAmHCAgoQABiwAxjWBBhHmAMAiAYBkAYIkgcBMqAHuAY&sclient=gws-wiz-modeless-video#fpstate=ive&vld=cid:e3c2e561,vid:G_8LItOiZ0Q,st:0"
    },
    "Abwechselnde Bizepscurls" => {
      description: "This is a standard bicep curl.",
      image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqMrJzmL5oktoKCyn7MNz3prV_tdE0hTnGqw&s",
      video_url: "https://www.google.com/search?sca_esv=32e55b09f5ce6c02&rlz=1C5CHFA_enUS1103US1103&sxsrf=ADLYWIKv33xtrJlyRGtKbLGInFA0rtPhcQ:1734459166022&q=bicep+curl&udm=7&fbs=AEQNm0CI3085mQvq38n2Ub64z3TRfpRK3g8q4O-xBtJsSic-cIV0T0xPWbSDKEp9B2zrGNV43pDGmAmrizK5im04hsONuRbpLmlnmUEJ4HNEcAJaUU9b43FpRHtfAjZCh6kfFPCDRTDF3O-0JMVCk4ZPIDYqx_Ny-WICONc74oYm_BD2b2u5cRSPPng5HNwyNHackf8-fDoc2HoQYU--jy_U2BkzibWnpQ&sa=X&ved=2ahUKEwju99rzs6-KAxUiGtAFHQpGD04QtKgLegQIEhAB&biw=960&bih=934&dpr=1#fpstate=ive&vld=cid:906d8972,vid:ykJmrZ5v0Oo,st:0"
    },
    "Accroupi" => {
      description: "This is a natural movement in which the athlete squats down with their elbows placed on the inner part of their knee for opening up the hips.",
      image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQbM11nNvAVBiVfAYjZ-peuul0dssPyYq5_A&s",
      video_url: "https://www.youtube.com/watch?v=19CPPmI2AxE"
    },
    "Achternek rekken" => {
      description: "A simple neck stretch for improving flexibility.",
      image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWv0fwPMB-m1cyYPaDCbDLnLFLeeJDw6VaJg&s",
      video_url: "https://www.youtube.com/watch?app=desktop&v=s-7lyvblFNI&t=4s"
    },
    "Achterwaartse arm cirkels" => {
      description: "Mobility exercise that involves rotating the arms in a circular motion to increase mobility in the shoulders.",
      image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZALv6ejbOXkqf91wQ5qrtUv1aYpAmAVRJQA&s",
      video_url: "https://www.google.com/search?sca_esv=32e55b09f5ce6c02&rlz=1C5CHFA_enUS1103US1103&sxsrf=ADLYWIK1w8NbVhKoUuGjuhA8YyANTvmt2g:1734459769742&q=arm+circles&udm=7&fbs=AEQNm0DvD4UMlvdpwktgGj2ZHhIXGAJa2ynEsR_PkpzyY3-5iXmC2MAZD4oHfv8rQvObNCmK88Qj7r931uIdbKpKo6rLlxAn_3ocB4k4beoC7ie0cOBu1fDXoyrV7e-FvenyhPRq_11f67gQ8wdvYsb9N_kz9YEPBVDTOjWkEbhMEwvxjirWVlfUdnBRtBzQ-_SNzbp0JIpUgAJDARgFI8FDV3D4bljKVg&sa=X&ved=2ahUKEwidkc-Ttq-KAxW3hIkEHXCgBzUQtKgLegQIDxAB&biw=960&bih=934&dpr=1#fpstate=ive&vld=cid:8dfc50f6,vid:mwDgFY86zck,st:0"
    }
  }
  def index
    response = HTTP.follow(max_hops: 2).get("#{BASE_URL}/exercise") # response from API stored in the response variable
    if response.status.success?           
      exercises = JSON.parse(response.body)['results']
      
      exercise_info = exercises.map do |exercise|
        name = exercise['name'] # accesses name key within ex hash
        details = EXERCISE_DETAILS[name] || {} # linked to name var above

        {
          id: exercise['id'],
          name: name,
          description: details[:description] || "No description available",
          image_url: details[:image_url] || "No Image available",
          video_url: details[:video_url] || "No video available"
        }
      end
      render json: exercise_info 
    else
      render json: { error: "Failed to fetch exercises" }
    end
  end 
    
  def show 
    response = HTTP.follow(max_hops: 2).get("#{BASE_URL}/exercise/#{params[:id]}")

    if response.status.success?
      @exercise = JSON.parse(response.body)
      render json: @exercise
    else  
      render json: { error: "Failed to fetch exercise details" }
    end
  end 
end 
