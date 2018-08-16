# AbsintheStatusCodePlug

Plug that sets status code to 400 when response includes errors.

## Usage
In your controller or router:
```
plug AbsintheStatusCodePlug
```
and in your `mix.exs` add:
```
defp deps do
  [
    {:absinthe_status_code_plug, "~> 1.0"}
  ]
```
