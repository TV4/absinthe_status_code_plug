defmodule AbsintheStatusCodePlug do
  import Plug.Conn

  @moduledoc """
  Plug that sets status code to 400 when response includes errors.
  """

  def init(opts), do: opts

  def call(conn, _opts) do
    register_before_send(conn, &fix_status_code/1)
  end

  def fix_status_code(conn) do
    case Plug.Conn.get_resp_header(conn, "content-type") do
      ["application/json" <> _] -> fix_status_code(conn, Jason.decode!(conn.resp_body))
      _ -> conn
    end
  end

  defp fix_status_code(conn, %{"errors" => _}) do
    put_status(conn, 400)
  end

  defp fix_status_code(conn, _) do
    conn
  end
end
