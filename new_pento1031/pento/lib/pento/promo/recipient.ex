defmodule Pento.Promo.Recipient do
  defstruct [:first_name, :email]
  @types %{first_name: :string, email: :string}

  alias Pento.Promo.Recipient
  import Ecto.Changeset

  def changeset(%Recipient{} = user, attrs) do
    {user, @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_required([:first_name, :email])
    |> validate_format(:email, ~r/@/)
  end

  # def test do
  #   alias Pento.Promo.Recipient
  #   r = %Recipient{}
  #   user=%{email: "jenny.hu@scrumcn.com", first_name: "hu"}
  #   user=%{email: "jenny.hu@scrumcn.com", first_name: 1234}
  #   user=%{email: "jenny.huscrumcn.com", first_name: "hu"}
  # Recipient.changeset(r, user)

  # end

end
