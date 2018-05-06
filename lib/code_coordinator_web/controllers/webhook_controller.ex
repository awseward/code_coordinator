require IEx

defmodule CodeCoordinatorWeb.WebhookController do
  use CodeCoordinatorWeb, :controller

  def handle(conn, params) do
    case try_recognize_event(conn) do
      {:ok, event_type} ->
        try_handle(event_type, params)
        conn |> send_resp(200, "")

      {:error, msg} -> conn |> send_resp(400, msg)
    end
  end

  defp try_recognize_event(conn) do
    case get_req_header(conn, "x-github-event") do
      [event_type] when event_type in ["ping", "pull_request", "pull_request_review_comment", "pull_request_review"] ->
        {:ok, event_type}
      _ ->
        {:error, "Invalid event_type"}
    end
  end

  defp try_handle(event_type, params) do
    case event_type do
      "ping" -> nil
      "pull_request" -> handle_pull_request(params)
      "pull_request_review_comment" -> handle_pull_request_review_comment(params)
      "pull_request_review" -> handle_pull_request_review(params)
    end
  end

  defp handle_pull_request(params) do
    %{"action" => action} = params
    if action == "review_requested" do
      IEx.pry
    end
    IO.puts "Action: #{action}"
  end

  defp handle_pull_request_review_comment(payload) do
  end

  defp handle_pull_request_review(payload) do
  end
end
