defmodule Metro.Repo.Migrations.CreateCheckouts do
  use Ecto.Migration

  def change do
    create table(:checkouts) do
      add :renewals_remaining, :integer
      add :checkout_date, :naive_datetime
      add :checkin_date, :naive_datetime
      add :due_date, :naive_datetime
      add :user_id, references(:users, on_delete: :nothing)
      add :card_id, references(:cards, on_delete: :nothing)
      add :copy_id, references(:copies, on_delete: :nothing)
      add :isbn_id, references(:books, column: :isbn, on_delete: :nothing)
      add :library_id, references(:libraries, on_delete: :nothing)

      timestamps()
    end
    create index(:checkouts, [:user_id])
    create index(:checkouts, [:card_id])
    create index(:checkouts, [:copy_id])
    create index(:checkouts, [:library_id])
    create index(:checkouts, [:isbn_id])
  end
end
