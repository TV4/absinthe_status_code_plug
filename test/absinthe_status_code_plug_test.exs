defmodule AbsintheStatusCodePlugTest do
  use ExUnit.Case
  use Plug.Test

  describe "when response is json and the path is not specified" do
    test "override status code to 400 when the body contains an error" do
      conn =
        conn(:get, "/")
        |> AbsintheStatusCodePlug.call(AbsintheStatusCodePlug.init([]))
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, Jason.encode!(%{errors: []}))

      assert conn.status == 400
    end

    test "keep the status code when the body does not contain an error" do
      conn =
        conn(:get, "/")
        |> AbsintheStatusCodePlug.call(AbsintheStatusCodePlug.init([]))
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, Jason.encode!(%{}))

      assert conn.status == 200
    end
  end

  describe "when response is json and the path is specified" do
    test "override status code to 400 when the body contains an error and the path is included" do
      conn =
        conn(:get, "/")
        |> AbsintheStatusCodePlug.call(AbsintheStatusCodePlug.init(paths: ["login"]))
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, Jason.encode!(%{errors: [%{"path" => ["login"]}]}))

      assert conn.status == 400
    end

    test "keep the status code when the body does not contain an error and the path is excluded" do
      conn =
        conn(:get, "/")
        |> AbsintheStatusCodePlug.call(AbsintheStatusCodePlug.init(paths: ["something"]))
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, Jason.encode!(%{errors: [%{"path" => ["login"]}]}))

      assert conn.status == 200
    end
  end

  test "keep the status code when the response is not json" do
    conn =
      conn(:get, "/")
      |> AbsintheStatusCodePlug.call(AbsintheStatusCodePlug.init([]))
      |> put_resp_header("content-type", "application/html")
      |> send_resp(200, "totally html")

    assert conn.status == 200
  end
end
