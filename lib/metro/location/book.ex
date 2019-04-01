defmodule Metro.Location.Book do
  use Ecto.Schema
  import Ecto.Changeset

  alias Metro.Location.Author
  alias Metro.Location.Copy

  @primary_key {:isbn, :integer, autogenerate: false}
  @derive {Phoenix.Param, key: :isbn}
  schema "books" do
    field :image, :string
    field :title, :string
    field :pages, :integer
    field :summary, :string
    field :year, :integer

    belongs_to :author, Author, foreign_key: :author_id

    has_many :copies, Copy, foreign_key: :isbn_id
    has_many :checkouts, Metro.Order.Checkout

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:isbn, :title, :year, :summary, :pages, :image, :author_id])
    |> unique_constraint(:isbn, name: :books_pkey )
    |> foreign_key_constraint(:author_id)
    |> validate_required([:isbn, :title, :year, :summary, :pages, :image, :author_id])
  end
end
