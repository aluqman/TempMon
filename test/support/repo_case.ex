defmodule TempMon.RepoCase do
  @moduledoc """
  Module for assisting with leveraging Ecto when running tests for this application.

  Creates a sandbox database for testing data to avoid contaminating the main database.
  """
  use ExUnit.CaseTemplate
  alias Ecto.Adapters.SQL.Sandbox

  using do
    quote do
      alias TempMon.Repo

      import Ecto
      import Ecto.Query
      import TempMon.RepoCase
    end
  end

  setup tags do
    :ok = Sandbox.checkout(TempMon.Repo)

    unless tags[:async] do
      Sandbox.mode(TempMon.Repo, {:shared, self()})
    end

    :ok
  end
end
