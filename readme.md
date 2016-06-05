# elm-brownbag

Topic for our monthly engineering brownbag lunch.

Step by step instructions on how to get started with elm.

## Step 0 - Setup the elm platform

This repository includes a Dockerfile to provide an elm environment in the quickest way possible. On the linux host or boot2docker VM run:

`docker build -t elm .`

Once done, we can setup an alias in the shell so we can use it the same way as if it was installed locally.

`alias elm='docker run --rm -it -v $(pwd):/src -p 8000:8000 elm'`

To run elm in the container we simply need to run `elm`.

And you should see the elm platform help message. :)

## Step 1 - Hello World

Elm is a functional programming laguage for the web, so let's start by grabbing the html library from [http://package.elm-lang.org/](http://package.elm-lang.org/):

`elm package install elm-lang/html -y`

For the more observant in the audience you probably noticed it downloaded some dependencies it needs and one of them is `elm-lang/virtual-dom`. To those familiar with React you would know that this is one ingredient in the secret sauce. With it we can have [blazing fast html in elm](http://elm-lang.org/blog/blazing-fast-html)!

Let's start with the obligatory hello world example and gradually introduce elm's syntax.

First let's create a file called `Main.elm`:

`touch Main.elm`

Open the file with a text editor of your choice. On the first line lets import the `text` function from the `Html` package that we installed:

`import Html exposing (text)`

This function takes a String argument and creates a text node to be rendered.

Next we define a `main` function, the entry point for any elm program:

```
main =
  text "Hello, World!"
```

Elm uses the `=` sign to declare functions. This will execute a single statement, a call to the function `text` to show our message in our app.

And that is it! We can now run the example on elm's reactor -- a development tool that loads, compiles and serves elm programs on the browser. Fire it up with:

`elm reactor -a 0.0.0.0`

And access the app on port 8000.

## Step 2 - The Elm Architecture

One of elm's key feature is immutability -- all values cannot be modified after it is created. This has the benefit of making functions stateless, avoiding side effects and making programs easier to reason about. So how do we represent a changing web application's state? Enter: The Elm Architecture

The elm architecture can be quickly describes as a model-view-update pattern.

- **model** is a data structure which represents the current state of the application.
- **view** is a function that takes a model and returns a representation of it to be rendered (in our case html).
- **update** is a function which takes an action/event (or in elm we will call a message) and depending on what kind it is returns a new model that represents the changed state.

Let's start refactoring our main function so we get our model-view-update. Rename `main` to `view` as it is currently producing the Html then call `view` from `main`.

```
view =
  text "Hello, World!"

main =
  view
```

Our greeting will be the state for our app. Let's rip that out of the view and pass it as an argument to our view function.

```
model =
  "Hello, World!"

view model =
  text model

main =
  view model
```

Finally lets provide an update function that, for now, does nothing but return the same model it gets.

```
update msg model =
  model
```

The `Html.App` package has a `beginnerProgram` function which takes exactly these three things and wires them up together. Let's import that `Html.App` package then wire it all together in main:

```
import Html.App exposing (beginnerProgram)

...

main = beginnerProgram {model = model, view = view, update = update}
```

We've moved to the elm architecture but our web app still does the same thing. In the next step we will look into making update respond to events/actions and another key feature of elm: static types!

## Step 3 - Messages and Types

Our Hello, World! example was nice and all but let's now interact with user input and make our `update` function actually update something. We will add a text input box to our view, and a container div, which we can import from the Html package.

```
import Html exposing (div, input, text)

...

view model =
  div [] [
    text model,
    div [] [
      input [] []
    ]
  ]
```

`div` and `input` are also functions which take two arguments: a list of attributes and a list of nodes that they contain. We nest them similar to how we would nest html tags. I must say it translates really well as a HTML Domain Specific Language.

Next we need to also add event handlers. These are available from `Html.Events`, particularly the onInput event is what we want for our text box. This is again a function which takes one argument, the type of action/message that will get passed to the `update` function along with the `model`.

```
import Html.Events exposing (onInput)

...

      input [onInput Greet] []

```

This will call `update` with a `Greet` type message together with the `String` in the input box. We now need to define this as a type of message that gets passed into update:

```
type Message = Greet String
```

We could have placed this anywhere  in the program but it is quite better to put this near our `update` function, as a definition of what tyeps of messages `update` will respond to.

Let's modify the `update` function to use the `Greet` message:

```
update msg model =
  case of msg
    Greet name ->
      "Hello, " ++ name ++ "!"
```

To breakdown what is happening here:

- the event calls `update` with a `Message` and the `model`
- we pattern match on `msg` with the `case` statement
- we define a single pattern, that is: `msg` is a `Greet` type of message
- the other argument is bound to the variable `name`
- which we then concatenate (`++`) to our greeting "Hello"
- the concatenated `String` is returned, and used as the new `model`
