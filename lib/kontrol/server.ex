defmodule Kontrol.Server do
  @moduledoc ~S"""
  A simple controller server.
  """

  use GenServer

  ##
  ## public API
  ##

  @doc ~S"""
  Starts a `Kontrol.Server` process linked to the current process.
  """
  @spec start_link(any()) :: GenServer.on_start()
  def start_link(args \\ []), do: GenServer.start_link(__MODULE__, args, [])

  @doc ~S"""
  Stops a `Kontrol.Server` process.
  """
  @spec stop(GenServer.server(), reason :: term(), timeout()) :: :ok
  def stop(server, reason \\ :normal, timeout \\ :infinity),
    do: GenServer.stop(server, reason, timeout)

  def start_controller(server), do: GenServer.cast(server, :start_controller)
  def stop_controller(server), do: GenServer.cast(server, :stop_controller)
  def controller_started(server), do: GenServer.call(server, :controller_started)

  @doc ~S"""
  Gets the controller state.
  """
  @spec get_controller_state(pid()) :: map()
  def get_controller_state(server), do: GenServer.call(server, :get_controller_state)

  @doc ~S"""
  Sets the value for the setpoint.
  """
  @spec set_setpoint(pid(), float()) :: :ok
  def set_setpoint(server, new_setpoint_value),
    do: GenServer.cast(server, {:new_setpoint, new_setpoint_value})

  @doc ~S"""
  Calculates the controlled value for a given process value.
  """
  @spec get_cv(pid(), float()) :: float()
  def get_cv(server, pv), do: GenServer.call(server, {:get_cv, pv})

  ##
  ## callbacks
  ##

  @doc ~S"""
  Invoked when the server is started.
  """
  def init(args) do
    {
      :ok,
      %{
        controller_started: false,
        controller_state: %{
          kp: Keyword.get(args, :kp, 0.0),
          ki: Keyword.get(args, :ki, 0.0),
          kd: Keyword.get(args, :kd, 0.0)
        },
        setpoint: 0.0
      }
    }
  end

  # def terminate(_reason, nil), do: nil

  def handle_cast(:start_controller, state), do: {:noreply, %{state | controller_started: true}}
  def handle_cast(:stop_controller, state), do: {:noreply, %{state | controller_started: false}}

  def handle_cast({:new_setpoint, new_setpoint_value}, state),
    do: {:noreply, %{state | setpoint: new_setpoint_value}}

  def handle_call(:controller_started, _from, state),
    do: {:reply, state.controller_started, state}

  @doc ~S"""
  Gets the controller state.
  """
  def handle_call(:get_controller_state, _from, %{controller_state: controller_state} = state),
    do: {:reply, controller_state, state}

  def handle_call(
        {:get_cv, pv},
        _from,
        %{setpoint: setpoint, controller_state: controller_state} = state
      ) do
    ev = diff(setpoint, pv)

    cv_p = apply_p(ev, controller_state)
    cv_i = apply_i(ev, controller_state)
    cv_d = apply_d(ev, controller_state)

    {:reply, sum(cv_p, cv_i, cv_d), state}
  end

  defp apply_p(_value, %{kp: nil}), do: nil
  defp apply_p(value, %{kp: kp}), do: value * kp

  defp apply_i(_value, %{ki: nil}), do: nil
  defp apply_i(value, %{ki: _ki}), do: value * 0.0

  defp apply_d(_value, %{kd: nil}), do: nil
  defp apply_d(value, %{kd: _kd}), do: value * 0.0

  defp sum(nil, _, _), do: nil
  defp sum(_, nil, _), do: nil
  defp sum(_, _, nil), do: nil
  defp sum(v1, v2, v3), do: v1 + v2 + v3

  defp diff(nil, _), do: nil
  defp diff(_, nil), do: nil
  defp diff(v1, v2), do: v1 - v2
end
