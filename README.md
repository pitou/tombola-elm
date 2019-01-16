#tombola-elm

An Elm implementation of the classic Tombola board.

###Dependencies

```
npm install -g elm elm-test uglifyjs
```

###Build the app

```
./make.sh
```

###Run

Just open `index.html` in your browser.

###Build the app in debug mode

If you want to add some `Debug.log`, you cannot use the optimized version of the compiled bundle.

Instead generate a "debug tolerant" bundle using:

```
./make-debug.sh
```

Then you have to include `main.js` instead of `main.min.js` in the `index.html` file.

###Change Grid implementation

To use a `Set` instead of a `Dict`, comment all the rows containing: 

```
import Grid_Dict exposing (..)
```

and uncomment:

```
--import Grid_Set exposing (..)
```


###Run tests

```
elm-test
```
