defmodule Metro.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add(:title, :text)
      add(:description, :text)
      add(:images, :string)
      add(:background_image, :string)
      add(:start_time, :naive_datetime)
      add(:end_time, :naive_datetime)
      add(:room_id, references(:rooms, on_delete: :nothing))

      timestamps()
    end

    create(index(:events, [:room_id]))
  end
end
