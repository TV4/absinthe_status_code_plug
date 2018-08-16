defmodule AbsintheStatusCodePlugTest do
  use ExUnit.Case
  doctest AbsintheStatusCodePlug

  describe "when body contains an error" do
    test "override status code to 400" do
      conn = %Plug.Conn{resp_body: ~s({"errors": []})}
      conn = AbsintheStatusCodePlug.fix_status_code(conn)
      assert conn.status == 400
    end
  end
end
