defmodule TempMon.RepoCase do
	use ExUnit.CaseTemplate

	using do
		quote do
			alias TempMon.Repo

			import Ecto
			import Ecto.Query
			import TempMon.RepoCase
		end
	end

	setup tags do
		:ok = Ecto.Adapters.SQL.Sandbox.checkout(TempMon.Repo)

		unless tags[:async] do
			Ecto.Adapters.SQL.Sandbox.mode(TempMon.Repo, {:shared, self()})
		end
		:ok
	end
end
