defmodule Kontrol.Server.Spec do
  @moduledoc false

  use ESpec

  # doctest Kontrol.Server

  example_group "server start/stop" do
    before do
      {:ok, server} = Kontrol.Server.start_link()
      Kontrol.Server.start_controller(server)
      {:shared, server: server}
    end

    finally(do: Kontrol.Server.stop(shared.server))

    it "the controller actually starts" do
      expect(shared.server) |> to_not(be_nil())
      expect(shared.server) |> to(be_alive())
      expect(Kontrol.Server.controller_started(shared.server)) |> to(be_truthy())
    end
  end

  example_group "controller response" do
    context "for P only" do
      before do
        setpoint = 1.0
        kp = 0.1
        {:ok, server} = Kontrol.Server.start_link(kp: kp)
        Kontrol.Server.start_controller(server)
        Kontrol.Server.set_setpoint(server, setpoint)
        {:shared, server: server, setpoint: setpoint, kp: kp}
      end

      finally do
        Kontrol.Server.stop(shared.server)
      end

      it "pv moves predictably toward setpoint" do
        final_pv =
          Enum.reduce(1..10, 0.0, fn _, pv ->
            cv = Kontrol.Server.get_cv(shared.server, pv)
            expect(cv) |> to(eq((shared.setpoint - pv) * shared.kp))
            pv + cv
          end)

        expect(Float.round(final_pv, 8)) |> to(eq(0.65132156))
      end
    end
  end
end
