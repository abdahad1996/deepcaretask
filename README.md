
# deepcaretask is an app that tracks every 10 secs if any number we receive through an api is a prime number 


## Installation Guide
- clone the repo and just pressing the play button should make things work if not please contact me.
-  make sure you have the following version
Flutter 3.27.4 • channel stable 
Tools • Dart 3.6.2 • DevTools 2.40.3


## Screenshots 
![Simulator Screenshot - iPhone 16 Pro - 2025-02-12 at 19 50 50](https://github.com/user-attachments/assets/20489efb-d267-40ef-8e2a-4a9bc3495549)

![Simulator Screenshot - iPhone 16 Pro - 2025-02-12 at 19 51 08](https://github.com/user-attachments/assets/b5e9100a-26e0-4394-9f6e-be405b50391c)

## Testing Strategy and Code Coverage
<img width="1349" alt="Screenshot 2025-02-12 at 11 55 53 PM" src="https://github.com/user-attachments/assets/566ea98b-5f39-4d20-bbbf-4f13dd3adbd0" />

my testing strategy was based on unit tests in isolation and i used an inside out approach and tested out first domain layer, data layer and presentation layer in isolation before in the end i worked on the UI and used widget test to check if integeration worked correctly. if i had more time i would write user story tests to check if everything worked correctly.

## Architecture
<img width="843" alt="Screenshot 2025-02-13 at 12 39 16 AM" src="https://github.com/user-attachments/assets/a8e34bf6-ae13-464e-af6a-35f220f3dad9" />

Diagram illustrates how we can separate Core Domain from API, Presentation and UI. Basically, Domain serves as a main layer for any feature (a.k.a business logic that is platform-agnostic).

API is in turn business logic that is platform-specific (i.e. it depends on the platform, but Core Domain does not depend on anything). Note here that APIClient lives inside Data Layer along with RemoteWeeklyForcastModel since we do not want to depend on other modules (invert the dependency) and force infrastructure components to be plugged-in.

Infrastructure components live at the boundary of the system. It could be HTTP/DIO/Any implemention you prefer. Frameworks are just plug-ins and we can easily replace them without affecting the rest of the system.

Presentation is used for not letting UI to depend on Domain. Presentation layer is mainly used for separating UI from domain models and managing the state. Thus, Presentation layer simply includes everything UI needs to render which in this case is done using Bloc .

UI is last piece in the chain and can be swapped easily (since no other layers depend on it). This diagram shows flutter as our main UI code which is used to render Android and iOS but we can reuse everything else as well for other platforms like web and desktop and only have to update the UI.

Composition Root is the most important glue part that bridges communication between domain, services and UI. This is where the entry point of our app is and in this case in the `main()` function . this layer is where all the instantiation happends and also where navigation and dependency injection takes place.

## Requirements
### Acceptance criterias
✅ The app should every 10 seconds call an API that returns a random number

✅ If the number returned is a prime number, the app changes to a screen that notifies the user, similar to this:

✅ Where X it’s the prime number received from the API and YY is the time elapsed since the last prime number.

✅ if the app is closed, next time it is open it should correctly calculate the time elapsed since the last prime number.


