defmodule Vachan.Crm.Person do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  resource do
    description "A person is a contact in the CRM system."
  end

  postgres do
    table "people"
    repo Vachan.Repo
  end

  code_interface do
    define_for Vachan.Crm

    define :create, action: :create
    define :update, action: :update
    define :destroy, action: :destroy
    define :read_all, action: :read
    define :get_by_id, args: [:id], action: :by_id
  end

  actions do
    defaults [:create, :read, :update, :destroy]

    read :by_id do
      argument :id, :uuid, allow_nil?: false
      get? true
      filter expr(id == ^arg(:id))
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :first_name, :string, allow_nil?: false
    attribute :last_name, :string, allow_nil?: false

    attribute :email, :ci_string do
      allow_nil? false

      constraints match: ~r/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
    end

    attribute :phone, :string do
      allow_nil? true
    end

    attribute :city, :string do
      allow_nil? true
    end

    attribute :state, :string do
      allow_nil? true
    end

    attribute :country, :string do
      allow_nil? true
    end

    attribute :designation, :string do
      allow_nil? true
    end

    attribute :company, :string do
      allow_nil? true
    end

    # TODO: make this a jsonb field, validated against a list of tags in a separate table.
    attribute :tags, :string do
      allow_nil? true
    end
  end

  identities do
    identity :unique_email, [:email]
  end
end
