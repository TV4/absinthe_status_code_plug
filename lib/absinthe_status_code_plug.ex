defmodule AbsintheStatusCodePlug do
  import Plug.Conn

  @moduledoc """
  Plug that sets status code to 400 when response includes errors.
  """

  def init(opts), do: Keyword.get(opts, :paths, [])

  def call(conn, opts_paths) do
    register_before_send(conn, &fix_status_code(&1, opts_paths))
  end

  def fix_status_code(conn, opts_paths) do
    case Plug.Conn.get_resp_header(conn, "content-type") do
      ["application/json" <> _] ->
        fix_status_code(conn, opts_paths, Jason.decode!(conn.resp_body))

      _ ->
        conn
    end
  end

  defp fix_status_code(conn, [], %{"errors" => _}) do
    put_status(conn, 400)
  end

  defp fix_status_code(conn, opts_paths, %{"errors" => [%{"path" => paths}]}) do
    if Enum.any?(opts_paths, fn path -> path in paths end) do
      put_status(conn, 400)
    else
      conn
    end
  end

  defp fix_status_code(conn, _, _), do: conn
end
