migration 1, :add_filetype_to_recordings  do
  up do
    modify_table(:recordings) do
      add_column :filetype, String, :length => 8, :nullable => true
      drop_column :directory
    end
  end

  down do
    drop_column :filetype
  end
end
