defmodule GitHub.WebhookTest do
  use ExUnit.Case
  use Plug.Test

  alias GitHub.Webhook

  describe "verify_github_signature/2" do
    setup do
      conn =
        conn(:get, "/webhook", %{})
        |> put_req_header("content-type", "application/json")

      %{conn: conn}
    end

    test "requires raw request body", %{conn: conn} do
      assert_raise GitHub.Error, fn ->
        Webhook.verify_github_signature(conn, [])
      end
    end

    test "requires signature header", %{conn: conn} do
      conn =
        conn
        |> assign(:raw_body, "")
        |> Webhook.verify_github_signature([])

      assert conn.halted
      assert conn.resp_body == "Missing signature"
      assert conn.state == :sent
      assert conn.status == 400
    end

    test "requires valid signature", %{conn: conn} do
      conn =
        conn
        |> assign(:raw_body, "{}")
        |> put_req_header("x-hub-signature-256", "garbage")
        |> Webhook.verify_github_signature([])

      assert conn.halted
      assert conn.resp_body == "Invalid signature"
      assert conn.state == :sent
      assert conn.status == 401
    end

    test "passes connection with valid signature", %{conn: conn} do
      body = "{}"

      signature =
        "sha256=" <>
          Base.encode16(:crypto.mac(:hmac, :sha256, "secret123", body), case: :lower)

      conn =
        conn
        |> assign(:raw_body, body)
        |> put_req_header("x-hub-signature-256", signature)
        |> Webhook.verify_github_signature([])

      refute conn.halted
      assert conn.state == :unset
    end
  end
end
