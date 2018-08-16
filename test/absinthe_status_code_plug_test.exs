defmodule AbsintheStatusCodePlugTest do
  use ExUnit.Case
  use Plug.Test

  describe "when body contains an error" do
    test "override status code to 400" do
      conn =
        conn(:get, "/", resp_body: %{errors: []})
        |> AbsintheStatusCodePlug.call([])
        |> send_resp(200, ~s({"errors": []}))

      assert conn.status == 400
    end
  end
end
