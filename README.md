# PlugSecex [![Hex version](https://img.shields.io/hexpm/v/plug_secex.svg "Hex version")](https://hex.pm/packages/plug_secex) ![Hex downloads](https://img.shields.io/hexpm/dt/plug_secex.svg "Hex downloads") [![Build Status](https://semaphoreci.com/api/v1/techgaun/plug_secex/branches/master/badge.svg)](https://semaphoreci.com/techgaun/plug_secex) [![Coverage Status](https://coveralls.io/repos/github/techgaun/plug_secex/badge.svg?branch=master)](https://coveralls.io/github/techgaun/plug_secex?branch=master)

> Plug that adds various HTTP Headers to make Phoenix/Elixir app more secure

## Installation

The package can be installed from hex as:

Add plug_secex to your list of dependencies in `mix.exs`:

```
def deps do
  [{:plug_secex, "~> 0.1.3"}]
end
```

Or you can directly install it from github:

```
def deps do
  [{:plug_secex, github: "techgaun/plug_secex"}]
end
```

## Example

If you are using phoenix, you can put the plug in `web/router.ex`.

    pipeline :browser do
      plug PlugSecex
    end

You can also specify to override or disable particular set of headers.

    pipeline :browser do
      plug PlugSecex,
        overrides: [
          "x-dns-prefetch-control": "on",
          "x-frame-options": "DENY",
          "custom-header": "value"
        ],
        except: [
          "x-powered-by"
        ]
    end

If you need to determine one of these at run time - for instance, in order to
use a content security policy that allows resources from a location
configured in environment variables - you can pass a "module, function,
arguments" tuple; calling that function with those arguments must return a
list as shown in the previous example.

    pipeline :browser do
      plug PlugSecex,
        overrides: {MyModule, :overrides, [arg1, arg2]},
        except: {MyModule, :exceptions, [arg3]}
    end

The supported headers and their values by default are:

    "x-content-type-options": "nosniff",
    "x-dns-prefetch-control": "off",
    "strict-transport-security": "max-age=31536000",
    "x-xss-protection": "1; mode=block",
    "x-frame-options": "SAMEORIGIN",
    "content-security-policy": "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline' 'unsafe-eval'",
    "cross-origin-window-policy": "deny",
    "x-download-options": "noopen",
    "x-permitted-cross-domain-policies": "none"

The headers that are removed by default are:

    "x-powered-by",
    "server"
