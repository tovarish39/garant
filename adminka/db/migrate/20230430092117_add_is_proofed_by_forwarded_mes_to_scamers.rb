class AddIsProofedByForwardedMesToScamers < ActiveRecord::Migration[7.0]
  def change
    add_column :scamers, :is_proofed_by_forwarted_mes, :boolean, default: false
  end
end
