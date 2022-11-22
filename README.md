# Studio - Flutter

## Introduction
Today, you will be introduced to mobile app design through building a simple bakery list app! We will leverage a powerful cross-platform framework called Flutter to build an app that can run on the web, your phone, or a native program on Windows, macOS, or Linux.

### Introduction Activity
Consider these questions before beginning:
- As a UX designer, what differences have you seen in mobile app designs versus web designs?
- What are some design aspects you would consider before designing a mobile app for a client?

<br />

## Environment Setup
We will be using flutlab.io, an online Flutter IDE. Using an online environment helps avoid any issues that you may encounter when installing a Flutter development environment locally.

* Visit flutlab.io, and sign in with your Brown Google account.
* Once you sign in, you’ll be taken to your personal dashboard. If a tutorial pops up, keep clicking the right arrow until you are able to press the "Start Coding" button
* On the right sidebar, click the *Clone Project from VCS* button. If you do not see this button, make sure that your window is full-screened for it to appear.
* In the popup window, click the *Public repo* button on the left
* For *URL to repo*, paste `https://github.com/dylanhu7/studio-flutter.git`. The *Project name* should be automatically set to *studio-flutter*.
* Click *Clone*
* Your project will show up in the dashboard. Click it to access the codebase and the online IDE.

You should now see something like this:

![](https://i.imgur.com/FLnECDW.png)

Hover over the blue *Build* button at the top left -- it looks like a play button. Your Flutter app will now be built so that you can run it in an emulator and see your changes take effect in real time. The build process may take a minute or two. Once it finishes, you should see something like this:


![](https://i.imgur.com/tmZMPWYl.png)

<br />

## Flutter Basics
### main.dart
In your newly created-project, you should be automatically navigated to the `main.dart` file. If you don't see `main.dart`, navigate to it by clicking through the file explorer on the left side -- it will be inside the `lib` folder.

`main.dart` is the starting point for your app, similar to a `main` method in Java or the `App` component in React. It holds the root `Widget` for our Flutter app, which in our case is named `MyApp`.

### Intro to Widgets
Now, you might be asking: "what's a `Widget`?" -- great question! In Flutter, pretty much everything is a `Widget`. Both layout and UI elements are handled by `Widgets` -- buttons, panes, and text are `Widgets`, but so are layout tools like containers. We'll cover some of these layout `Widgets` soon.

For now, let's take a look at line 6 of `main.dart`:
```dart=6
class MyApp extends StatelessWidget {
```
So even the root of our app is a `Widget`!

Within the `MyApp` class, there is also a `build` method:
```dart=8
@override
Widget build(BuildContext context) {
    return MaterialApp(
        // Application name
        title: 'Studio - Flutter',
        // Application theme data, you can set the colors for the application as
        // you want
        theme: ThemeData(
        primarySwatch: Colors.blue,
        ),
        // A widget which will be started on application startup
        home: MyHomePage(title: 'Studio - Flutter'),
    );
}
```

Every `Widget` has a `build` method -- it's what is called when the `Widget` is created and rendered in your app. Here, we can see that the `build` method of `MyApp` returns a `MaterialApp` with a `title` of `"Studio - Flutter"`, a simple theme, and a home `Widget`. For us, the `Widget` we assign as the home page of our app is `MyHomePage`, which is defined on line 24.

### Making changes
Change the `primarySwatch` color on line 16 from `Colors.blue` to `Colors.brown`, then press the *Hot Reload* button in the top left next to the *Build* button -- it looks like a lightning bolt. Your emulator should update, and you should now see something like this:

![](https://i.imgur.com/zzU67vTl.png)

Notice that just like React, you don't have to fully rebuild or restart your app to see changes take effect!

Let's also change the title that appears in the brown `AppBar` from `"Studio - Flutter"` to `"My Bakery"`. This can be done by changing `home: const MyHomePage(title: 'Studio - Flutter'),` on line 19 to `home: const MyHomePage(title: 'My Bakery'),`

#### Adding content to the page
Our app is a little boring right now... there's no content on the page! Let's add some.

Scroll down to the `build` method of `MyHomePage` on line 29:
```dart=28
@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // The title text which will be shown on the action bar
          title: Text(title),
        );
    );
}
```
Let's add a `body` to our `Scaffold` so that we can put content into the page. We'll add a `Text` `Widget` as the only element in the body:
```dart=28
@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // The title text which will be shown on the action bar
          title: Text(title),
        ),
        body: Text("Welcome to my bakery!")
    );
}
```

Now, you should see something like this:

![](https://i.imgur.com/X4Ywzkdl.png)

#### Manipulating layout

Our page has content now, but it doesn't look too great. Let's say we want to center our welcome text on the page. How would we do that?

Well, we can use layout Widgets! `Center` is a layout widget that, well, centers stuff -- let's try it out!

```dart=28
@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // The title text which will be shown on the action bar
          title: Text(title),
        ),
        body: const Center(child: Text("Welcome to my bakery!")));
}
```

And once you hot reload, you should see something like this:

![](https://i.imgur.com/gaNZ244l.png)

Perfect!

<br />

## Curating our bakery menu
We've now greeted our user as they enter our bakery, but they probably won't be too happy once they see we don't have much to offer! Let's fix that :)

### Menu data

Navigate to `lib/menu_data.dart` -- you should see the following:
```dart=1
final menuItems = [
  {
    "name": "Lemon Cheesecake",
    "price": "3.00",
    "description": "A cheesecake made with fresh lemon juice and milk",
    "imageUrl":
        "https://tmbidigitalassetsazure.blob.core.windows.net/rms3-prod/attachments/37/1200x1200/Lemon-Dream-Cheesecake_EXPS_DIYD20_93312_B07_28_7b.jpg"
  },
  {
    "name": "✨Macaron✨",
    "price": "2.99",
    "description": "A light and fluffy french meringue dessert",
    "imageUrl":
        "https://partylicious.net/wp-content/uploads/2020/04/stack-macarons-pink-white-680-2-min.jpg"
  },
...
```
Here, we have provided you with some sample data that you'll generate bakery menu list items from.

Notice that we store the prices as **strings**, **not doubles!** This will make it easier for your rendering purposes.

We've already imported this data into `main.dart` for you with line 2:
```dart=2
import 'menu_data.dart';
```
You are able to access the data through the `menuItems` variable.

### Creating a basic menu item card
Our goal is to create a view of our bakery's menu, displaying each of the menu items from our data.

We will first create a separate `MenuItem` Widget to encapsulate a view of a single menu item, then we will generate multiple instances of this `MenuItem` Widget for each of the items in our data.

To create this separate `MenuItem` Widget, let's go to the bottom of `main.dart` and define it as such:
```dart
class MenuItem extends StatelessWidget {

}
```
Now, let's add fields for each of the properties the menu item data has:
```dart
class MenuItem extends StatelessWidget {
    final String name;
    final String description;
    final String price;
    final String imageUrl;
}
```
We can now add a constructor for `MenuItem` that has parameters matching these fields:
```dart
class MenuItem extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String imageUrl;
  const MenuItem(
      {Key? key,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl})
      : super(key: key);
}
```
Finally, let's add the `build` method, making sure to mirror the structure in the previous Widget:
```dart 
@override
Widget build(BuildContext context) {
    return Column(
        children: [Text(name), Text(description), Text(price), Image.network(imageUrl)]);
}
```
Here, we render a `Column` of 3 `Text` Widgets and 1 `Image` Widget, displaying each of the properties from our data. `Column`, like `Center`, is a layout Widget; however, unlike `Center` which takes in a single `child` Widget, `Column` takes in a list of `children` Widgets, which it will render in a vertical column.

### Rendering a list from data
To make sure our `MenuItem` Widget works as expected, let's go to line 35 and remove the welcome text and replace it with a `ListView.builder` Widget. Like `Column`, `ListView.builder` is a layout widget that lays elements out in a vertical list. However, `ListView.builder` does not take `children`; instead, it accepts an `itemBuilder` function which returns a Widget. Let's take a look at this in the `MyHomePage` `build` method:
```dart=28
@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // The title text which will be shown on the action bar
          title: Text(title),
        ),
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) => const MenuItem(
                  name: "Steamed Taro Buns",
                  description: "Positively scrumptious",
                  imageUrl:
                      "https://www.ohmyfoodrecipes.com/wp-content/uploads/2022/03/taro-buns-open.jpg",
                  price: "\$2.00",
                )));
}
```
Here, notice that we assign a function which returns a `MenuItem` to `itemBuilder`. `ListView.builder` acts like a JavaScript `map` function or a Java `for` loop: it iterates through a range from `0` to `itemCount`, and for each value in that range, it will call its `itemBuilder` function to generate each element in the list it produces.

Since we have set `itemCount` to 1 and hardcoded in values for the `MenuItem` data, we should only see one menu item in our list:

![](https://i.imgur.com/RR1ah9Xl.png)

This isn't all that interesting (although those buns do look delicious), so let's generate a bunch of menu items from our data!

Instead of hardcoding values for `itemCount` and `MenuItem`, we can index into our `menuItems` variable:
```dart=29
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // The title text which will be shown on the action bar
          title: Text(title),
        ),
        body: ListView.builder(
            itemCount: menuItems.length,
            itemBuilder: (context, index) => MenuItem(
                name: menuItems[index]["name"] ?? "",
                description: menuItems[index]["description"] ?? "",
                imageUrl: menuItems[index]["imageUrl"] ?? "",
                price: menuItems[index]["price"] ?? "")));
}
```
Now, we are pulling values from our data and rendering each of them using the `ListView.builder`! You should now see something like this and be able to scroll through these tantalizing treats:

![](https://i.imgur.com/5SNntoTl.png)

## Beautifying the `MenuItem`
While our baked goods might look fantastic, the way we present them in our UI perhaps isn't quite as good. Let's fix that!

This time, *it's up to you* to decide what exactly to do. As the final step of this studio, take some time to use what you have learned to prettify `MenuItem` as well as the UI in general.

To help you with some of the details, we list below in [Addendum 1](#Addendum-1:-Useful-layout-widgets-and-properties) and [Addendum 2](#Addendum-2:-Useful-styling-widgets-and-properties) many useful built-in Widgets and attributes you can use for layout and styling.

If you think the design you have in mind requires other Widgets or attributes than the ones we list below, check out the [Flutter docs](https://docs.flutter.dev) and feel free to search online!

<br />

## Hand In

Once you are done with ✨beautifying✨ the `MenuItem`, add a screenshot on to the [sync slides](https://docs.google.com/presentation/d/1r9d-8MxLDKNY9N5EE7Xo5wP_DfB2V3X4rL7TkSdcaTA/edit?usp=sharing) of your final app that displays your list of baked goods.

***Please don't forget*** to write your cs login next to the screenshot, as we will use it to check you off.

Deadline for submission is at **12pm ET** on **Monday 28th November 2022**.

<br /><br />

## Addendum 1: Useful layout widgets and properties
---
### `Column` and `Row`
We've seen `Column` before -- we use it to layout the menu item properties within our `MenuItem` Widget.

`Column` expects a `children` list of Widgets, and by default it will render those in a vertical list, with earlier Widgets in the list on top.

`Row` is exactly like `Column` except that its main axis -- the axis on which it lays out items -- is the horizontal axis rather than the vertical one, with earlier Widgets in the list on the left.

However, there are more advanced attributes of `Column` and `Row` you can leverage to adjust spacing, constrain item size, and handle overflow. Let's take a look at some of these.

#### `MainAxisAlignment`
This alignment property allows you to specify how items within a `Column` or `Row` are distributed through the containing space. `MainAxisAlignment` determines the distribution along the main axis of the container. For `Column`, the main axis is the vertical axis. For `Row`, it's the horizontal axis. There are many options, and we'll introduce a few of them here.

##### `MainAxisAlignment.start`

Here, the three `Image` Widgets in the column will begin at the top of the `Column`, and there will be no spacing between them. If there is more space in the parent Widget, the `Image` Widgets will not take up that remaining space. In the corresponding figure below, the `Column` is outlined in red.
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Image.asset('images/pic1.jpg'),
    Image.asset('images/pic2.jpg'),
    Image.asset('images/pic3.jpg'),
  ],
);
```
![](https://i.imgur.com/QX9cBLgm.png)

##### `MainAxisAlignment.end`
This property functions identically to `MainAxisAlignment.start`, except that the items are grouped towards the bottom of the `Column`:

![](https://i.imgur.com/O1eeGZ7m.png)

##### `MainAxisAlignment.spaceEvenly`
This property will distribute free space evenly between items, as well as before the first item and after the last item. 
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Image.asset('images/pic1.jpg'),
    Image.asset('images/pic2.jpg'),
    Image.asset('images/pic3.jpg'),
  ],
);
```
![](https://i.imgur.com/nldLTjcm.png)

##### `MainAxisAlignment.spaceBetween`
This property functions like `spaceEvenly`, except it will not add space before the first item and after the last item.

![](https://i.imgur.com/W8QKMWDm.png)

To see all `MainAxisAlignment` options, check out the docs: https://api.flutter.dev/flutter/rendering/MainAxisAlignment.html

#### `CrossAxisAlignment`
Like `MainAxisAlignment`, this alignment property allows you to specify how items within a `Column` or `Row` are distributed through the containing space. `CrossAxisAlignment` determines the distribution along the cross axis of the container. For `Column`, the cross axis is the horizontal axis. For `Row`, it's the vertical axis.
Some options for `MainAxisAlignment` also apply for `CrossAxisAlignment`, but some do not, and there are also new options specific to `CrossAxisAlignment`.

##### `CrossAxisAlignment.start`
If there is free space along the cross axis in the parent Widget, `start` will align items along the start of the cross axis.
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Image.asset('images/pic1.jpg'),
    Image.asset('images/pic2.jpg'),
    Image.asset('images/pic3.jpg'),
  ],
);
```
![](https://i.imgur.com/80BXHVbm.png)

`CrossAxisAlignment.end` works the same way, except items are aligned to the end of the cross axis (to the right in this example).

##### `CrossAxisAlignment.center`
This is the default value for `CrossAxisAlignment`.
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Image.asset('images/pic1.jpg'),
    Image.asset('images/pic2.jpg'),
    Image.asset('images/pic3.jpg'),
  ],
);
```
![](https://i.imgur.com/nasEABlm.png)

##### `CrossAxisAlignment.stretch`
This property requires items to fill the cross axis, and it may stretch items out (such as images).
```dart
Column(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Image.asset('images/pic1.jpg'),
    Image.asset('images/pic2.jpg'),
    Image.asset('images/pic3.jpg'),
  ],
);
```

![](https://i.imgur.com/v2BwvU9m.png)

<!-- ##### Composing `Column` and `Row`
Let's say you want  -->


<!-- --- -->



## Addendum 2: Useful styling widgets and properties
---
### `BoxDecoration`
`BoxDecoration` is an especially powerful styling widget, and is typically used on the `decoration` attribute of a container:
```dart
...
body: Container(
    decoration: BoxDecoration(
        ...
    )
),
```
For example, if you wanted to add a BoxDecoration to your MenuItem it would be added to the build method in the structure of:

```dart
@override
Widget build(BuildContext context) {
return Scaffold(
        body: Container(
            decoration: BoxDecoration(...),
            child: Center(...)
            )
        )
```
`BoxDecoration` has properties in and of itself, and manipulating them allows you to add unique styling to the underlying container which it is bound to.

#### `image`

```dart
image: DecorationImage(
    image: NetworkImage(imageUrl), fit: BoxFit.cover),
```

![](https://i.imgur.com/X4X3o9Am.png)


#### `border`

```dart
border: Border.all(color: Colors.grey, width: 3),
```

![](https://i.imgur.com/s3u6V9ym.png)

#### `borderRadius`

```dart
borderRadius: BorderRadius.circular(15.0),
```
![](https://i.imgur.com/MZEjxAwm.png)

#### `boxShadow`

```dart
boxShadow: [
               BoxShadow(
                 offset: const Offset(1, 3),
                 blurRadius: 7,
                 color: Colors.black.withOpacity(0.5),
               ),
             ],
```

![](https://i.imgur.com/taFmP7wm.png)

#### `color`

An image/color cannot already be assigned to the BoxDecoration.

```dart
color: const Color(0xffe0a4d9),
```

![](https://i.imgur.com/sJzuvrFm.png)

#### `gradient`

An image/color cannot already be assigned to the BoxDecoration.

```dart
gradient: LinearGradient(
               begin: Alignment.topRight,
               end: Alignment.bottomLeft,
               colors: [
                 Colors.orange,
                 Colors.green,
               ],
             ),
```

![](https://i.imgur.com/qHRS8xqm.png)

---

### `Text`

We have used `Text` before for rendering out our price, description, and name, but there is more we can do with this Widget to manipulate how it looks, namely with the `style` property.

```dart
Text(name,
  style: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    fontSize: 24)),
Text(price,
  style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 24))
```

![](https://i.imgur.com/knjxWmXm.png)

Here you can see that we were able to add the `TextStyle` Widget to the `style` property of the text, giving the `Text` a different `color`, `fontWeight`, `fontStyle`, and `fontSize`. By placing these two `Text` Widgets as the children of a `Column` placed in a `Center`, we were able to achieve this layout.

There is much more you can do with `Text`, `BoxDecoration`, and really any other Widget, so we encourage you to experiment and research on your own!

<br /> <br />
## Credits
Made with ♥ by Dylan Hu, Lauren Choi, Miku Suga, Nick Vadasz (2022 Fall TAs).
