{:ok, _} = Application.ensure_all_started(:ex_machina)
Ecto.Adapters.SQL.Sandbox.mode(WebshopGraphqlApi.Repo, :manual)
ExUnit.start()
