# pandoc-columns

This filter supports the definition of columns in Markdown.

|  PDF sample  |  HTML sample  |
|:------------:|:-------------:|
| ![](pdf.png) | ![](html.png) |

## Installation

This package is available from Hackage, or as a Nix flake.

### From Hackage

To install from Hackage, use [cabal install](https://cabal.readthedocs.io/en/stable/cabal-commands.html#cabal-install).
The package name is `pandoc-columns`.

### As a Nix flake

Note: Flakes must be [enabled](https://nixos.wiki/wiki/Flakes) in your Nix or NixOS installation.

One way to use the Nix flake is to create a `shell.nix` with pandoc and this package, like so:

~~~
with (import <nixpkgs> {});
let
  pandoc-include-plus = (builtins.getFlake git+https://codeberg.org/mhwombat/pandoc-include-plus).packages.${builtins.currentSystem}.default;
in
mkShell {
  buildInputs = [
    pandoc
    pandoc-columns
    # add any other software you want to use in the shell.
  ];
}
~~~

Enter the shell using `nix-shell`.
Now you can use the commands below.

## Defining tables

The Markdown that produced the above outputs is shown below.

    ::: columns
    ::::: column
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
    tempor incididunt ut labore et dolore magna aliqua.

    * Mattis rhoncus urna neque viverra justo.
    * Vitae aliquet nec ullamcorper sit amet risus nullam eget.
    * Quis hendrerit dolor magna eget est lorem ipsum dolor.

    :::::
    ::::: column
    Elementum pulvinar etiam non quam lacus suspendisse faucibus.
    Et malesuada fames ac turpis egestas.
    Imperdiet nulla malesuada pellentesque elit eget gravida.
    Maecenas pharetra convallis posuere morbi leo urna.
    Purus non enim praesent elementum facilisis leo vel fringilla.
    Egestas dui id ornare arcu.

    Feugiat in fermentum posuere urna nec tincidunt praesent semper feugiat.
    Nunc scelerisque viverra mauris in aliquam sem fringilla ut morbi.


    :::::
    ::::: column
    Risus nullam eget felis eget.
    Tincidunt dui ut ornare lectus sit amet est placerat.
    Lobortis mattis aliquam faucibus purus in massa tempor nec feugiat.

    Faucibus vitae aliquet nec ullamcorper sit amet risus.
    Viverra nam libero justo laoreet sit amet cursus.
    :::::
    :::

## Transforming to other formats

You can process your Markdown document either using pandoc directly,
or through Hakyll.

### With Pandoc

Use this filter by adding `--filter=pandoc-columns` to your pandoc command.
For example:

    pandoc --filter=pandoc-linear-table myfile.md --output=myfile.pdf

### With Hakyll

Use this filter as a transform in Hakyll.
For example, you could modify `site.hs`, adding

```
import Text.Pandoc.Filters.Columns (transform)
```

and changing

```
pandocCompiler
```

to

```
pandocCompilerWithTransform defaultHakyllReaderOptions defaultHakyllWriterOptions transform
```

# Related projects

- [columns](https://github.com/dialoa/columns), a Pandoc filter written in Lua
