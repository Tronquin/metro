defmodule MetroWeb.CardController do
  use MetroWeb, :controller

  alias Metro.Account
  alias Metro.Account.Card

  def index(conn, _params) do
    cards = User.list_cards()
    render(conn, "index.html", cards: cards)
  end

  def new(conn, _params) do
    changeset = User.change_card(%Card{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"card" => card_params}) do
    case User.create_card(card_params) do
      {:ok, card} ->
        conn
        |> put_flash(:info, "Card created successfully.")
        |> redirect(to: card_path(conn, :show, card))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    card = User.get_card!(id)
    render(conn, "show.html", card: card)
  end

  def edit(conn, %{"id" => id}) do
    card = User.get_card!(id)
    changeset = User.change_card(card)
    render(conn, "edit.html", card: card, changeset: changeset)
  end

  def update(conn, %{"id" => id, "card" => card_params}) do
    card = User.get_card!(id)

    case User.update_card(card, card_params) do
      {:ok, card} ->
        conn
        |> put_flash(:info, "Card updated successfully.")
        |> redirect(to: card_path(conn, :show, card))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", card: card, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    card = User.get_card!(id)
    {:ok, _card} = User.delete_card(card)

    conn
    |> put_flash(:info, "Card deleted successfully.")
    |> redirect(to: card_path(conn, :index))
  end
end
