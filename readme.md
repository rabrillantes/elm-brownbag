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
