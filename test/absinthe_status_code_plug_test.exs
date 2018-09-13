defmodule AbsintheStatusCodePlugTest do
  use ExUnit.Case
  use Plug.Test

  describe "when response is json" do
    test "override status code to 400 when the body contains an error" do
      conn =
        conn(:get, "/")
        |> AbsintheStatusCodePlug.call([])
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, Jason.encode!(%{errors: []}))

      assert conn.status == 400
    end

    test "keep the status code when the body does not contain an error" do
      conn =
        conn(:get, "/")
        |> AbsintheStatusCodePlug.call([])
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, Jason.encode!(%{}))

      assert conn.status == 200
    end
  end

  test "keep the status code when the response is not json" do
    conn =
      conn(:get, "/")
      |> AbsintheStatusCodePlug.call([])
      |> put_resp_header("content-type", "application/html")
      |> send_resp(200, "totally html")

    assert conn.status == 200
  end
end
