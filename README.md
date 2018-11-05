# AbsintheStatusCodePlug

Plug that sets status code to 400 when response includes errors.

## Usage
In your `mix.exs` add:
```
defp deps do
  [
    {:absinthe_status_code_plug, "~> 1.0"}
  ]
```

To set all errors to 400, add the following in your router:
```
plug AbsintheStatusCodePlug
```

You can also limit the plug to only add status code to some paths:
```
plug AbsintheStatusCodePlug, paths: ["login", "reauthenticate"]
```
