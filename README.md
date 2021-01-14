# Descriptiom

Superformula mobile Flutter test.

# About

This project was developed following the TDD metodologies and using a clean architecture to separate the components as be as close as possible from the SOLID principles.

For state management and DI the library `riverpod` is used.

This app is separates in 3 main features:
- `Home`: Just the home
- `Scan`: The Scan a QRCode feture
- `Generate`: The generate a QRCode feature

The `Home` feature only contains the following presentation layer elements:
- `home_page.dart`: renders the home
- `home_viewmodel.dart`: manages the menu items state.
- `expandable_menu_button`: the menu button widget that handles the menu.

The `Scan` feature contains presentation, domain and data layers.
- presentation: This is the layer that handles all the needed presentation logic and rendering. There is a `scan_page` to renders the widget tree usind a `Consumer` to react to state changes made by the `scan_viewmodel` which is the one that receives events from the view and interacts with the usecase.
- domain: This layer is responsable for the business logic handling the repositories and providing information to the view models. There is a `validate_seed_usecase` that just forwards the seed information to the repository and awaits for a reponse. Is this layers there is also a entity wich is the model used to comunicate by the repositories and data sources and the repositories contracts.
- data: This layer is responsable to comunicate to the data sources and convert the response into defined models. The repository is implemented to handle the data sources, the model is the responsable to parse the information into objects and the data source is the one that connects to external or internal resources such as APIs, Local Storage, Phone States and others.

Besides the features, the also has a core folder with logic and resources that are or will be needed in other parts of the code.

The data flow is the following:
Page <> Viewmodel <> Usecase <> Repository <> Data Source || Models and Entities

## Testing
The folder structure of the test is the same as the src to facilitate the understanding of the existing tests and to facilitate the creation of new ones.

This project uses Mockito to mock the dependencies.

Is important to note that due to lack of time I've decided to not implement some tests in the viewmodel layer, but I will do so in the following week.

## Run the code
Just use the standard `flutter run`.

* Emulators does not have cameras, so the scan feature will not scan!!