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
