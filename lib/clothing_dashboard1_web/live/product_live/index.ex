defmodule ClothingDashboard1Web.ProductLive.Index do
  use ClothingDashboard1Web, :live_view

  alias ClothingDashboard1.Catalog
  alias ClothingDashboard1.Catalog.Product

  @impl true
  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(ClothingDashboard1.PubSub, "products")
    {:ok, stream(socket, :products, Catalog.list_products())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Product")
    |> assign(:product, Catalog.get_product!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Product")
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Products")
    |> assign(:product, nil)
  end

  @impl true
  def handle_info({ClothingDashboard1Web.ProductLive.FormComponent, {:saved, product}}, socket) do
    {:noreply, stream_insert(socket, :products, product)}
  end

  def handle_info({:deleted, id}, socket) do
    {:noreply, assign(socket, :products, Enum.reject(socket.assigns.products, &(&1.id == id)))}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    product = Catalog.get_product!(id)
    {:ok, _} = Catalog.delete_product(product)
    Phoenix.PubSub.broadcast(ClothingDashboard1.PubSub, "products", {:deleted, id})

    {:noreply, stream_delete(socket, :products, product)}
  end

  def handle_event("search", %{"value" => search_query}, socket) do
    products = Catalog.search_products(search_query)

    {:noreply, stream(socket, :products, products, reset: true)}
  end

  def handle_event("filter_by_tag", %{"value" => tag}, socket) do
    products =
      Catalog.list_products()
      |> Enum.filter(fn product -> tag in product.tags end)

    {:noreply, assign(socket, :products, products)}
  end
end
