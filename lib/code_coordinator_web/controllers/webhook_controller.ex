require IEx

defmodule CodeCoordinatorWeb.WebhookController do
  use CodeCoordinatorWeb, :controller

  def handle(conn, _params) do
    case try_recognize_event(conn) do
      {:ok, _event_type} ->
        send_resp(conn, 200, "")
      {:error, msg} ->
        send_resp(conn, 400, msg)
    end
  end

  defp try_recognize_event(conn) do
    case get_req_header(conn, "x-github-event") do
      [event_type] when event_type in ["pull_request", "pull_request_review_comment", "pull_request_review"] ->
        {:ok, event_type}
      _ ->
        {:error, "Invalid event_type"}
    end
  end
end
