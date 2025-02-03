defmodule ClothingDashboard1Web.ProductLive.Stats do
  use ClothingDashboard1Web, :live_view
  alias ClothingDashboard1.Catalog

  def mount(_params, _session, socket) do
    month = DateTime.utc_now().month
    stats = fetch_stats(month)
    {:ok, assign(socket, stats: stats)}
  end

  def handle_event("filter_by_month", %{"value" => month}, socket) do
    if month == "" or Regex.match?(~r/\D/, month) do
      monthh = DateTime.utc_now().month
      stats = fetch_stats(monthh)
      {:noreply, assign(socket, stats: stats, reset: true)}
    else
      monthh = String.to_integer(month)

      if monthh < 1 || monthh > 12 do
        stats = fetch_stats(DateTime.utc_now().month)
        {:noreply, assign(socket, stats: stats, reset: true)}
      else
        stats = fetch_stats(monthh)
        {:noreply, assign(socket, stats: stats, reset: true)}
      end
    end
  end

  defp fetch_stats(monthh) do
    products = Catalog.list_products()

    total_stock = Enum.reduce(products, 0, fn p, acc -> acc + p.stock end)

    best_selling =
      Enum.max_by(products, & &1.sold_count, fn -> nil end)

    transactions_per_month =
      Enum.flat_map(products, fn p -> p.transaction_dates end)
      |> Enum.count(fn date -> date.month == monthh end)

    %{
      total_stock: total_stock,
      best_selling: %{title: best_selling.title, count: best_selling.sold_count},
      transactions_per_month: transactions_per_month
    }
  end
end
