# Demo App

Demo Mobile Application.

<details>
  <summary>Architecture & code organization</summary>

```sh
.
├── android                   # android
├── assets                    # assets
├── ios                       # ios
├── lib                       # library
│   ├── blocs                     # state mangement implementation with bloc
│   ├── components                # components: general components found throughout the app.
│   ├── models                    # 
│   ├── repositories              # 
│   ├── utils                     # shared utilities: constants, extensions, validators etc.
│   ├── screens                   # screens & pages.
│   └── main.dart
└── test                      # testing
```

</details>

## Design File
[Todo app figma design file](https://www.figma.com/file/y1U2Y6XbxsR46QCa6Sdxsz/ToDos-FrontendMentor-(Community)?node-id=0%3A1)


## Major dependencies used in project
- [firebase-auth](https://pub.dev/packages/firebase_auth) for authentication of users
- [flutter-bloc](https://pub.dev/packages/flutter_bloc) for state management
- [hive-flutter](https://pub.dev/packages/hive_flutter) for local data persistence 
- [get-it](https://pub.dev/packages/get_it) as a service locator
- [dartz](https://pub.dev/packages/dartz) for functional handling of errors.


### Mobile view

<img width="202" alt="Screenshot 2022-11-04 at 09 14 15" src="https://user-images.githubusercontent.com/48961332/229386844-adc88319-a563-4d03-9cf7-38fc7318799d.png">

<img width="202" alt="Screenshot 2022-11-04 at 09 14 15" src="https://user-images.githubusercontent.com/48961332/229386967-3a29cd53-1352-479d-a5be-89580a95d292.png">

<img width="202" alt="Screenshot 2022-11-04 at 09 14 15" src="https://user-images.githubusercontent.com/48961332/229386975-230210dd-9093-4e53-a2d7-f2828a17916b.png">




